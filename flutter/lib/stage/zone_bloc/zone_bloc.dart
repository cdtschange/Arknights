import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_repository/stage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'zone_event.dart';
part 'zone_state.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  bool isLoaded = false;
  final StageRepository _stageRepository;

  ZoneBloc({required StageRepository stageRepository})
      : _stageRepository = stageRepository,
        super(ZoneInitial());

  @override
  Stream<ZoneState> mapEventToState(
    ZoneEvent event,
  ) async* {
    if (event is ZoneRequestEvent) {
      yield* _mapZoneRequestEventToState(event);
    }
  }

  Stream<ZoneState> _mapZoneRequestEventToState(ZoneRequestEvent event) async* {
    yield ZoneLoadInProgress();
    try {
      final zones = await _stageRepository.fetchZones(!isLoaded);
      isLoaded = true;
      yield ZoneLoadSuccess(zones: zones);
    } catch (e) {
      yield ZoneLoadFailure(message: e.toString());
    }
  }
}
