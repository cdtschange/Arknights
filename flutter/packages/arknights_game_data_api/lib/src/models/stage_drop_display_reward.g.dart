// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_drop_display_reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StageDropDisplayReward _$StageDropDisplayRewardFromJson(
    Map<String, dynamic> json) {
  return StageDropDisplayReward(
    type: json['type'] as String,
    id: json['id'] as String,
    dropType: json['dropType'] as int,
    occPercent: json['occPercent'] as int?,
  );
}

Map<String, dynamic> _$StageDropDisplayRewardToJson(
        StageDropDisplayReward instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'dropType': instance.dropType,
      'occPercent': instance.occPercent,
    };
