// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGroup _$ItemGroupFromJson(Map<String, dynamic> json) {
  return ItemGroup(
    name: json['name'] as String,
    primary: json['primary'] as bool? ?? false,
    items: (json['items'] as List<dynamic>?)?.map((e) => e as String).toList(),
    group: (json['group'] as List<dynamic>?)
        ?.map((e) => ItemGroup.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ItemGroupToJson(ItemGroup instance) => <String, dynamic>{
      'name': instance.name,
      'primary': instance.primary,
      'items': instance.items,
      'group': instance.group,
    };
