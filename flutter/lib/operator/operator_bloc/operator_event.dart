part of 'operator_bloc.dart';

@immutable
abstract class OperatorEvent extends Equatable {
  const OperatorEvent();
  @override
  List<Object> get props => [];
}

class OperatorRequestEvent extends OperatorEvent {
  const OperatorRequestEvent();
}

class OperatorGroupFoldEvent extends OperatorEvent {
  final String name;
  const OperatorGroupFoldEvent({required this.name});
}

class OperatorGroupFoldResetEvent extends OperatorEvent {
  const OperatorGroupFoldResetEvent();
}
