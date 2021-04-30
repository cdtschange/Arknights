import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'skill.g.dart';

@JsonSerializable()
class Skill {
  const Skill({
    required this.skillId,
    required this.levels,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);

  final String skillId;
  final List<SkillLevel> levels;
}
