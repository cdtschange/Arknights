import 'dart:convert';

import 'package:arknights_game_data_api/arknights_game_data_api.dart'
    as arknightsGameDataApi;
import 'package:stage_repository/src/model/models.dart';

import 'package:stage_repository/stage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseFailure implements Exception {
  final String message;
  BaseFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

class ZoneFailure extends BaseFailure {
  ZoneFailure({required String message}) : super(message: message);
}

class StageFailure extends BaseFailure {
  StageFailure({required String message}) : super(message: message);
}

class StageRepository {
  StageRepository(
      {arknightsGameDataApi.ArknightsGameDataApiClient? arknightsGameDataClient,
      SharedPreferences? prefs})
      : _arknightsGameDataApiClient = arknightsGameDataClient ??
            arknightsGameDataApi.ArknightsGameDataApiClient();

  final arknightsGameDataApi.ArknightsGameDataApiClient
      _arknightsGameDataApiClient;
  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs!;
  }

  Future<T> _requestAndStoreData<T>(
      {required String key,
      required Future<T> Function() request,
      required Object Function(T) objectToJson}) async {
    final data = await request();
    final prefs = await _getPrefs();
    prefs.setString(key, json.encode(objectToJson(data)));
    return data;
  }

  Future _refreshData<T>(
      {required String key,
      required Future<T> Function() request,
      required Object Function(T) objectToJson}) async {
    try {
      await _requestAndStoreData<T>(
          key: key, request: request, objectToJson: objectToJson);
      print('update $key from api sucessfully');
    } catch (e) {
      print('update $key from api failed: $e');
    }
  }

  Future<T> _fetchDataWithStore<T>(
      {required String key,
      required Future<T> Function() request,
      required Object Function(T) objectToJson,
      required T Function(Object) jsonToObject,
      bool refresh = false}) async {
    final prefs = await _getPrefs();
    final cache = prefs.get(key);
    if (cache != null && cache is String) {
      final objects = jsonToObject(jsonDecode(cache));
      if (refresh) {
        _refreshData(key: key, request: request, objectToJson: objectToJson);
      }
      return objects;
    }
    return await _requestAndStoreData(
        key: key, request: request, objectToJson: objectToJson);
  }

  Future<List<Zone>> fetchZones(bool refresh) async {
    try {
      final zones = await _fetchDataWithStore<List<arknightsGameDataApi.Zone>>(
          key: "zone_table",
          request: () async {
            final zones = await _arknightsGameDataApiClient.zoneTable();
            return zones
                .where((e) => ["MAINLINE", "WEEKLY"].contains(e.type))
                .toList();
          },
          objectToJson: (obj) {
            return obj.map((e) => e.toJson()).toList();
          },
          jsonToObject: (json) {
            return (json as List)
                .map((e) => arknightsGameDataApi.Zone.fromJson(
                    e as Map<String, dynamic>))
                .toList();
          },
          refresh: refresh);
      return zones.map((e) => e.toZone).toList();
    } catch (e) {
      throw ZoneFailure(message: e.toString());
    }
  }

  Future<List<Stage>> fetchStages(bool refresh) async {
    try {
      final stages =
          await _fetchDataWithStore<List<arknightsGameDataApi.Stage>>(
              key: "stage_table",
              request: () async {
                final stages = await _arknightsGameDataApiClient.stageTable();

                return stages
                    .where((e) =>
                        (!e.stageId.endsWith("#f#") &&
                            e.isStageTypeMainOrSub) ||
                        e.stageType == "DAILY")
                    .toList();
              },
              objectToJson: (obj) {
                return obj.map((e) => e.toJson()).toList();
              },
              jsonToObject: (json) {
                return (json as List)
                    .map((e) => arknightsGameDataApi.Stage.fromJson(
                        e as Map<String, dynamic>))
                    .toList();
              },
              refresh: refresh);
      return stages.map((e) => e.toStage).toList();
    } catch (e) {
      throw ZoneFailure(message: e.toString());
    }
  }
}

extension on arknightsGameDataApi.Zone {
  Zone get toZone {
    return Zone(
        zoneID: zoneID,
        zoneIndex: zoneIndex,
        type: type,
        zoneNameFirst: zoneNameFirst,
        zoneNameSecond: zoneNameSecond);
  }
}

extension on arknightsGameDataApi.Stage {
  Stage get toStage {
    return Stage(
        stageId: stageId,
        stageType: stageType,
        difficulty: difficulty,
        levelId: levelId,
        zoneId: zoneId,
        code: code,
        name: name,
        description: description,
        dangerLevel: dangerLevel,
        apCost: apCost,
        stageDropInfo: stageDropInfo?.toStageDrop);
  }
}

extension on arknightsGameDataApi.StageDrop {
  StageDrop get toStageDrop {
    return StageDrop(
        displayRewards:
            displayRewards.map((e) => e.toStageDropDisplayReward).toList(),
        displayDetailRewards: displayDetailRewards
            .map((e) => e.toStageDropDisplayReward)
            .toList());
  }
}

extension on arknightsGameDataApi.StageDropDisplayReward {
  StageDropDisplayReward get toStageDropDisplayReward {
    return StageDropDisplayReward(
        id: id, type: type, dropType: dropType, occPercent: occPercent);
  }
}
