import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Item extends Equatable {
  const Item({
    required this.itemId,
    required this.name,
    required this.itemType,
    required this.classifyType,
    required this.rarity,
  });

  final String itemId;
  final String name;
  final String itemType;
  final String classifyType;
  final int rarity;

  @override
  List<Object?> get props => [itemId, name, itemType, classifyType, rarity];

  Image get image => Image(
      image: AssetImage("assets/images/$name.png", package: "item_repository"));

  static Image get apImage => Image(
      image: AssetImage("assets/images/理智.png", package: "item_repository"));

  @override
  String toString() {
    return "[$itemId]$name";
  }
}
