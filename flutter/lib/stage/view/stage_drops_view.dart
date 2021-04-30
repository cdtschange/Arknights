import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:item_repository/item_repository.dart';
import 'package:stage_repository/stage_repository.dart';
import 'package:sprintf/sprintf.dart';

class StageDropsView extends StatelessWidget {
  final Stage stage;
  final List<ItemDrop> itemDrops;
  final List<Item> items;
  final void Function(Item) itemOnTap;

  const StageDropsView(
      {Key? key,
      required this.stage,
      required this.itemDrops,
      required this.items,
      required this.itemOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemDrops.length == 0
        ? Container()
        : InfoCard(
            title: "掉落",
            child: Column(
              children: [
                SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        '物品',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '掉落率',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '单件理智',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  )
                ]),
                Divider(),
                _itemDropsView()
              ],
            ),
          );
  }

  Widget _itemDropsView() {
    List<ItemDrop> drops = stage.drops(itemDrops, items);
    return ListView.separated(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          final drop = drops[index];
          final item = items.firstWhere((e) => e.itemId == drop.itemId);
          return InkWell(
              onTap: () => itemOnTap(item), child: _itemDropRow(item, drop));
        },
        itemCount: drops.length);
  }

  Widget _itemDropRow(Item item, ItemDrop drop) {
    final apCost = drop.apCost(stage);
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    child: item.image),
                SizedBox(width: 5),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              sprintf("%.2f%", [drop.rate * 100]),
              style: TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              apCost.isNaN ? "Nan" : sprintf("%.2f", [apCost]),
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
