import 'package:arknights/operator/operator.dart';
import 'package:arknights/view/common/snackbar_manager.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:collection/collection.dart';

class OperatorDetailPage extends StatelessWidget {
  final String name;

  OperatorDetailPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
        actions: [
          BlocBuilder<OperatorDataBloc, OperatorDataState>(
            builder: (context, state) {
              var have = false;
              if (state is OperatorDataLoadSuccess) {
                have = state.operatorData
                        .firstWhereOrNull((e) => e.name == name)
                        ?.have ??
                    false;
              }
              return Switch(
                value: have,
                activeColor: Colors.white,
                onChanged: (bool value) {
                  if (state is OperatorDataLoadSuccess) {
                    final oper = state.operatorData
                            .firstWhereOrNull((e) => e.name == name) ??
                        OperatorData.fromName(name);
                    BlocProvider.of<OperatorDataBloc>(context).add(
                        OperatorDataUpdateEvent(
                            data: oper.copyWith(have: !have)));
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SnackbarManager.wrap(_OperatorDetailView(name: name), _snackbar()),
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
    SnackbarManager<OperatorImageBloc, OperatorImageState>.fromError((state) {
      if (state is OperatorImageLoadFailure) {
        return state.message;
      }
    }),
    SnackbarManager<OperatorPopupBloc, OperatorPopupState>.fromPopup(
        (context, state) {
      if (state is OperatorLevelPopup) {
        showDialog(
            context: context,
            builder: (context) =>
                OperatorLevelPopupView(operatorData: state.operatorData));
      } else if (state is OperatorElitePopup) {
        showDialog(
            context: context,
            builder: (context) =>
                OperatorElitePopupView(operatorData: state.operatorData));
      } else if (state is OperatorRankPopup) {
        showDialog(
            context: context,
            builder: (context) =>
                OperatorRankPopupView(operatorData: state.operatorData));
      } else if (state is OperatorSkillPopup) {
        showDialog(
            context: context,
            builder: (context) => OperatorSkillPopupView(
                operatorData: state.operatorData,
                oper: state.oper,
                skills: state.skills));
      }
    }),
  ];
}

class _OperatorDetailView extends StatelessWidget {
  final String name;
  const _OperatorDetailView({required this.name});

  @override
  Widget build(BuildContext context) {
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
                    Operator oper = operatorState.operators
                        .firstWhere((e) => e.name == name);
                    OperatorData operData = operatorDataState.operatorData
                            .firstWhereOrNull((e) => e.name == name) ??
                        OperatorData.fromName(name);
                    OperatorImage? operatorImage = operatorImageState
                        .operatorImages
                        .firstWhereOrNull((e) => e.name == name);
                    return _listView(context, operData, oper, operatorImage,
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

  Widget _listView(BuildContext context, OperatorData operatorData,
      Operator oper, OperatorImage? operatorImage, List<Skill> skills) {
    return ListView(
      children: [
        OperatorDetailImageView(
            operatorData: operatorData,
            oper: oper,
            operatorImage: operatorImage,
            skills: skills),
        Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              InfoTextCard(title: "特性", content: oper.description),
              InfoTextCard(title: "合同", content: oper.itemUsage),
              InfoTextCard(title: "合同描述", content: oper.itemDesc),
            ],
          ),
        ),
      ],
    );
  }
}
