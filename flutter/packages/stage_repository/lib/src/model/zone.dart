import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Zone extends Equatable {
  const Zone({
    required this.zoneID,
    required this.zoneIndex,
    required this.type,
    required this.zoneNameFirst,
    required this.zoneNameSecond,
  });

  final String zoneID;
  final int zoneIndex;
  final String type;
  final String? zoneNameFirst;
  final String? zoneNameSecond;

  @override
  List<Object?> get props =>
      [zoneID, zoneIndex, type, zoneNameFirst, zoneNameSecond];

  @override
  String toString() {
    return "[$zoneID]$displayName";
  }

  bool get isMainLine {
    return type == "MAINLINE";
  }

  String get displayName {
    return zoneNameFirst == null
        ? zoneNameSecond ?? ""
        : (zoneNameSecond == null
            ? zoneNameFirst ?? ""
            : "$zoneNameFirst $zoneNameSecond");
  }

  Image get image => Image(
      image:
          AssetImage("assets/images/$zoneID.png", package: "stage_repository"));

  static final Map<String, List<String>> groupNames = {
    "主线关卡": [
      "main_0",
      "main_1",
      "main_2",
      "main_3",
      "main_4",
      "main_5",
      "main_6",
      "main_7",
      "main_8"
    ],
    "物资筹备": ["weekly_5", "weekly_6", "weekly_7", "weekly_8", "weekly_9"],
    "芯片搜索": ["weekly_1", "weekly_2", "weekly_3", "weekly_4"]
  };
}
