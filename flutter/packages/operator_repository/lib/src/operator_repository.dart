import 'dart:convert';

import 'package:arknights_game_data_api/arknights_game_data_api.dart'
    as arknightsGameDataApi;
import 'package:operator_repository/src/model/models.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart' show rootBundle;

class BaseFailure implements Exception {
  final String message;
  BaseFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

class OperatorFailure extends BaseFailure {
  OperatorFailure({required String message}) : super(message: message);
}

class SkillFailure extends BaseFailure {
  SkillFailure({required String message}) : super(message: message);
}

class OperatorImageFailure extends BaseFailure {
  OperatorImageFailure({required String message}) : super(message: message);
}

class OperatorDataFailure extends BaseFailure {
  OperatorDataFailure({required String message}) : super(message: message);
}

class OperatorRepository {
  OperatorRepository(
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

  Future<List<Operator>> fetchOperators({required bool refresh}) async {
    try {
      final operators =
          await _fetchDataWithStore<List<arknightsGameDataApi.Character>>(
              key: "character_table",
              request: () async {
                final opers =
                    await _arknightsGameDataApiClient.characterTable();
                return opers
                    .where((e) =>
                        e.potentialItemId.startsWith("p_char") &&
                        !e.name.startsWith("预备干员") &&
                        e.name != "Stormeye" &&
                        e.name != "Sharp" &&
                        e.name != "Pith" &&
                        e.name != "Touch")
                    .toList();
              },
              objectToJson: (obj) {
                return obj.map((e) => e.toJson()).toList();
              },
              jsonToObject: (json) {
                return (json as List)
                    .map((e) => arknightsGameDataApi.Character.fromJson(e))
                    .toList();
              },
              refresh: refresh);
      return operators.map((e) => e.toOperator).toList();
    } catch (e) {
      throw OperatorFailure(message: e.toString());
    }
  }

  Future<List<Skill>> fetchSkills({required bool refresh}) async {
    try {
      final skills =
          await _fetchDataWithStore<List<arknightsGameDataApi.Skill>>(
              key: "skill_table",
              request: () async {
                return _arknightsGameDataApiClient.skillTable();
              },
              objectToJson: (obj) {
                return obj.map((e) => e.toJson()).toList();
              },
              jsonToObject: (json) {
                return (json as List)
                    .map((e) => arknightsGameDataApi.Skill.fromJson(e))
                    .toList();
              },
              refresh: refresh);

      final content = await rootBundle.loadString(
          'packages/operator_repository/assets/jsons/operator_skill.json');
      final json = jsonDecode(content) as Map;
      return skills
          .map((e) => e.toSkill)
          .map((e) => e.copyWith(imageUrl: json[e.name]))
          .toList();
    } catch (e) {
      throw SkillFailure(message: e.toString());
    }
  }

  Future<List<OperatorImage>> fetchOperatorImages() async {
    try {
      final content = await rootBundle.loadString(
          'packages/operator_repository/assets/jsons/operator_image.json');
      final json = jsonDecode(content) as Map;

      if (json.isEmpty) {
        throw OperatorImageFailure(message: 'Json invalid');
      }
      final items = json.entries.map((e) {
        final value = e.value;
        value['name'] = e.key;
        return OperatorImage.fromJson(value);
      }).toList();
      return items;
    } catch (e) {
      throw OperatorImageFailure(message: e.toString());
    }
  }

  String get _operatorDataStoreKey => "operator_data";
  Future updateOperatorData(OperatorData operatorData) async {
    final data = await fetchOperatorData();
    data.removeWhere((e) => e.name == operatorData.name);
    data.add(operatorData);
    final prefs = await _getPrefs();
    prefs.setString(_operatorDataStoreKey,
        json.encode(data.map((e) => e.toJson()).toList()));
  }

  Future<List<OperatorData>> fetchOperatorData() async {
    try {
      final prefs = await _getPrefs();
      if (!prefs.containsKey(_operatorDataStoreKey)) {
        return [];
      }
      final content = prefs.getString(_operatorDataStoreKey) ?? "";
      final json = jsonDecode(content) as List<dynamic>;

      if (json.isEmpty) {
        throw OperatorDataFailure(message: 'Json invalid');
      }
      return json.map((e) => OperatorData.fromJson(e)).toList();
    } catch (e) {
      throw OperatorDataFailure(message: e.toString());
    }
  }
}

extension on arknightsGameDataApi.Character {
  Operator get toOperator {
    return Operator(
        name: name,
        description: description,
        nationId: nationId,
        groupId: groupId,
        teamId: teamId,
        displayNumber: displayNumber,
        appellation: appellation,
        position: position,
        tagList: tagList,
        itemUsage: itemUsage,
        itemDesc: itemDesc,
        maxPotentialLevel: maxPotentialLevel,
        rarity: rarity,
        isSpChar: isSpChar,
        profession: profession,
        skills: skills.map((e) => e.skillId).toList());
  }
}

extension on arknightsGameDataApi.Skill {
  Skill get toSkill {
    return Skill(
        id: skillId,
        name: levels.first.name,
        description: levels.first.description);
  }
}
