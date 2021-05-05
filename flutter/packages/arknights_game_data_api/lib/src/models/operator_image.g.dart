// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperatorImage _$OperatorImageFromJson(Map<String, dynamic> json) {
  return OperatorImage(
    name: json['name'] as String,
    headUrls: (json['heads'] as List<dynamic>).map((e) => e as String).toList(),
    imageUrls:
        (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$OperatorImageToJson(OperatorImage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'heads': instance.headUrls,
      'images': instance.imageUrls,
    };
