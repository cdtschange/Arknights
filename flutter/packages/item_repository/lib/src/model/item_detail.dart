import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ItemDetail extends Equatable {
  const ItemDetail({
    required this.itemId,
    required this.name,
    required this.description,
    required this.rarity,
    required this.iconId,
    required this.sortId,
    required this.usage,
    required this.obtainApproach,
    required this.classifyType,
    required this.itemType,
  });

  final String itemId;
  final String name;
  final String description;
  final int rarity;
  final String iconId;
  final int sortId;
  final String usage;
  final String? obtainApproach;
  final String classifyType;
  final String itemType;

  @override
  List<Object?> get props => [
        itemId,
        name,
        description,
        rarity,
        iconId,
        sortId,
        usage,
        obtainApproach,
        classifyType,
        itemType
      ];

  Image get image => Image(
      image: AssetImage("assets/images/$name.png", package: "item_repository"));

  @override
  String toString() {
    return "[$itemId]$name";
  }
}
