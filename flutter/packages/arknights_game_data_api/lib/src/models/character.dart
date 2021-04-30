import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  const Character({
    required this.name,
    required this.description,
    required this.canUseGeneralPotentialItem,
    required this.potentialItemId,
    required this.nationId,
    required this.groupId,
    required this.teamId,
    required this.displayNumber,
    required this.tokenKey,
    required this.appellation,
    required this.position,
    required this.tagList,
    required this.itemUsage,
    required this.itemDesc,
    required this.itemObtainApproach,
    required this.isNotObtainable,
    required this.isSpChar,
    required this.maxPotentialLevel,
    required this.rarity,
    required this.profession,
    required this.phases,
    required this.skills,
    required this.allSkillLvlup,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  final String name;
  @JsonKey(defaultValue: "")
  final String description;
  @JsonKey(defaultValue: false)
  final bool canUseGeneralPotentialItem;
  @JsonKey(defaultValue: "")
  final String potentialItemId;
  @JsonKey(defaultValue: "")
  final String nationId;
  @JsonKey(defaultValue: "")
  final String groupId;
  @JsonKey(defaultValue: "")
  final String teamId;
  @JsonKey(defaultValue: "")
  final String displayNumber;
  @JsonKey(defaultValue: "")
  final String tokenKey;
  @JsonKey(defaultValue: "")
  final String appellation;
  @JsonKey(defaultValue: "")
  final String position;
  @JsonKey(defaultValue: [])
  final List<String> tagList;
  @JsonKey(defaultValue: "")
  final String itemUsage;
  @JsonKey(defaultValue: "")
  final String itemDesc;
  @JsonKey(defaultValue: "")
  final String itemObtainApproach;
  @JsonKey(defaultValue: false)
  final bool isNotObtainable;
  @JsonKey(defaultValue: false)
  final bool isSpChar;
  @JsonKey(defaultValue: 0)
  final int maxPotentialLevel;
  @JsonKey(defaultValue: 0)
  final int rarity;
  @JsonKey(defaultValue: "")
  final String profession;
  @JsonKey(defaultValue: [])
  final List<CharacterPhase> phases;
  @JsonKey(defaultValue: [])
  final List<CharacterSkill> skills;
  @JsonKey(defaultValue: [])
  final List<CharacterSkillLevelupCost> allSkillLvlup;
}
