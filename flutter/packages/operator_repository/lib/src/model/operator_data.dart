import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operator_data.g.dart';

@JsonSerializable()
class OperatorData extends Equatable {
  const OperatorData({
    required this.name,
    required this.have,
    required this.elite,
    required this.level,
    required this.rankLevel,
    required this.skillLevel,
    required this.protential,
    required this.skin,
  });

  OperatorData.fromName(this.name)
      : have = false,
        elite = 0,
        level = 1,
        rankLevel = 1,
        skillLevel = [],
        protential = 0,
        skin = 0;

  factory OperatorData.fromJson(Map<String, dynamic> json) =>
      _$OperatorDataFromJson(json);
  Map<String, dynamic> toJson() => _$OperatorDataToJson(this);

  final String name;
  final bool have;
  final int elite;
  final int level;
  final int rankLevel;
  final List<int> skillLevel;
  final int protential;
  final int skin;

  @override
  List<Object?> get props => [
        name,
        elite,
        level,
        rankLevel,
        skillLevel,
        protential,
        skin,
      ];

  OperatorData copyWith(
      {bool? have,
      int? elite,
      int? level,
      int? rankLevel,
      List<int>? skillLevel,
      int? protential,
      int? skin}) {
    return OperatorData(
      name: name,
      have: have ?? this.have,
      elite: elite ?? this.elite,
      level: level ?? this.level,
      rankLevel: rankLevel ?? this.rankLevel,
      skillLevel: skillLevel ?? this.skillLevel,
      protential: protential ?? this.protential,
      skin: skin ?? this.skin,
    );
  }

  static int maxLevel = 90;
  static int minLevel = 1;
  static int maxElite = 2;
  static int minElite = 0;
  static int maxRankLevel = 7;
  static int minRankLevel = 1;
  static int maxSkillLevel = 3;
  static int minSkillLevel = 0;

  Image get eliteImage => Image(
      image: AssetImage("assets/images/elite/icon_elite_$elite.png",
          package: "operator_repository"));

  @override
  String toString() {
    return name;
  }
}
