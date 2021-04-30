// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_skill_levelup_cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterSkillLevelupCost _$CharacterSkillLevelupCostFromJson(
    Map<String, dynamic> json) {
  return CharacterSkillLevelupCost(
    lvlUpTime: json['lvlUpTime'] as int? ?? 0,
    levelUpCost: (json['levelUpCost'] as List<dynamic>?)
        ?.map((e) => ItemCost.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CharacterSkillLevelupCostToJson(
        CharacterSkillLevelupCost instance) =>
    <String, dynamic>{
      'lvlUpTime': instance.lvlUpTime,
      'levelUpCost': instance.levelUpCost,
    };
