import 'package:arknights/model/image_resource.dart';
import 'package:arknights/router/app_state.dart';
import 'package:arknights/router/ui_pages.dart';
import 'package:arknights/stage/stage.dart';
import 'package:arknights/view/common/snackbar_manager.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_repository/stage_repository.dart';
import 'package:provider/provider.dart';

class ZonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('关卡'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.bottomLeft,
              image: AssetImage(ImageResource.titleBarLeft),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: SnackbarManager.wrap(_ZoneView(), _snackbar()),
    );
  }
}

List<SnackbarManager> _snackbar() {
  return [
    SnackbarManager<ZoneBloc, ZoneState>.fromError((state) {
      if (state is ZoneLoadFailure) {
        return state.message;
      }
    }),
  ];
}

class _ZoneView extends StatelessWidget {
  const _ZoneView();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ZoneBloc>(context).add(ZoneRequestEvent());
    return BlocBuilder<ZoneBloc, ZoneState>(builder: (context, state) {
      if (state is ZoneLoadInProgress) {
        return LoadingView();
      }
      if (state is ZoneLoadFailure) {
        return RetryView(
            () => BlocProvider.of<ZoneBloc>(context).add(ZoneRequestEvent()));
      }

      if (state is ZoneLoadSuccess) {
        return _listView(context, state.zones);
      }
      return Container();
    });
  }

  Widget _listView(BuildContext context, List<Zone> zones) {
    return CustomScrollView(slivers: _groupView(context, zones));
  }

  List<Widget> _groupView(BuildContext context, List<Zone> zones) {
    List<Widget> views = [];
    var groups = Zone.groupNames;
    for (var entry in groups.entries) {
      views.add(_groupHeader(title: entry.key, isMain: true));
      views.add(_groupContent(
          context,
          entry.value
              .map((e) => zones.firstWhere((z) => z.zoneID == e))
              .toList()));
    }
    return views;
  }

  SliverPersistentHeader _groupHeader(
      {required String title, required bool isMain}) {
    return GridHeaderView(title: title, isMain: isMain);
  }

  SliverGrid _groupContent(BuildContext context, List<Zone> zones) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 4,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 0.86),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _itemContainer(context, zones[index]);
      }, childCount: zones.length),
    );
  }

  Widget _itemContainer(BuildContext context, Zone zone) {
    final appState = Provider.of<AppState>(context, listen: false);
    return ZoneView(
        zone: zone,
        onTap: () => appState.currentAction = PageAction(
            state: PageState.addPage,
            page: Pages.Stage.zoneStagePageConfig(
                zoneId: zone.zoneID, name: zone.displayName)));
  }
}
