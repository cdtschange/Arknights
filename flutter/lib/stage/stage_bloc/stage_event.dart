part of 'stage_bloc.dart';

@immutable
abstract class StageEvent extends Equatable {
  const StageEvent();
  @override
  List<Object> get props => [];
}

class StageRequestEvent extends StageEvent {
  const StageRequestEvent();
}
