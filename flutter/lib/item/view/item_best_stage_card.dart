import 'package:arknights/item/item_best_stage_bloc/item_best_stage_bloc.dart';
import 'package:arknights/item/item_drop_bloc/item_drop_bloc.dart';
import 'package:arknights/stage/stage.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_repository/stage_repository.dart';

class ItemBestStageCard extends StatelessWidget {
  final String itemId;
  final String name;
  final VoidCallback onTapArrow;
  final void Function(Stage) onTapStage;

  const ItemBestStageCard(
      {Key? key,
      required this.itemId,
      required this.name,
      required this.onTapArrow,
      required this.onTapStage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ItemBestStageBloc>(context)
        .add(ItemBestStageRequestEvent(itemName: name));
    BlocProvider.of<StageBloc>(context).add(StageRequestEvent());
    return BlocBuilder<ItemBestStageBloc, ItemBestStageState>(
      builder: (context, itemBestStageState) {
        if (itemBestStageState is ItemBestStageLoadSuccess) {
          BlocProvider.of<ItemDropBloc>(context).add(ItemDropRequestEvent());
          return BlocBuilder<ItemDropBloc, ItemDropState>(
            builder: (context, itemDropState) {
              if (itemDropState is ItemDropLoadSuccess) {
                final itemDrops = itemDropState.itemDrops
                    .where((e) => e.itemId == itemId)
                    .toList();
                if (itemBestStageState.itemBestStage == null &&
                    itemDrops.isEmpty) {
                  return Container();
                }
                return SlideCard(
                  title: "途径",
                  arrowOnTap: itemDrops.isEmpty ? null : onTapArrow,
                  child: itemBestStageState.itemBestStage == null
                      ? Container()
                      : IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Text(
                                      '总体最优',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    _bestStageView(
                                        context,
                                        itemBestStageState
                                            .itemBestStage!.totalBest)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: double.infinity,
                                child: VerticalDivider(
                                  width: 1,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Text(
                                      '单体最优',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    _bestStageView(
                                        context,
                                        itemBestStageState
                                            .itemBestStage!.singleBest)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              } else {
                return Container();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _bestStageView(BuildContext context, List<String> stages) {
    List<Widget> views = [];
    for (var stageCode in stages) {
      views.add(
        BlocBuilder<StageBloc, StageState>(
          builder: (context, state) {
            if (state is StageLoadSuccess) {
              final stage = state.stages.firstWhere((e) => e.code == stageCode);
              return OutlinedButton(
                onPressed: () => onTapStage(stage),
                style: OutlinedButton.styleFrom(
                    minimumSize: Size(50, 30), padding: EdgeInsets.zero),
                child: Text(
                  stageCode,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 12),
                ),
              );
            }
            return Container();
          },
        ),
      );
    }
    return Wrap(spacing: 5, children: views);
  }
}
