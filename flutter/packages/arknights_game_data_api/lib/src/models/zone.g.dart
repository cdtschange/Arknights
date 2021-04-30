// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zone _$ZoneFromJson(Map<String, dynamic> json) {
  return Zone(
    zoneID: json['zoneID'] as String,
    zoneIndex: json['zoneIndex'] as int,
    type: json['type'] as String,
    zoneNameFirst: json['zoneNameFirst'] as String?,
    zoneNameSecond: json['zoneNameSecond'] as String?,
    zoneNameTitleCurrent: json['zoneNameTitleCurrent'] as String?,
    zoneNameTitleUnCurrent: json['zoneNameTitleUnCurrent'] as String?,
    zoneNameTitleEx: json['zoneNameTitleEx'] as String?,
    zoneNameThird: json['zoneNameThird'] as String?,
    lockedText: json['lockedText'] as String?,
    canPreview: json['canPreview'] as bool,
  );
}

Map<String, dynamic> _$ZoneToJson(Zone instance) => <String, dynamic>{
      'zoneID': instance.zoneID,
      'zoneIndex': instance.zoneIndex,
      'type': instance.type,
      'zoneNameFirst': instance.zoneNameFirst,
      'zoneNameSecond': instance.zoneNameSecond,
      'zoneNameTitleCurrent': instance.zoneNameTitleCurrent,
      'zoneNameTitleUnCurrent': instance.zoneNameTitleUnCurrent,
      'zoneNameTitleEx': instance.zoneNameTitleEx,
      'zoneNameThird': instance.zoneNameThird,
      'lockedText': instance.lockedText,
      'canPreview': instance.canPreview,
    };
