import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'operator_event.dart';
part 'operator_state.dart';

class OperatorBloc extends Bloc<OperatorEvent, OperatorState> {
  bool isLoaded = false;
  final OperatorRepository _operatorRepository;

  OperatorBloc({required OperatorRepository operatorRepository})
      : _operatorRepository = operatorRepository,
        super(OperatorInitial(foldedGroup: []));

  @override
  Stream<OperatorState> mapEventToState(
    OperatorEvent event,
  ) async* {
    if (event is OperatorRequestEvent) {
      yield* _mapOperatorRequestEventToState(event);
    }
    if (event is OperatorGroupFoldEvent) {
      yield* _mapOperatorGroupFoldEventToState(event);
    }
    if (event is OperatorGroupFoldResetEvent) {
      yield* _mapOperatorGroupFoldResetEventToState(event);
    }
  }

  Stream<OperatorState> _mapOperatorRequestEventToState(
      OperatorRequestEvent event) async* {
    yield OperatorLoadInProgress(foldedGroup: state.foldedGroup);
    try {
      final operators =
          await _operatorRepository.fetchOperators(refresh: !isLoaded);
      isLoaded = true;
      yield OperatorLoadSuccess(
          operators: operators, foldedGroup: state.foldedGroup);
    } catch (e) {
      yield OperatorLoadFailure(
          message: e.toString(), foldedGroup: state.foldedGroup);
    }
  }

  Stream<OperatorState> _mapOperatorGroupFoldEventToState(
      OperatorGroupFoldEvent event) async* {
    if (state is OperatorLoadSuccess) {
      if (state.foldedGroup.contains(event.name)) {
        List<String> list =
            state.foldedGroup.where((e) => e != event.name).toList();
        yield OperatorLoadSuccess(
            operators: (state as OperatorLoadSuccess).operators,
            foldedGroup: list);
      } else {
        List<String> list = [event.name];
        list.addAll(state.foldedGroup);
        yield OperatorLoadSuccess(
            operators: (state as OperatorLoadSuccess).operators,
            foldedGroup: list);
      }
    }
  }

  Stream<OperatorState> _mapOperatorGroupFoldResetEventToState(
      OperatorGroupFoldResetEvent event) async* {
    if (state is OperatorLoadSuccess) {
      yield OperatorLoadSuccess(
          operators: (state as OperatorLoadSuccess).operators, foldedGroup: []);
    }
  }
}
