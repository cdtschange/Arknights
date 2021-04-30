// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterSkill _$CharacterSkillFromJson(Map<String, dynamic> json) {
  return CharacterSkill(
    skillId: json['skillId'] as String? ?? '',
    levelUpCostCond: (json['levelUpCostCond'] as List<dynamic>?)
            ?.map((e) =>
                CharacterSkillLevelupCost.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$CharacterSkillToJson(CharacterSkill instance) =>
    <String, dynamic>{
      'skillId': instance.skillId,
      'levelUpCostCond': instance.levelUpCostCond,
    };
