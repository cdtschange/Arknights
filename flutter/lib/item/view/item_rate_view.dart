import 'package:flutter/material.dart';
import 'package:item_repository/item_repository.dart';
import 'package:sprintf/sprintf.dart';

class ItemRateView extends StatelessWidget {
  final Item item;
  final double rate;
  final double imageSize;
  final double fontSize;
  final VoidCallback? onTap;

  const ItemRateView(
      {Key? key,
      required this.item,
      required this.rate,
      required this.imageSize,
      required this.fontSize,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: imageSize,
            height: imageSize,
            child: TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: item.image)),
        Text(
          sprintf("%.1f%", [rate]),
          style: TextStyle(fontSize: fontSize),
        )
      ],
    );
  }
}
