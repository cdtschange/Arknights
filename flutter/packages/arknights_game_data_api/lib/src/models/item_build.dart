import 'package:json_annotation/json_annotation.dart';

part 'item_build.g.dart';

@JsonSerializable()
class ItemBuild {
  const ItemBuild({
    required this.roomType,
    required this.formulaId,
  });

  factory ItemBuild.fromJson(Map<String, dynamic> json) =>
      _$ItemBuildFromJson(json);
  Map<String, dynamic> toJson() => _$ItemBuildToJson(this);

  final String roomType;
  final String formulaId;
}
