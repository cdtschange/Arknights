import 'package:equatable/equatable.dart';
import 'package:item_repository/item_repository.dart';
import 'package:stage_repository/src/model/models.dart';
import 'package:collection/collection.dart';

class Stage extends Equatable {
  const Stage({
    required this.stageId,
    required this.stageType,
    required this.difficulty,
    required this.levelId,
    required this.zoneId,
    required this.code,
    required this.name,
    required this.description,
    required this.dangerLevel,
    required this.apCost,
    required this.stageDropInfo,
  });

  final String stageId;
  final String stageType;
  final String difficulty;
  final String levelId;
  final String zoneId;
  final String code;
  final String name;
  final String? description;
  final String? dangerLevel;
  final int apCost;
  final StageDrop? stageDropInfo;

  @override
  List<Object?> get props => [
        stageId,
        stageType,
        difficulty,
        levelId,
        zoneId,
        code,
        name,
        description,
        dangerLevel,
        apCost,
        stageDropInfo
      ];

  @override
  String toString() {
    return "[$code]$name";
  }

  bool get isMainStage {
    return !code.startsWith("TR");
  }

  bool get isStageTypeMainOrSub {
    return stageType == "MAIN" || stageType == "SUB";
  }

  String get displayName {
    return "$code $name";
  }

  bool isFirst(List<Stage> stages) {
    final zoneStages = stages.where((e) => e.zoneId == zoneId).toList();
    return zoneStages.where((e) => e.isMainStage == isMainStage).first == this;
  }

  bool isLast(List<Stage> stages) {
    final zoneStages = stages.where((e) => e.zoneId == zoneId).toList();
    return zoneStages.where((e) => e.isMainStage == isMainStage).last == this;
  }

  Stage? previous(List<Stage> stages) {
    final zoneStages = stages.where((e) => e.zoneId == zoneId).toList();
    final list = zoneStages.where((e) => e.isMainStage == isMainStage).toList();
    final index = list.indexOf(this);
    if (index > 0) {
      return list[index - 1];
    }
    return null;
  }

  Stage? nextStage(List<Stage> stages) {
    final zoneStages = stages.where((e) => e.zoneId == zoneId).toList();
    final list = zoneStages.where((e) => e.isMainStage == isMainStage).toList();
    final index = list.indexOf(this);
    if (index < list.length - 1) {
      return list[index + 1];
    }
    return null;
  }

  List<ItemDrop>? get fixItemDrops {
    return stageDropInfo?.displayRewards
        .where((e) =>
            ((stageType == "MAIN" && e.type == "MATERIAL") ||
                (stageType != "MAIN" &&
                    (e.type == "MATERIAL" || e.type == "GOLD"))) &&
            e.dropType == 2)
        .map((e) => ItemDrop(
            itemId: e.id, stageId: stageId, quantity: 1, times: 1, start: 0))
        .toList();
  }

  List<ItemDrop> drops(List<ItemDrop> itemDrops, List<Item> items) {
    final extraDrops = itemDrops
        .where((e) =>
            e.stageId == stageId &&
            items.firstWhereOrNull((i) => i.itemId == e.itemId) != null)
        .where((e) {
      final item = items.firstWhere((i) => i.itemId == e.itemId);
      return isStageTypeMainOrSub
          ? (item.itemType == "MATERIAL" && item.classifyType == "MATERIAL")
          : (item.itemType == "MATERIAL" ||
              item.classifyType == "MATERIAL" ||
              item.itemType == "GOLD");
    }).toList();

    final dropIds = extraDrops.map((i) => i.itemId);
    var drops = extraDrops;
    drops
        .addAll((fixItemDrops ?? []).where((e) => !dropIds.contains(e.itemId)));
    drops.sort((a, b) => b.rate.compareTo(a.rate));
    return drops;
  }

  List<ItemDrop> mainDrops(List<ItemDrop> itemDrops, List<Item> items) {
    final dropItems = drops(itemDrops, items);
    final drops1 = dropItems.where((e) {
      final item = items.firstWhere((i) => i.itemId == e.itemId);
      return (item.rarity > 1 && e.rate > 0.1) || (item.rarity > 2);
    }).toList();
    if (drops1.length > 0) {
      return drops1.take(3).toList();
    }
    var drops2 = dropItems.where((e) {
      final item = items.firstWhere((i) => i.itemId == e.itemId);
      return item.rarity > 0 && e.rate > 0.1 || (item.rarity > 2);
    }).toList();
    return drops2.take(3).toList();
  }
}

extension ItemStage on Item {
  List<Stage> stages(List<ItemDrop> itemDrops, List<Stage> stages) {
    if (name == "赤金") {
      return [];
    }
    final fixDropStage = stages
        .where((e) =>
            e.stageDropInfo?.displayRewards.firstWhereOrNull(
                (r) => r.id == itemId && r.type == "MATERIAL") !=
            null)
        .toList();

    if (classifyType != "MATERIAL" &&
        itemType != "MATERIAL" &&
        itemType != "GOLD") {
      return fixDropStage;
    }
    var drops = itemDrops
        .where((e) =>
            e.itemId == itemId &&
            stages.firstWhereOrNull((s) => s.stageId == e.stageId) != null)
        .toList();

    drops.sort((a, b) => b.rate.compareTo(a.rate));
    final list = drops
        .map((e) => stages.firstWhere((s) => s.stageId == e.stageId))
        .toList();
    final stageIds = list.map((e) => e.stageId);
    fixDropStage.addAll(list.where((e) => !stageIds.contains(e.stageId)));
    return list;
  }
}

extension ItemDropCost on ItemDrop {
  double apCost(Stage stage) {
    return rate == 0 ? double.nan : 1 / rate * stage.apCost;
  }
}
