import 'package:json_annotation/json_annotation.dart';

part 'stage_drop_display_reward.g.dart';

@JsonSerializable()
class StageDropDisplayReward {
  const StageDropDisplayReward({
    required this.type,
    required this.id,
    required this.dropType,
    required this.occPercent,
  });

  factory StageDropDisplayReward.fromJson(Map<String, dynamic> json) =>
      _$StageDropDisplayRewardFromJson(json);
  Map<String, dynamic> toJson() => _$StageDropDisplayRewardToJson(this);

  final String type;
  final String id;
  final int dropType;
  final int? occPercent;
}
