import 'package:arknights/model/image_resource.dart';
import 'package:arknights/operator/operator.dart';
import 'package:arknights/operator/operator_bloc/operator_bloc.dart';
import 'package:arknights/operator/skill_bloc/skill_bloc.dart';
import 'package:arknights/router/app_state.dart';
import 'package:arknights/router/ui_pages.dart';
import 'package:arknights/view/common/snackbar_manager.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import 'view.dart';

class OperatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('干员'),
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
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.filter_alt),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          )
        ],
      ),
      endDrawer: OperatorFilterDrawer(),
      body: SnackbarManager.wrap(_OperatorView(), _snackbar()),
    );
  }
}

List<SnackbarManager> _snackbar() {
  return [
    SnackbarManager<OperatorBloc, OperatorState>.fromError((state) {
      if (state is OperatorLoadFailure) {
        return state.message;
      }
    }),
    SnackbarManager<SkillBloc, SkillState>.fromError((state) {
      if (state is SkillLoadFailure) {
        return state.message;
      }
    }),
    SnackbarManager<OperatorDataBloc, OperatorDataState>.fromError((state) {
      if (state is OperatorDataLoadFailure) {
        return state.message;
      }
    }),
  ];
}

class _OperatorView extends StatelessWidget {
  _OperatorView();

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> data = Map.from(Operator.tagGroup());
    data.forEach((key, value) => data[key]?.clear());
    BlocProvider.of<OperatorFilterBloc>(context)
        .add(OperatorFilterChangedEvent(tags: data));
    BlocProvider.of<OperatorImageBloc>(context)
        .add(OperatorImageRequestEvent());
    return BlocBuilder<OperatorImageBloc, OperatorImageState>(
        builder: (context, operatorImageState) {
      if (operatorImageState is OperatorImageLoadInProgress) {
        return LoadingView();
      }
      if (operatorImageState is OperatorImageLoadFailure) {
        return RetryView(() => BlocProvider.of<OperatorImageBloc>(context)
            .add(OperatorImageRequestEvent()));
      }

      if (operatorImageState is OperatorImageLoadSuccess) {
        BlocProvider.of<OperatorDataBloc>(context)
            .add(OperatorDataRequestEvent());
        return BlocBuilder<OperatorDataBloc, OperatorDataState>(
            builder: (context, operatorDataState) {
          if (operatorDataState is OperatorDataLoadInProgress) {
            return LoadingView();
          }
          if (operatorDataState is OperatorDataLoadFailure) {
            return RetryView(() => BlocProvider.of<OperatorDataBloc>(context)
                .add(OperatorDataRequestEvent()));
          }

          if (operatorDataState is OperatorDataLoadSuccess) {
            BlocProvider.of<SkillBloc>(context).add(SkillRequestEvent());
            return BlocBuilder<SkillBloc, SkillState>(
                builder: (context, skillState) {
              if (skillState is SkillLoadInProgress) {
                return LoadingView();
              }
              if (skillState is SkillLoadFailure) {
                return RetryView(() => BlocProvider.of<SkillBloc>(context)
                    .add(SkillRequestEvent()));
              }

              if (skillState is SkillLoadSuccess) {
                BlocProvider.of<OperatorBloc>(context)
                    .add(OperatorRequestEvent());
                return BlocBuilder<OperatorBloc, OperatorState>(
                    builder: (context, operatorState) {
                  if (operatorState is OperatorLoadInProgress) {
                    return LoadingView();
                  }
                  if (operatorState is OperatorLoadFailure) {
                    return RetryView(() =>
                        BlocProvider.of<OperatorBloc>(context)
                            .add(OperatorRequestEvent()));
                  }

                  if (operatorState is OperatorLoadSuccess) {
                    return BlocBuilder<OperatorFilterBloc, OperatorFilterState>(
                        builder: (context, operatorFilterStage) {
                      if (operatorFilterStage is OperatorFilterLoadSuccess) {
                        return _listView(
                            context,
                            operatorState.foldedGroup,
                            operatorFilterStage.tags,
                            operatorDataState.operatorData,
                            operatorImageState.operatorImages,
                            operatorState.operators,
                            skillState.skills);
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
          return Container();
        });
      }
      return Container();
    });
  }

  Widget _listView(
      BuildContext context,
      List<String> foldGroup,
      Map<String, List<String>> selectedTags,
      List<OperatorData> operatorData,
      List<OperatorImage> operatorImages,
      List<Operator> operators,
      List<Skill> skills) {
    return CustomScrollView(
        slivers: _groupView(context, foldGroup, selectedTags, operatorData,
            operatorImages, operators, skills));
  }

  List<Widget> _groupView(
      BuildContext context,
      List<String> foldGroup,
      Map<String, List<String>> selectedTags,
      List<OperatorData> operatorData,
      List<OperatorImage> operatorImages,
      List<Operator> operators,
      List<Skill> skills) {
    List<Widget> views = [];
    final selectTag = selectedTags.entries
            .map((e) => e.value.length)
            .firstWhereOrNull((e) => e > 0) !=
        null;
    if (selectTag) {
      final groups = Operator.selectedTagGroup(selectedTags, operators);
      final groupKeys = groups.keys.sorted((a, b) {
        return Operator.groupScore(groups[b]!)
            .compareTo(Operator.groupScore(groups[a]!));
      });
      for (var key in groupKeys) {
        final subOperators = groups[key]!;
        subOperators.sort((a, b) {
          if (a.rarity != b.rarity) {
            return b.rarity.compareTo(a.rarity);
          } else {
            return b.name.compareTo(a.name);
          }
        });
        var detail = "";
        var number =
            subOperators.where((e) => e.rarity == 2 || e.rarity == 1).length;
        if (number > 0) {
          detail = "";
        } else {
          number = subOperators.where((e) => e.rarity == 5).length;
          if (number > 0) {
            detail += "$number 六星 ";
          }
          number = subOperators.where((e) => e.rarity == 4).length;
          if (number > 0) {
            detail += "$number 五星 ";
          }
          number = subOperators.where((e) => e.rarity == 3).length;
          if (number > 0) {
            detail += "$number 四星 ";
          }
          detail = detail.trim();
        }

        views.add(
          _groupHeader(
            title: key,
            detail: detail,
            isMain: true,
            onTap: () => BlocProvider.of<OperatorBloc>(context).add(
              OperatorGroupFoldEvent(name: key),
            ),
          ),
        );
        if (!foldGroup.contains(key)) {
          views.add(_groupContent(
              context, operatorData, operatorImages, subOperators, skills));
        }
      }
    } else {
      final groups = Operator.groupNames;
      for (var entry in groups.entries) {
        final subOperators =
            operators.where((e) => e.rarity == entry.value).toList();
        subOperators.sort((a, b) => b.name.compareTo(a.name));
        final mySubOperators = operatorData
            .where((e) =>
                e.have && subOperators.map((e) => e.name).contains(e.name))
            .toList();
        views.add(
          _groupHeader(
            title: entry.key,
            detail: mySubOperators.length.toString() +
                "/" +
                subOperators.length.toString(),
            isMain: true,
            onTap: () => BlocProvider.of<OperatorBloc>(context).add(
              OperatorGroupFoldEvent(name: entry.key),
            ),
          ),
        );
        if (!foldGroup.contains(entry.key)) {
          views.add(_groupContent(
              context, operatorData, operatorImages, subOperators, skills));
        }
      }
    }
    return views;
  }

  SliverPersistentHeader _groupHeader(
      {required String title,
      required String detail,
      required bool isMain,
      required VoidCallback onTap}) {
    return GridHeaderView(
        title: title, detail: detail, isMain: isMain, onTap: onTap);
  }

  SliverGrid _groupContent(
      BuildContext context,
      List<OperatorData> operatorData,
      List<OperatorImage> operatorImages,
      List<Operator> operators,
      List<Skill> skills) {
    var rowCount =
        MediaQuery.of(context).orientation == Orientation.portrait ? 4 : 8;
    double ratio = 0.50;
    double width = MediaQuery.of(context).size.width / rowCount;
    double height = width / ratio;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: rowCount,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: ratio),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _itemContainer(context, operatorData, operatorImages,
            operators[index], skills, width, height);
      }, childCount: operators.length),
    );
  }

  Widget _itemContainer(
      BuildContext context,
      List<OperatorData> operatorData,
      List<OperatorImage> operatorImages,
      Operator oper,
      List<Skill> skills,
      double width,
      double height) {
    final appState = Provider.of<AppState>(context, listen: false);
    final data = operatorData.firstWhereOrNull((e) => e.name == oper.name) ??
        OperatorData.fromName(oper.name);
    final images = operatorImages.firstWhereOrNull((e) => e.name == oper.name);
    return OperatorView(
        operatorData: data,
        operatorImage: images,
        oper: oper,
        skills: skills,
        width: width,
        height: height,
        onTap: () => appState.currentAction = PageAction(
            state: PageState.addPage,
            page: Pages.Operator.operatorPageConfig(name: oper.name)));
  }
}
