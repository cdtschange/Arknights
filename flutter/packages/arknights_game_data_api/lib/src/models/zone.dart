import 'package:json_annotation/json_annotation.dart';

part 'zone.g.dart';

@JsonSerializable()
class Zone {
  const Zone({
    required this.zoneID,
    required this.zoneIndex,
    required this.type,
    required this.zoneNameFirst,
    required this.zoneNameSecond,
    required this.zoneNameTitleCurrent,
    required this.zoneNameTitleUnCurrent,
    required this.zoneNameTitleEx,
    required this.zoneNameThird,
    required this.lockedText,
    required this.canPreview,
  });

  factory Zone.fromJson(Map<String, dynamic> json) => _$ZoneFromJson(json);
  Map<String, dynamic> toJson() => _$ZoneToJson(this);

  final String zoneID;
  final int zoneIndex;
  final String type;
  final String? zoneNameFirst;
  final String? zoneNameSecond;
  final String? zoneNameTitleCurrent;
  final String? zoneNameTitleUnCurrent;
  final String? zoneNameTitleEx;
  final String? zoneNameThird;
  final String? lockedText;
  final bool canPreview;
}
