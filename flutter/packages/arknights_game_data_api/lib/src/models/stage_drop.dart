import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'stage_drop.g.dart';

@JsonSerializable()
class StageDrop {
  const StageDrop({
    required this.displayRewards,
    required this.displayDetailRewards,
  });

  factory StageDrop.fromJson(Map<String, dynamic> json) =>
      _$StageDropFromJson(json);
  Map<String, dynamic> toJson() => _$StageDropToJson(this);

  final List<StageDropDisplayReward> displayRewards;
  final List<StageDropDisplayReward> displayDetailRewards;
}
