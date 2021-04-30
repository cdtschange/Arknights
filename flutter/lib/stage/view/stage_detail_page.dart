import 'package:arknights/item/item.dart';
import 'package:arknights/router/app_state.dart';
import 'package:arknights/router/ui_pages.dart';
import 'package:arknights/stage/stage.dart';
import 'package:arknights/stage/view/stage_header_view.dart';
import 'package:arknights/view/common/snackbar_manager.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:provider/provider.dart';
import 'package:stage_repository/stage_repository.dart';

class StageDetailPage extends StatelessWidget {
  final String stageId;
  final String name;

  const StageDetailPage({Key? key, required this.stageId, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body:
          SnackbarManager.wrap(_StageDetailView(stageId: stageId), _snackbar()),
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

class _StageDetailView extends StatelessWidget {
  final String stageId;
  const _StageDetailView({required this.stageId});

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
                return _listView(
                    context,
                    stageState.stages.firstWhere((e) => e.stageId == stageId),
                    stageState.stages,
                    itemState.items,
                    itemDropState.itemDrops);
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

  Widget _listView(BuildContext context, Stage stage, List<Stage> stages,
      List<Item> items, List<ItemDrop> itemDrops) {
    final appState = Provider.of<AppState>(context, listen: false);
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        StageHeaderView(stage: stage, stages: stages),
        SizedBox(height: 10),
        stage.description?.isNotEmpty == true
            ? InfoTextCard(title: "描述", content: stage.description!)
            : Container(),
        SizedBox(height: 5),
        StageDropsView(
          stage: stage,
          itemDrops: itemDrops,
          items: items,
          itemOnTap: (item) => appState.currentAction = PageAction(
              state: PageState.addPage,
              page: Pages.Item.itemPageConfig(
                  itemId: item.itemId, name: item.name)),
        )
      ],
    );
  }
}
