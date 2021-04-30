import 'package:json_annotation/json_annotation.dart';

part 'item_stage_drop.g.dart';

@JsonSerializable()
class ItemStageDrop {
  const ItemStageDrop({
    required this.stageId,
    required this.occPer,
  });

  factory ItemStageDrop.fromJson(Map<String, dynamic> json) =>
      _$ItemStageDropFromJson(json);
  Map<String, dynamic> toJson() => _$ItemStageDropToJson(this);

  final String stageId;
  final String occPer;
}
