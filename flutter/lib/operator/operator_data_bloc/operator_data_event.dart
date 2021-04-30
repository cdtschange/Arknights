part of 'operator_data_bloc.dart';

@immutable
abstract class OperatorDataEvent extends Equatable {
  const OperatorDataEvent();
  @override
  List<Object> get props => [];
}

class OperatorDataRequestEvent extends OperatorDataEvent {
  const OperatorDataRequestEvent();
}

class OperatorDataUpdateEvent extends OperatorDataEvent {
  final OperatorData data;
  const OperatorDataUpdateEvent({required this.data});
}
