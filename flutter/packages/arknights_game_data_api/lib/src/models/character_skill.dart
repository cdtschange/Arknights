import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'character_skill.g.dart';

@JsonSerializable()
class CharacterSkill {
  const CharacterSkill({
    required this.skillId,
    required this.levelUpCostCond,
  });

  factory CharacterSkill.fromJson(Map<String, dynamic> json) =>
      _$CharacterSkillFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterSkillToJson(this);

  @JsonKey(defaultValue: "")
  final String skillId;
  @JsonKey(defaultValue: [])
  final List<CharacterSkillLevelupCost> levelUpCostCond;
}
