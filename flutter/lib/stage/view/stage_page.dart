import 'package:arknights/item/item.dart';
import 'package:arknights/router/app_state.dart';
import 'package:arknights/router/ui_pages.dart';
import 'package:arknights/stage/stage.dart';
import 'package:arknights/view/common/snackbar_manager.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:provider/provider.dart';
import 'package:stage_repository/stage_repository.dart';
import 'dart:math' as math;

class StagePage extends StatelessWidget {
  final String? zoneId;
  final String? itemId;
  final String name;

  const StagePage.fromItem({Key? key, required this.itemId, required this.name})
      : zoneId = null,
        super(key: key);
  const StagePage.fromZone({Key? key, required this.zoneId, required this.name})
      : itemId = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: SnackbarManager.wrap(
          _StageListView(zoneId: zoneId, itemId: itemId), _snackbar()),
    );
  }
}

List<SnackbarManager> _snackbar() {
  return [
    SnackbarManager<StageBloc, StageState>.fromError((state) {
      if (state is StageLoadFailure) {
        return state.message;
      }
    }),
    SnackbarManager<ItemDropBloc, ItemDropState>.fromError((state) {
      if (state is ItemDropLoadFailure) {
        return state.message;
      }
    }),
    SnackbarManager<ItemBloc, ItemState>.fromError((state) {
      if (state is ItemLoadFailure) {
        return state.message;
      }
    }),
  ];
}

class _StageListView extends StatelessWidget {
  final String? zoneId;
  final String? itemId;
  const _StageListView({this.zoneId, this.itemId});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StageBloc>(context).add(StageRequestEvent());
    return BlocBuilder<StageBloc, StageState>(builder: (context, stageState) {
      if (stageState is StageLoadInProgress) {
        return LoadingView();
      }
      if (stageState is StageLoadFailure) {
        return RetryView(
            () => BlocProvider.of<StageBloc>(context).add(StageRequestEvent()));
      }

      if (stageState is StageLoadSuccess) {
        BlocProvider.of<ItemBloc>(context).add(ItemRequestEvent());
        return BlocBuilder<ItemBloc, ItemState>(builder: (context, itemState) {
          if (itemState is ItemLoadFailure) {
            return RetryView(() =>
                BlocProvider.of<ItemBloc>(context).add(ItemRequestEvent()));
          }

          if (itemState is ItemLoadSuccess) {
            BlocProvider.of<ItemDropBloc>(context).add(ItemDropRequestEvent());
            return BlocBuilder<ItemDropBloc, ItemDropState>(
                builder: (context, itemDropState) {
              if (itemDropState is ItemDropLoadFailure) {
                return RetryView(() => BlocProvider.of<ItemDropBloc>(context)
                    .add(ItemDropRequestEvent()));
              }

              if (itemDropState is ItemDropLoadSuccess) {
                if (itemId != null) {
                  final item =
                      itemState.items.firstWhere((e) => e.itemId == itemId);
                  final stages =
                      item.stages(itemDropState.itemDrops, stageState.stages);
                  return _listView(context, stages, itemState.items,
                      itemDropState.itemDrops);
                } else if (zoneId != null) {
                  return _listView(
                      context,
                      stageState.stages
                          .where((e) => e.zoneId == zoneId)
                          .toList(),
                      itemState.items,
                      itemDropState.itemDrops);
                }
              }
              return Container();
            });
          }
          return Container();
        });
      }
      return Container();
    });
  }

  Widget _listView(BuildContext context, List<Stage> stages, List<Item> items,
      List<ItemDrop> itemDrops) {
    return CustomScrollView(
        slivers: _groupView(context, stages, items, itemDrops));
  }

  List<Widget> _groupView(BuildContext context, List<Stage> stages,
      List<Item> items, List<ItemDrop> itemDrops) {
    List<Widget> views = [];
    final main = stages.where((e) => e.isMainStage).toList();
    final train = stages.where((e) => !e.isMainStage).toList();
    if (main.length > 0) {
      views.add(_groupHeader(title: "主线", isMain: true));
      views.add(_groupContent(context, main, items, itemDrops));
    }
    if (train.length > 0) {
      views.add(_groupHeader(title: "训练", isMain: true));
      views.add(_groupContent(context, train, items, itemDrops));
    }
    return views;
  }

  SliverPersistentHeader _groupHeader(
      {required String title, required bool isMain}) {
    return GridHeaderView(title: title, isMain: isMain);
  }

  SliverList _groupContent(BuildContext context, List<Stage> stages,
      List<Item> items, List<ItemDrop> itemDrops) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final int itemIndex = index ~/ 2;
        if (index.isEven) {
          return _itemContainer(context, stages[itemIndex], items, itemDrops);
        }
        return Padding(
            padding: EdgeInsets.only(left: 20),
            child: Divider(height: 0, color: Colors.grey));
      }, semanticIndexCallback: (Widget widget, int localIndex) {
        if (localIndex.isEven) {
          return localIndex ~/ 2;
        }
        return null;
      }, childCount: math.max(0, stages.length * 2 - 1)),
    );
  }

  Widget _itemContainer(BuildContext context, Stage stage, List<Item> items,
      List<ItemDrop> itemDrops) {
    final appState = Provider.of<AppState>(context, listen: false);
    return StageRowView(
        stage: stage,
        items: items,
        itemDrops: itemDrops,
        onTap: () => appState.currentAction = PageAction(
            state: PageState.addPage,
            page: Pages.StageDetail.stagePageConfig(
                stageId: stage.stageId, name: stage.displayName)));
  }
}
