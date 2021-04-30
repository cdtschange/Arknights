import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_factory.g.dart';

@JsonSerializable()
class ItemFactory extends Equatable {
  const ItemFactory({
    required this.name,
    required this.amount,
    required this.cost,
    required this.inputs,
    required this.extraOutcomeRate,
    required this.extraOutcome,
  });

  factory ItemFactory.fromJson(Map<String, dynamic> json) =>
      _$ItemFactoryFromJson(json);

  final String name;
  @JsonKey(defaultValue: 1)
  final int amount;
  @JsonKey(defaultValue: 0)
  final int cost;
  final Map<String, int> inputs;
  @JsonKey(defaultValue: 0)
  final double extraOutcomeRate;
  @JsonKey(defaultValue: {})
  final Map<String, double> extraOutcome;

  @override
  List<Object?> get props =>
      [name, amount, cost, inputs, extraOutcomeRate, extraOutcome];
}
