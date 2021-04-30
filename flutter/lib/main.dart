import 'package:arknights/app.dart';
import 'package:arknights/observer/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:stage_repository/stage_repository.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  runApp(ArknightsApp(
    itemRepository: ItemRepository(),
    stageRepository: StageRepository(),
    operatorRepository: OperatorRepository(),
  ));
}
