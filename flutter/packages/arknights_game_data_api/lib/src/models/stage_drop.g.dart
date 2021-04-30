// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_drop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StageDrop _$StageDropFromJson(Map<String, dynamic> json) {
  return StageDrop(
    displayRewards: (json['displayRewards'] as List<dynamic>)
        .map((e) => StageDropDisplayReward.fromJson(e as Map<String, dynamic>))
        .toList(),
    displayDetailRewards: (json['displayDetailRewards'] as List<dynamic>)
        .map((e) => StageDropDisplayReward.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StageDropToJson(StageDrop instance) => <String, dynamic>{
      'displayRewards': instance.displayRewards,
      'displayDetailRewards': instance.displayDetailRewards,
    };
