import 'package:json_annotation/json_annotation.dart';

part 'penguin_stats_drop.g.dart';

@JsonSerializable()
class PenguinStatsDrop {
  const PenguinStatsDrop({
    required this.stageId,
    required this.itemId,
    required this.quantity,
    required this.times,
    required this.start,
  });

  factory PenguinStatsDrop.fromJson(Map<String, dynamic> json) =>
      _$PenguinStatsDropFromJson(json);
  Map<String, dynamic> toJson() => _$PenguinStatsDropToJson(this);

  final String stageId;
  final String itemId;
  final int quantity;
  final int times;
  final int start;
}
