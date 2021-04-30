// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penguin_stats_drop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PenguinStatsDrop _$PenguinStatsDropFromJson(Map<String, dynamic> json) {
  return PenguinStatsDrop(
    stageId: json['stageId'] as String,
    itemId: json['itemId'] as String,
    quantity: json['quantity'] as int,
    times: json['times'] as int,
    start: json['start'] as int,
  );
}

Map<String, dynamic> _$PenguinStatsDropToJson(PenguinStatsDrop instance) =>
    <String, dynamic>{
      'stageId': instance.stageId,
      'itemId': instance.itemId,
      'quantity': instance.quantity,
      'times': instance.times,
      'start': instance.start,
    };
