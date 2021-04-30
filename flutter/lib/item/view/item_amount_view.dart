import 'package:flutter/material.dart';
import 'package:item_repository/item_repository.dart';

class ItemAmountView extends StatelessWidget {
  final Item item;
  final int amount;
  final double imageSize;
  final double fontSize;
  final VoidCallback onTap;

  const ItemAmountView(
      {Key? key,
      required this.item,
      required this.amount,
      required this.imageSize,
      required this.fontSize,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: item.image),
          Text(
            amount.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          )
        ],
      ),
    );
  }
}
