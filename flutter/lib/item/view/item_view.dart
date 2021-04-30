import 'package:flutter/material.dart';
import 'package:item_repository/item_repository.dart';

class ItemView extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;
  ItemView({required this.item, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(3, 0, 3, 10),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.all(2),
            elevation: 2,
            backgroundColor: Colors.white),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(3), child: item.image),
              Container(
                  child: Text(
                item.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black87, fontSize: 10),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
