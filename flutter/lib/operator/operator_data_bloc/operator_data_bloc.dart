import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

part 'operator_data_event.dart';
part 'operator_data_state.dart';

class OperatorDataBloc extends Bloc<OperatorDataEvent, OperatorDataState> {
  final OperatorRepository _operatorRepository;

  OperatorDataBloc({required OperatorRepository operatorRepository})
      : _operatorRepository = operatorRepository,
        super(OperatorDataInitial());

  @override
  Stream<OperatorDataState> mapEventToState(
    OperatorDataEvent event,
  ) async* {
    if (event is OperatorDataRequestEvent) {
      yield* _mapOperatorDataRequestEventToState(event);
    } else if (event is OperatorDataUpdateEvent) {
      yield* _mapOperatorDataUpdateEventToState(event, state);
    }
  }

  Stream<OperatorDataState> _mapOperatorDataRequestEventToState(
      OperatorDataRequestEvent event) async* {
    yield OperatorDataLoadInProgress();
    try {
      final operatorData = await _operatorRepository.fetchOperatorData();
      yield OperatorDataLoadSuccess(operatorData: operatorData);
    } catch (e) {
      yield OperatorDataLoadFailure(message: e.toString());
    }
  }

  Stream<OperatorDataState> _mapOperatorDataUpdateEventToState(
      OperatorDataUpdateEvent event, OperatorDataState state) async* {
    await _operatorRepository.updateOperatorData(event.data);
    final operatorData = await _operatorRepository.fetchOperatorData();
    yield OperatorDataLoadInProgress();
    yield OperatorDataLoadSuccess(operatorData: operatorData);
  }
}
