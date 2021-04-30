import 'package:arknights/item/item_detail_bloc/item_detail_bloc.dart';
import 'package:arknights/item/view/view.dart';
import 'package:arknights/router/app_state.dart';
import 'package:arknights/router/ui_pages.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatelessWidget {
  final String itemId;
  final String name;
  ItemDetailPage({Key? key, required this.itemId, required this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: SnackbarManager.wrap(
          _ItemDetailView(itemId: itemId, name: name), _snackbar()),
    );
  }
}

List<SnackbarManager> _snackbar() {
  return [
    SnackbarManager<ItemDetailBloc, ItemDetailState>.fromError((state) {
      if (state is ItemDetailLoadFailure) {
        return state.message;
      }
    })
  ];
}

class _ItemDetailView extends StatelessWidget {
  final String itemId;
  final String name;
  const _ItemDetailView({required this.itemId, required this.name});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ItemDetailBloc>(context).add(ItemDetailRequestEvent());
    final appState = Provider.of<AppState>(context, listen: false);
    return BlocBuilder<ItemDetailBloc, ItemDetailState>(
        builder: (context, state) {
      if (state is ItemDetailLoadInProgress) {
        return LoadingView();
      }
      if (state is ItemDetailLoadFailure) {
        return RetryView(() => BlocProvider.of<ItemDetailBloc>(context)
            .add(ItemDetailRequestEvent()));
      }

      if (state is ItemDetailLoadSuccess) {
        final itemDetail =
            state.itemDetails.firstWhere((e) => e.itemId == itemId);
        return ListView(padding: EdgeInsets.all(10), children: [
          _headerSection(itemDetail),
          SizedBox(height: 10),
          itemDetail.usage.isNotEmpty
              ? InfoTextCard(title: "用途", content: itemDetail.usage)
              : Container(),
          SizedBox(height: 5),
          itemDetail.description.isNotEmpty
              ? InfoTextCard(title: "描述", content: itemDetail.description)
              : Container(),
          SizedBox(height: 5),
          itemDetail.obtainApproach?.isNotEmpty == true
              ? InfoTextCard(title: "获得方式", content: itemDetail.obtainApproach!)
              : Container(),
          SizedBox(height: 5),
          ItemBestStageCard(
            itemId: itemId,
            name: name,
            onTapArrow: () => appState.currentAction = PageAction(
                state: PageState.addPage,
                page: Pages.Stage.itemStagePageConfig(
                    itemId: itemId, name: name)),
            onTapStage: (stage) => appState.currentAction = PageAction(
                state: PageState.addPage,
                page: Pages.StageDetail.stagePageConfig(
                    stageId: stage.stageId, name: stage.displayName)),
          ),
          SizedBox(height: 5),
          ItemFactoryCard(
            name: name,
            itemOnTap: (item) => appState.currentAction = PageAction(
                state: PageState.addPage,
                page: Pages.Item.itemPageConfig(
                    itemId: item.itemId, name: item.name)),
          )
        ]);
      }
      return Container();
    });
  }

  Widget _headerSection(ItemDetail itemDetail) {
    return HeaderCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(width: 80, height: 80, child: itemDetail.image),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Text(
              itemDetail.name,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
        ],
      ),
    );
  }
}
