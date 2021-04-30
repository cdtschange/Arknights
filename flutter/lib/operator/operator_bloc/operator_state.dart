part of 'operator_bloc.dart';

@immutable
abstract class OperatorState extends Equatable {
  final List<String> foldedGroup;
  const OperatorState({required this.foldedGroup});
  @override
  List<Object> get props => [foldedGroup];
}

class OperatorInitial extends OperatorState {
  const OperatorInitial({required List<String> foldedGroup})
      : super(foldedGroup: foldedGroup);
}

class OperatorLoadInProgress extends OperatorState {
  const OperatorLoadInProgress({required List<String> foldedGroup})
      : super(foldedGroup: foldedGroup);
}

class OperatorLoadSuccess extends OperatorState {
  final List<Operator> operators;

  const OperatorLoadSuccess(
      {required this.operators, required List<String> foldedGroup})
      : super(foldedGroup: foldedGroup);

  @override
  List<Object> get props => [operators, foldedGroup];
}

class OperatorLoadFailure extends OperatorState {
  final String message;
  const OperatorLoadFailure(
      {required this.message, required List<String> foldedGroup})
      : super(foldedGroup: foldedGroup);

  @override
  List<Object> get props => [message, foldedGroup];
}
