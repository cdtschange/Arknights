import 'dart:convert';

import 'package:arknights_game_data_api/arknights_game_data_api.dart'
    as arknightsGameDataApi;
import 'package:item_repository/src/model/models.dart';
import 'package:penguin_stats_api/penguin_stats_api.dart' as penguinStatsApi;

import 'package:item_repository/item_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class BaseFailure implements Exception {
  final String message;
  BaseFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

class ItemFailure extends BaseFailure {
  ItemFailure({required String message}) : super(message: message);
}

class ItemGroupFailure extends BaseFailure {
  ItemGroupFailure({required String message}) : super(message: message);
}

class ItemDetailFailure extends BaseFailure {
  ItemDetailFailure({required String message}) : super(message: message);
}

class ItemBestStageFailure extends BaseFailure {
  ItemBestStageFailure({required String message}) : super(message: message);
}

class ItemDropFailure extends BaseFailure {
  ItemDropFailure({required String message}) : super(message: message);
}

class ItemFactoryFailure extends BaseFailure {
  ItemFactoryFailure({required String message}) : super(message: message);
}

class ItemRepository {
  ItemRepository(
      {arknightsGameDataApi.ArknightsGameDataApiClient? arknightsGameDataClient,
      penguinStatsApi.PenguinStatsApiClient? penguinStatsApiClient,
      SharedPreferences? prefs})
      : _arknightsGameDataApiClient = arknightsGameDataClient ??
            arknightsGameDataApi.ArknightsGameDataApiClient(),
        _penguinStatsApiClient =
            penguinStatsApiClient ?? penguinStatsApi.PenguinStatsApiClient();

  final arknightsGameDataApi.ArknightsGameDataApiClient
      _arknightsGameDataApiClient;
  final penguinStatsApi.PenguinStatsApiClient _penguinStatsApiClient;
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

  Future<List<arknightsGameDataApi.Item>> _fetchGameDataItems(
      {required bool refresh}) {
    return _fetchDataWithStore<List<arknightsGameDataApi.Item>>(
        key: "item_table",
        request: () async {
          var items = await _arknightsGameDataApiClient.itemTable();
          return items
              .where((e) =>
                  !e.name.endsWith("的信物") &&
                  !e.name.endsWith("新年寻访凭证") &&
                  e.name != "沃伦姆德搜查令" &&
                  e.name != "特勤专家寻访凭证" &&
                  e.name != "寻访数据契约" &&
                  e.name != "事相结晶" &&
                  !["AP_ITEM", "ACTIVITY_ITEM", "ACTIVITY_COIN", "ET_STAGE"]
                      .contains(e.itemType))
              .toList();
        },
        objectToJson: (obj) {
          return obj.map((e) => e.toJson()).toList();
        },
        jsonToObject: (json) {
          return (json as List)
              .map((e) =>
                  arknightsGameDataApi.Item.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        refresh: refresh);
  }

  Future<List<Item>> fetchItems(bool refresh) async {
    try {
      final items = await _fetchGameDataItems(refresh: refresh);
      return items.map((e) => e.toItem).toList();
    } catch (e) {
      throw ItemFailure(message: e.toString());
    }
  }

  Future<List<ItemDetail>> fetchItemDetails() async {
    try {
      final items = await _fetchGameDataItems(refresh: false);
      return items.map((e) => e.toItemDetail).toList();
    } catch (e) {
      throw ItemDetailFailure(message: e.toString());
    }
  }

  Future<List<ItemGroup>> fetchItemGroups({bool isPrimary = true}) async {
    try {
      final content = await rootBundle
          .loadString('packages/item_repository/assets/jsons/item_group.json');
      final json = jsonDecode(content) as Map<String, dynamic>;

      if (json.isEmpty) {
        throw ItemGroupFailure(message: 'Json invalid');
      }
      final groupsMap = json['group'] as List;
      final groups = groupsMap.map((e) => ItemGroup.fromJson(e)).toList();
      return isPrimary ? groups.where((e) => e.primary).toList() : groups;
    } catch (e) {
      throw ItemGroupFailure(message: e.toString());
    }
  }

  Future<List<ItemBestStage>> fetchItemBestStage() async {
    try {
      final content = await rootBundle.loadString(
          'packages/item_repository/assets/jsons/item_best_stage.json');
      final json = jsonDecode(content) as List<dynamic>;

      if (json.isEmpty) {
        throw ItemBestStageFailure(message: 'Json invalid');
      }
      return json.map((e) => ItemBestStage.fromJson(e)).toList();
    } catch (e) {
      throw ItemBestStageFailure(message: e.toString());
    }
  }

  Future<List<ItemDrop>> fetchItemDrops({bool refresh = false}) async {
    try {
      final itemDrops =
          await _fetchDataWithStore<List<penguinStatsApi.PenguinStatsDrop>>(
              key: "item_drop_matrix",
              request: () async {
                return _penguinStatsApiClient.dropMatrix();
              },
              objectToJson: (obj) {
                return obj.map((e) => e.toJson()).toList();
              },
              jsonToObject: (json) {
                return (json as List)
                    .map((e) => penguinStatsApi.PenguinStatsDrop.fromJson(
                        e as Map<String, dynamic>))
                    .toList();
              },
              refresh: refresh);
      return itemDrops.map((e) => e.toItemDrop).toList();
    } catch (e) {
      throw ItemDropFailure(message: e.toString());
    }
  }

  Future<List<ItemFactory>> fetchItemFactory() async {
    try {
      final content = await rootBundle.loadString(
          'packages/item_repository/assets/jsons/item_factory.json');
      final json = jsonDecode(content) as List<dynamic>;

      if (json.isEmpty) {
        throw ItemFactoryFailure(message: 'Json invalid');
      }
      return json.map((e) => ItemFactory.fromJson(e)).toList();
    } catch (e) {
      throw ItemFactoryFailure(message: e.toString());
    }
  }
}

extension on arknightsGameDataApi.Item {
  Item get toItem {
    return Item(
        itemId: itemId,
        name: name,
        itemType: itemType,
        classifyType: classifyType,
        rarity: rarity);
  }

  ItemDetail get toItemDetail {
    return ItemDetail(
        itemId: itemId,
        name: name,
        description: description,
        rarity: rarity,
        iconId: iconId,
        sortId: sortId,
        usage: usage,
        obtainApproach: obtainApproach,
        classifyType: classifyType,
        itemType: itemType);
  }
}

extension on penguinStatsApi.PenguinStatsDrop {
  ItemDrop get toItemDrop {
    return ItemDrop(
        stageId: stageId,
        itemId: itemId,
        quantity: quantity,
        times: times,
        start: start);
  }
}
