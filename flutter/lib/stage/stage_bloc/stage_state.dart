part of 'stage_bloc.dart';

@immutable
abstract class StageState extends Equatable {
  const StageState();
  @override
  List<Object> get props => [];
}

class StageInitial extends StageState {}

class StageLoadInProgress extends StageState {}

class StageLoadSuccess extends StageState {
  final List<Stage> stages;

  const StageLoadSuccess({required this.stages}) : super();

  @override
  List<Object> get props => [stages];
}

class StageLoadFailure extends StageState {
  final String message;
  const StageLoadFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
