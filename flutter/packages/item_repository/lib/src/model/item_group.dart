import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_group.g.dart';

@JsonSerializable()
class ItemGroup extends Equatable {
  const ItemGroup({
    required this.name,
    required this.primary,
    required this.items,
    required this.group,
  });

  factory ItemGroup.fromJson(Map<String, dynamic> json) =>
      _$ItemGroupFromJson(json);

  final String name;
  @JsonKey(defaultValue: false)
  final bool primary;
  final List<String>? items;
  final List<ItemGroup>? group;

  @override
  List<Object?> get props => [name, primary, items, group];
}
