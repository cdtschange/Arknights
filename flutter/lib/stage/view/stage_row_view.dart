import 'package:arknights/item/view/view.dart';
import 'package:arknights/model/image_resource.dart';
import 'package:flutter/material.dart';
import 'package:item_repository/item_repository.dart';
import 'package:stage_repository/stage_repository.dart';

class StageRowView extends StatelessWidget {
  final Stage stage;
  final List<Item> items;
  final List<ItemDrop> itemDrops;
  final VoidCallback onTap;

  const StageRowView(
      {Key? key,
      required this.stage,
      required this.items,
      required this.itemDrops,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: ListTile(
          onTap: onTap,
          leading: _leadingImage(context),
          trailing:
              Row(mainAxisSize: MainAxisSize.min, children: _trailingImages()),
          title: Text(stage.displayName, style: TextStyle(fontSize: 16)),
        ));
  }

  Widget _leadingImage(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          Container(
              child: Image(
                  color: Theme.of(context).primaryColor,
                  image: AssetImage(ImageResource.iconOperation))),
          Positioned(
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                Container(width: 12, height: 12, child: Item.apImage),
                Text(
                  stage.apCost.toString(),
                  style: TextStyle(fontSize: 8),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _trailingImages() {
    List<Widget> list = [];
    stage.mainDrops(itemDrops, items).forEach((e) {
      final item = items.firstWhere((i) => i.itemId == e.itemId);
      list.add(ItemRateView(
        item: item,
        rate: e.rate * 100,
        imageSize: 40,
        fontSize: 10,
      ));
    });
    return list;
  }
}
