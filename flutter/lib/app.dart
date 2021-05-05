import 'package:arknights/item/item.dart';
import 'package:arknights/operator/operator.dart';
import 'package:arknights/operator/skill_bloc/skill_bloc.dart';
import 'package:arknights/stage/stage.dart';
import 'package:arknights/router/app_route_information_parser.dart';
import 'package:arknights/router/app_router_delegate.dart';
import 'package:arknights/router/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:item_repository/item_repository.dart';
import 'package:stage_repository/stage_repository.dart';

class ArknightsApp extends StatelessWidget {
  const ArknightsApp(
      {Key? key,
      required ItemRepository itemRepository,
      required StageRepository stageRepository,
      required OperatorRepository operatorRepository})
      : _itemRepository = itemRepository,
        _stageRepository = stageRepository,
        _operatorRepository = operatorRepository,
        super(key: key);

  final ItemRepository _itemRepository;
  final StageRepository _stageRepository;
  final OperatorRepository _operatorRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _itemRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ItemBloc>(
            create: (context) => ItemBloc(itemRepository: _itemRepository),
          ),
          BlocProvider<ItemGroupBloc>(
            create: (context) => ItemGroupBloc(itemRepository: _itemRepository),
          ),
          BlocProvider<ItemDetailBloc>(
            create: (context) =>
                ItemDetailBloc(itemRepository: _itemRepository),
          ),
          BlocProvider<ItemBestStageBloc>(
            create: (context) =>
                ItemBestStageBloc(itemRepository: _itemRepository),
          ),
          BlocProvider<ItemDropBloc>(
            create: (context) => ItemDropBloc(itemRepository: _itemRepository),
          ),
          BlocProvider<ItemFactoryBloc>(
            create: (context) =>
                ItemFactoryBloc(itemRepository: _itemRepository),
          ),
          BlocProvider<ZoneBloc>(
            create: (context) => ZoneBloc(stageRepository: _stageRepository),
          ),
          BlocProvider<StageBloc>(
            create: (context) => StageBloc(stageRepository: _stageRepository),
          ),
          BlocProvider<OperatorBloc>(
            create: (context) =>
                OperatorBloc(operatorRepository: _operatorRepository),
          ),
          BlocProvider<SkillBloc>(
            create: (context) =>
                SkillBloc(operatorRepository: _operatorRepository),
          ),
          BlocProvider<OperatorImageBloc>(
            create: (context) =>
                OperatorImageBloc(operatorRepository: _operatorRepository),
          ),
          BlocProvider<OperatorDataBloc>(
            create: (context) =>
                OperatorDataBloc(operatorRepository: _operatorRepository),
          ),
          BlocProvider<OperatorFilterBloc>(
            create: (context) => OperatorFilterBloc(),
          ),
          BlocProvider<OperatorPopupBloc>(
            create: (context) => OperatorPopupBloc(),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final appState = AppState();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
        create: (_) => appState,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Arknights',
          theme: ThemeData(
            primaryColor: Color(0xFF343434),
            secondaryHeaderColor: Color(0xFFF7C945),
            primaryColorDark: Color(0xFF585858),
          ),
          routerDelegate: AppRouterDelegate(appState),
          routeInformationParser: AppRouteInformationParser(),
        ));
  }
}
