part of 'operator_filter_bloc.dart';

@immutable
abstract class OperatorFilterState extends Equatable {
  const OperatorFilterState();
  @override
  List<Object> get props => [];
}

class OperatorFilterInitial extends OperatorFilterState {
  const OperatorFilterInitial() : super();
}

class OperatorFilterLoadInProgress extends OperatorFilterState {
  const OperatorFilterLoadInProgress() : super();
}

class OperatorFilterLoadSuccess extends OperatorFilterState {
  final Map<String, List<String>> tags;

  const OperatorFilterLoadSuccess({required this.tags}) : super();

  @override
  List<Object> get props => [tags];
}

class OperatorFilterLoadFailure extends OperatorFilterState {
  final String message;
  const OperatorFilterLoadFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
