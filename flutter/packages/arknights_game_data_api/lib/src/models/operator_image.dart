import 'package:json_annotation/json_annotation.dart';

part 'operator_image.g.dart';

@JsonSerializable()
class OperatorImage {
  const OperatorImage({
    required this.name,
    required this.headUrls,
    required this.imageUrls,
  });

  factory OperatorImage.fromJson(Map<String, dynamic> json) =>
      _$OperatorImageFromJson(json);
  Map<String, dynamic> toJson() => _$OperatorImageToJson(this);

  final String name;
  @JsonKey(name: "heads")
  final List<String> headUrls;
  @JsonKey(name: "images")
  final List<String> imageUrls;
}
