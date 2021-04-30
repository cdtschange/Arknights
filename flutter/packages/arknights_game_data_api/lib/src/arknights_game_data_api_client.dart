import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:arknights_game_data_api/arknights_game_data_api.dart';

/// Exception thrown when fetch items fails.
class ItemsRequestFailure implements Exception {
  final String message;
  ItemsRequestFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

/// Exception thrown when fetch stages fails.
class StagesRequestFailure implements Exception {
  final String message;
  StagesRequestFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

/// Exception thrown when fetch zones fails.
class ZonesRequestFailure implements Exception {
  final String message;
  ZonesRequestFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

/// Exception thrown when fetch characters fails.
class CharactersRequestFailure implements Exception {
  final String message;
  CharactersRequestFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

/// Exception thrown when fetch skills fails.
class SkillsRequestFailure implements Exception {
  final String message;
  SkillsRequestFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

/// {@template arknights_game_data_api_client}
/// API Client which wraps the [ArknightsGameData API](https://raw.githubusercontent.com).
/// {@endtemplate}
class ArknightsGameDataApiClient {
  /// {@macro arknights_game_data_api_client}
  ArknightsGameDataApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'raw.githubusercontent.com';
  final http.Client _httpClient;

  /// Fetch items [List<Item>] `/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/item_table.json`.
  Future<List<Item>> itemTable() async {
    final request = Uri.https(_baseUrl,
        '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/item_table.json');
    try {
      final response = await _httpClient.get(request);
      if (response.statusCode != 200) {
        throw ItemsRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.isEmpty) {
        throw ItemsRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final itemsMap = json['items'] as Map;
      return itemsMap.values.map((e) => Item.fromJson(e)).toList();
    } catch (e) {
      throw ItemsRequestFailure(message: e.toString());
    }
  }

  /// Fetch stages [List<Stage>] `/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/stage_table.json`.
  Future<List<Stage>> stageTable() async {
    final request = Uri.https(_baseUrl,
        '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/stage_table.json');
    try {
      final response = await _httpClient.get(request);
      if (response.statusCode != 200) {
        throw StagesRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.isEmpty) {
        throw StagesRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final stagesMap = json['stages'] as Map;
      return stagesMap.values.map((e) => Stage.fromJson(e)).toList();
    } catch (e) {
      throw StagesRequestFailure(message: e.toString());
    }
  }

  /// Fetch zones [List<Zone>] `/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/zone_table.json`.
  Future<List<Zone>> zoneTable() async {
    final request = Uri.https(_baseUrl,
        '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/zone_table.json');
    try {
      final response = await _httpClient.get(request);
      if (response.statusCode != 200) {
        throw ZonesRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.isEmpty) {
        throw ZonesRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final zonesMap = json['zones'] as Map;
      return zonesMap.values.map((e) => Zone.fromJson(e)).toList();
    } catch (e) {
      throw ZonesRequestFailure(message: e.toString());
    }
  }

  /// Fetch characters [List<Character>] `/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/character_table.json`.
  Future<List<Character>> characterTable() async {
    final request = Uri.https(_baseUrl,
        '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/character_table.json');
    try {
      final response = await _httpClient.get(request);
      if (response.statusCode != 200) {
        throw CharactersRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.isEmpty) {
        throw CharactersRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      return json.values.map((e) => Character.fromJson(e)).toList();
    } catch (e) {
      throw CharactersRequestFailure(message: e.toString());
    }
  }

  /// Fetch skills [List<Skill>] `/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/skill_table.json`.
  Future<List<Skill>> skillTable() async {
    final request = Uri.https(_baseUrl,
        '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/skill_table.json');
    try {
      final response = await _httpClient.get(request);
      if (response.statusCode != 200) {
        throw SkillsRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.isEmpty) {
        throw SkillsRequestFailure(
            message: 'Request failed: ${response.toString()}');
      }
      return json.values.map((e) => Skill.fromJson(e)).toList();
    } catch (e) {
      throw SkillsRequestFailure(message: e.toString());
    }
  }
}
