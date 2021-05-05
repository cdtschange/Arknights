import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_repository/stage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'stage_event.dart';
part 'stage_state.dart';

class StageBloc extends Bloc<StageEvent, StageState> {
  bool isLoaded = false;
  final StageRepository _stageRepository;

  StageBloc({required StageRepository stageRepository})
      : _stageRepository = stageRepository,
        super(StageInitial());

  @override
  Stream<StageState> mapEventToState(
    StageEvent event,
  ) async* {
    if (event is StageRequestEvent) {
      yield* _mapStageRequestEventToState(event);
    }
  }

  Stream<StageState> _mapStageRequestEventToState(
      StageRequestEvent event) async* {
    yield StageLoadInProgress();
    try {
      final stages = await _stageRepository.fetchStages(!isLoaded);
      isLoaded = true;
      yield StageLoadSuccess(stages: stages);
    } catch (e) {
      yield StageLoadFailure(message: e.toString());
    }
  }
}
