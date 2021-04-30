import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:penguin_stats_api/penguin_stats_api.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('PenguinStatsApiClient', () {
    late http.Client httpClient;
    late PenguinStatsApiClient penguinStatsApiClient;

    setUpAll(() {
      registerFallbackValue<Uri>(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      penguinStatsApiClient = PenguinStatsApiClient(httpClient: httpClient);
    });

    group('fetchDropMatrix', () {
      test('makes correct http request and get drop matrix', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
            '{"matrix":[{"stageId":"randomMaterialRune_0","itemId":"30093","quantity":221,"times":3031,"start":1585598400000},{"stageId":"randomMaterialRune_0","itemId":"30073","quantity":299,"times":3031,"start":1585598400000}]}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final drops = await penguinStatsApiClient.dropMatrix();
        verify(
          () => httpClient.get(
            Uri.https('penguin-stats.io',
                '/PenguinStats/api/v2/result/matrix?server=CN'),
          ),
        ).called(1);
        expect(drops.length == 2, true);
      });

      test('throws DropMatrixRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await penguinStatsApiClient.dropMatrix(),
          throwsA(isA<DropMatrixRequestFailure>()),
        );
      });

      test('throws DropMatrixRequestFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await penguinStatsApiClient.dropMatrix(),
          throwsA(isA<DropMatrixRequestFailure>()),
        );
      });

      test('throws DropMatrixRequestFailure on invalid json response',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"data": {}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await penguinStatsApiClient.dropMatrix(),
          throwsA(isA<DropMatrixRequestFailure>()),
        );
      });
    });
  });
}
