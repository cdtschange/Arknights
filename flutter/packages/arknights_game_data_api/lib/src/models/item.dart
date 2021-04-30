import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  const Item({
    required this.itemId,
    required this.name,
    required this.description,
    required this.rarity,
    required this.iconId,
    required this.sortId,
    required this.usage,
    required this.obtainApproach,
    required this.classifyType,
    required this.itemType,
    required this.stageDropList,
    required this.buildingProductList,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  final String itemId;
  final String name;
  final String description;
  final int rarity;
  final String iconId;
  final int sortId;
  final String usage;
  final String? obtainApproach;
  final String classifyType;
  final String itemType;
  final List<ItemStageDrop> stageDropList;
  final List<ItemBuild> buildingProductList;
}
