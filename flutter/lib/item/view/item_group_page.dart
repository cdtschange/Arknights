import 'package:arknights/item/item_bloc/item_bloc.dart';
import 'package:arknights/item/item_group_bloc/item_group_bloc.dart';
import 'package:arknights/model/image_resource.dart';
import 'package:arknights/router/app_state.dart';
import 'package:arknights/router/ui_pages.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:provider/provider.dart';
import 'view.dart';

class ItemGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('道具'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomLeft,
                image: AssetImage(ImageResource.titleBarLeft),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          actions: [
            BlocBuilder<ItemGroupBloc, ItemGroupState>(
                builder: (context, state) {
              return Switch(
                  value: !state.isPimary,
                  activeColor: Colors.white,
                  onChanged: (bool value) {
                    BlocProvider.of<ItemGroupBloc>(context)
                        .add(ItemGroupSwitchEvent(isPrimary: !value));
                  });
            }),
          ]),
      body: SnackbarManager.wrap(_ItemGroupView(), _snackbar()),
    );
  }
}

List<SnackbarManager> _snackbar() {
  return [
    SnackbarManager<ItemGroupBloc, ItemGroupState>.fromError((state) {
      if (state is ItemGroupLoadFailure) {
        return state.message;
      } else if (state is ItemGroupSwitchFailure) {
        return state.message;
      }
    }),
    SnackbarManager<ItemBloc, ItemState>.fromError((state) {
      if (state is ItemLoadFailure) {
        return state.message;
      }
    })
  ];
}

class _ItemGroupView extends StatelessWidget {
  const _ItemGroupView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemGroupBloc, ItemGroupState>(
        builder: (context, groupState) {
      if (groupState is ItemGroupInitial) {
        BlocProvider.of<ItemGroupBloc>(context)
            .add(ItemGroupRequestEvent(isPrimary: groupState.isPimary));
        return Container();
      }
      if (groupState is ItemGroupLoadInProgress) {
        return LoadingView();
      }
      if (groupState is ItemGroupLoadFailure ||
          groupState is ItemGroupSwitchFailure) {
        return RetryView(() => BlocProvider.of<ItemGroupBloc>(context)
            .add(ItemGroupRequestEvent(isPrimary: groupState.isPimary)));
      }

      if (groupState is ItemGroupLoadSuccess ||
          groupState is ItemGroupSwitchSuccess) {
        if (groupState is ItemGroupLoadSuccess) {
          BlocProvider.of<ItemBloc>(context).add(ItemRequestEvent());
        }
        return BlocBuilder<ItemBloc, ItemState>(builder: (context, itemState) {
          if (itemState is ItemInitial || itemState is ItemLoadInProgress) {
            return LoadingView();
          }
          if (itemState is ItemLoadFailure) {
            return RetryView(() =>
                BlocProvider.of<ItemBloc>(context).add(ItemRequestEvent()));
          }
          if (itemState is ItemLoadSuccess) {
            if (groupState is ItemGroupLoadSuccess) {
              return _listView(context, groupState.isPimary, groupState.groups,
                  itemState.items);
            } else if (groupState is ItemGroupSwitchSuccess) {
              return _listView(context, groupState.isPimary, groupState.groups,
                  itemState.items);
            }
          }
          return Container();
        });
      }
      return Container();
    });
  }

  Widget _listView(BuildContext context, bool isPrimary, List<ItemGroup> groups,
      List<Item> items) {
    return CustomScrollView(
        slivers: _groupView(context, isPrimary, groups, items));
  }

  List<Widget> _groupView(BuildContext context, bool isPrimary,
      List<ItemGroup> groups, List<Item> items) {
    List<Widget> views = [];
    List<Item> addedItems = [];
    for (var group in groups) {
      views.add(_groupHeader(title: group.name, isMain: true));
      if (group.items != null) {
        final groupItems =
            items.where((e) => group.items!.contains(e.name)).toList();
        addedItems.addAll(groupItems);
        views.add(_groupContent(context, groupItems));
      } else if (group.group != null) {
        for (var group2 in group.group!) {
          views.add(_groupHeader(title: group2.name, isMain: false));
          if (group2.items != null) {
            final groupItems =
                items.where((e) => group2.items!.contains(e.name)).toList();
            addedItems.addAll(groupItems);
            views.add(_groupContent(context, groupItems));
          }
        }
      }
    }
    if (!isPrimary) {
      final others = items.where((e) => !addedItems.contains(e)).toList();
      if (others.isNotEmpty) {
        views.add(_groupHeader(title: '其他', isMain: true));
        views.add(_groupContent(context, others));
      }
    }
    return views;
  }

  SliverPersistentHeader _groupHeader(
      {required String title, required bool isMain}) {
    return GridHeaderView(title: title, isMain: isMain);
  }

  SliverGrid _groupContent(BuildContext context, List<Item> items) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 4
                  : 6,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 0.8),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _itemContainer(context, items[index]);
      }, childCount: items.length),
    );
  }

  Widget _itemContainer(BuildContext context, Item item) {
    final appState = Provider.of<AppState>(context, listen: false);
    return ItemView(
        item: item,
        onTap: () => appState.currentAction = PageAction(
            state: PageState.addPage,
            page: Pages.Item.itemPageConfig(
                itemId: item.itemId, name: item.name)));
  }
}
