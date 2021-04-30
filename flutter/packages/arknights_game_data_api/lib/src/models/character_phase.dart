import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'character_phase.g.dart';

@JsonSerializable()
class CharacterPhase {
  const CharacterPhase({
    required this.characterPrefabKey,
    required this.rangeId,
    required this.maxLevel,
    required this.evolveCost,
  });

  factory CharacterPhase.fromJson(Map<String, dynamic> json) =>
      _$CharacterPhaseFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterPhaseToJson(this);

  @JsonKey(defaultValue: "")
  final String characterPrefabKey;
  @JsonKey(defaultValue: "")
  final String rangeId;
  @JsonKey(defaultValue: 0)
  final int maxLevel;
  @JsonKey(defaultValue: [])
  final List<ItemCost> evolveCost;
}
