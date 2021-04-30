// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillLevel _$SkillLevelFromJson(Map<String, dynamic> json) {
  return SkillLevel(
    name: json['name'] as String,
    description: json['description'] as String,
    skillType: json['skillType'] as int,
  );
}

Map<String, dynamic> _$SkillLevelToJson(SkillLevel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'skillType': instance.skillType,
    };
