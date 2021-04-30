// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_phase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterPhase _$CharacterPhaseFromJson(Map<String, dynamic> json) {
  return CharacterPhase(
    characterPrefabKey: json['characterPrefabKey'] as String? ?? '',
    rangeId: json['rangeId'] as String? ?? '',
    maxLevel: json['maxLevel'] as int? ?? 0,
    evolveCost: (json['evolveCost'] as List<dynamic>?)
            ?.map((e) => ItemCost.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$CharacterPhaseToJson(CharacterPhase instance) =>
    <String, dynamic>{
      'characterPrefabKey': instance.characterPrefabKey,
      'rangeId': instance.rangeId,
      'maxLevel': instance.maxLevel,
      'evolveCost': instance.evolveCost,
    };
