// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    itemId: json['itemId'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    rarity: json['rarity'] as int,
    iconId: json['iconId'] as String,
    sortId: json['sortId'] as int,
    usage: json['usage'] as String,
    obtainApproach: json['obtainApproach'] as String?,
    classifyType: json['classifyType'] as String,
    itemType: json['itemType'] as String,
    stageDropList: (json['stageDropList'] as List<dynamic>)
        .map((e) => ItemStageDrop.fromJson(e as Map<String, dynamic>))
        .toList(),
    buildingProductList: (json['buildingProductList'] as List<dynamic>)
        .map((e) => ItemBuild.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'name': instance.name,
      'description': instance.description,
      'rarity': instance.rarity,
      'iconId': instance.iconId,
      'sortId': instance.sortId,
      'usage': instance.usage,
      'obtainApproach': instance.obtainApproach,
      'classifyType': instance.classifyType,
      'itemType': instance.itemType,
      'stageDropList': instance.stageDropList,
      'buildingProductList': instance.buildingProductList,
    };
