import 'package:json_annotation/json_annotation.dart';

part 'item_cost.g.dart';

@JsonSerializable()
class ItemCost {
  const ItemCost({
    required this.id,
    required this.count,
    required this.type,
  });

  factory ItemCost.fromJson(Map<String, dynamic> json) =>
      _$ItemCostFromJson(json);
  Map<String, dynamic> toJson() => _$ItemCostToJson(this);

  @JsonKey(defaultValue: "")
  final String id;
  @JsonKey(defaultValue: 0)
  final int count;
  @JsonKey(defaultValue: "")
  final String type;
}
