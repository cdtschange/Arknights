import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'character_skill_levelup_cost.g.dart';

@JsonSerializable()
class CharacterSkillLevelupCost {
  const CharacterSkillLevelupCost({
    required this.lvlUpTime,
    List<ItemCost>? levelUpCost,
    List<ItemCost>? lvlUpCost,
  })  : this._levelUpCost = levelUpCost,
        this._lvlUpCost = lvlUpCost;

  factory CharacterSkillLevelupCost.fromJson(Map<String, dynamic> json) =>
      _$CharacterSkillLevelupCostFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterSkillLevelupCostToJson(this);

  @JsonKey(defaultValue: 0)
  final int lvlUpTime;
  @JsonKey(name: "levelUpCost")
  final List<ItemCost>? _levelUpCost;
  @JsonKey(name: "lvlUpCost")
  final List<ItemCost>? _lvlUpCost;

  List<ItemCost>? get levelUpCost {
    return _levelUpCost ?? _lvlUpCost;
  }
}
