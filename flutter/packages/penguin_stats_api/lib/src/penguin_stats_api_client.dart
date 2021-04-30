import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:penguin_stats_api/penguin_stats_api.dart';

/// Exception thrown when fetch drop matrix fails.
class DropMatrixRequestFailure implements Exception {
  final String message;
  DropMatrixRequestFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

/// {@template penguin_stats_api_client}
/// API Client which wraps the [PenguinStats API](https://penguin-stats.io).
/// {@endtemplate}
class PenguinStatsApiClient {
  /// {@macro penguin_stats_api_client}
  PenguinStatsApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'penguin-stats.io';
  final http.Client _httpClient;

  /// Fetch drop matrix [List<PenguinStatsDrop>] `/PenguinStats/api/v2/result/matrix?server=CN`.
  Future<List<PenguinStatsDrop>> dropMatrix() async {
    final request = Uri.https(
        _baseUrl, '/PenguinStats/api/v2/result/matrix', {'server': 'CN'});
    try {
      final response = await _httpClient.get(request);
      if (response.statusCode != 200) {
        throw DropMatrixRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.isEmpty) {
        throw DropMatrixRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final lines = json['matrix'] as List;
      return lines.map((e) => PenguinStatsDrop.fromJson(e)).toList();
    } catch (e) {
      throw DropMatrixRequestFailure(message: e.toString());
    }
  }
}
