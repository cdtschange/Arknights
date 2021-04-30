// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_factory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemFactory _$ItemFactoryFromJson(Map<String, dynamic> json) {
  return ItemFactory(
    name: json['name'] as String,
    amount: json['amount'] as int? ?? 1,
    cost: json['cost'] as int? ?? 0,
    inputs: Map<String, int>.from(json['inputs'] as Map),
    extraOutcomeRate: (json['extraOutcomeRate'] as num?)?.toDouble() ?? 0,
    extraOutcome: (json['extraOutcome'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, (e as num).toDouble()),
        ) ??
        {},
  );
}

Map<String, dynamic> _$ItemFactoryToJson(ItemFactory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'cost': instance.cost,
      'inputs': instance.inputs,
      'extraOutcomeRate': instance.extraOutcomeRate,
      'extraOutcome': instance.extraOutcome,
    };
