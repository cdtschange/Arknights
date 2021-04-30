// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_best_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemBestStage _$ItemBestStageFromJson(Map<String, dynamic> json) {
  return ItemBestStage(
    name: json['name'] as String,
    totalBest:
        (json['totalBest'] as List<dynamic>).map((e) => e as String).toList(),
    singleBest:
        (json['singleBest'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ItemBestStageToJson(ItemBestStage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'totalBest': instance.totalBest,
      'singleBest': instance.singleBest,
    };
