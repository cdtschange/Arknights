part of 'operator_data_bloc.dart';

@immutable
abstract class OperatorDataState extends Equatable {
  const OperatorDataState();
  @override
  List<Object> get props => [];
}

class OperatorDataInitial extends OperatorDataState {
  const OperatorDataInitial() : super();
}

class OperatorDataLoadInProgress extends OperatorDataState {
  const OperatorDataLoadInProgress() : super();
}

class OperatorDataLoadSuccess extends OperatorDataState {
  final List<OperatorData> operatorData;

  const OperatorDataLoadSuccess({required this.operatorData}) : super();

  @override
  List<Object> get props => [operatorData];

  OperatorDataLoadSuccess copyWithSkin(
      {required String name, required int skin}) {
    final data = operatorData.firstWhereOrNull((e) => e.name == name) ??
        OperatorData.fromName(name);
    final newData = data.copyWith(skin: skin);
    final list = List.of(operatorData)
      ..removeWhere((e) => e.name == name)
      ..add(newData);
    return OperatorDataLoadSuccess(operatorData: list);
  }
}

class OperatorDataLoadFailure extends OperatorDataState {
  final String message;
  const OperatorDataLoadFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
