// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCost _$ItemCostFromJson(Map<String, dynamic> json) {
  return ItemCost(
    id: json['id'] as String? ?? '',
    count: json['count'] as int? ?? 0,
    type: json['type'] as String? ?? '',
  );
}

Map<String, dynamic> _$ItemCostToJson(ItemCost instance) => <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'type': instance.type,
    };
