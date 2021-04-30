import 'package:json_annotation/json_annotation.dart';

part 'skill_level.g.dart';

@JsonSerializable()
class SkillLevel {
  const SkillLevel({
    required this.name,
    required this.description,
    required this.skillType,
  });

  factory SkillLevel.fromJson(Map<String, dynamic> json) => _$SkillLevelFromJson(json);
  Map<String, dynamic> toJson() => _$SkillLevelToJson(this);

  final String name;
  final String description;
  final int skillType;
}
