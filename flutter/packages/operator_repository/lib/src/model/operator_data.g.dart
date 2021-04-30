// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperatorData _$OperatorDataFromJson(Map<String, dynamic> json) {
  return OperatorData(
    name: json['name'] as String,
    have: json['have'] as bool,
    elite: json['elite'] as int,
    level: json['level'] as int,
    rankLevel: json['rankLevel'] as int,
    skillLevel:
        (json['skillLevel'] as List<dynamic>).map((e) => e as int).toList(),
    protential: json['protential'] as int,
    skin: json['skin'] as int,
  );
}

Map<String, dynamic> _$OperatorDataToJson(OperatorData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'have': instance.have,
      'elite': instance.elite,
      'level': instance.level,
      'rankLevel': instance.rankLevel,
      'skillLevel': instance.skillLevel,
      'protential': instance.protential,
      'skin': instance.skin,
    };
