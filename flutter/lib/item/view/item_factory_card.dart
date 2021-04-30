import 'package:arknights/item/item_bloc/item_bloc.dart';
import 'package:arknights/item/item_factory_bloc/item_factory_bloc.dart';
import 'package:arknights/model/image_resource.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:collection/collection.dart';

import 'view.dart';

class ItemFactoryCard extends StatelessWidget {
  final String name;
  final void Function(Item) itemOnTap;

  const ItemFactoryCard({Key? key, required this.name, required this.itemOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ItemFactoryBloc>(context).add(ItemFactoryRequestEvent());
    return BlocBuilder<ItemFactoryBloc, ItemFactoryState>(
        builder: (context, itemFactoryState) {
      if (itemFactoryState is ItemFactoryLoadSuccess) {
        final itemFactory = itemFactoryState.itemFactories
            .firstWhereOrNull((e) => e.name == name);
        if (itemFactory == null) {
          return Container();
        }
        BlocProvider.of<ItemBloc>(context).add(ItemRequestEvent());
        return BlocBuilder<ItemBloc, ItemState>(builder: (context, itemState) {
          if (itemState is ItemLoadSuccess) {
            final item = itemState.items.firstWhere((e) => e.name == name);
            return SlideCard(
              title: "合成",
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ItemAmountView(
                            item: item,
                            amount: itemFactory.amount,
                            imageSize: 80,
                            fontSize: 16,
                            onTap: () => itemOnTap(item),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: double.infinity,
                          child: VerticalDivider(
                            width: 1,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(ImageResource.iconMoney,
                                      width: 30),
                                  SizedBox(width: 5),
                                  Text(
                                    itemFactory.cost.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              _inputItemsView(itemFactory, itemState.items),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _extraOutcomeItemsView(itemFactory, itemState.items),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
      } else {
        return Container();
      }
    });
  }

  Widget _inputItemsView(ItemFactory itemFactory, List<Item> items) {
    List<Widget> views = [];
    for (var itemName in itemFactory.inputs.keys) {
      final item = items.firstWhere((e) => e.name == itemName);
      final amount = itemFactory.inputs[itemName] ?? 0;
      views.add(ItemAmountView(
        item: item,
        amount: amount,
        imageSize: 50,
        fontSize: 10,
        onTap: () => itemOnTap(item),
      ));
    }
    return Wrap(spacing: 10, children: views);
  }

  Widget _extraOutcomeItemsView(ItemFactory itemFactory, List<Item> items) {
    if (itemFactory.extraOutcome.isEmpty) {
      return Container();
    }
    List<Widget> views = [];
    for (var itemName in itemFactory.extraOutcome.keys) {
      final item = items.firstWhere((e) => e.name == itemName);
      final rate = itemFactory.extraOutcome[itemName] ?? 0;
      views.add(ItemRateView(
        item: item,
        rate: rate,
        imageSize: 42,
        fontSize: 10,
        onTap: () => itemOnTap(item),
      ));
    }
    return Column(children: [
      Divider(),
      Container(
        alignment: Alignment.center,
        child: Wrap(spacing: 5, runSpacing: 10, children: views),
      )
    ]);
  }
}
