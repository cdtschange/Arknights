import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:operator_repository/operator_repository.dart';

part 'operator_popup_event.dart';
part 'operator_popup_state.dart';

class OperatorPopupBloc extends Bloc<OperatorPopupEvent, OperatorPopupState> {
  OperatorPopupBloc() : super(OperatorPopupInitial());

  @override
  Stream<OperatorPopupState> mapEventToState(
    OperatorPopupEvent event,
  ) async* {
    if (event is OperatorLevelPopupEvent) {
      yield* _mapOperatorLevelPopupEventToState(event);
    }
    if (event is OperatorElitePopupEvent) {
      yield* _mapOperatorElitePopupEventToState(event);
    }
    if (event is OperatorSkillPopupEvent) {
      yield* _mapOperatorSkillPopupEventToState(event);
    }
    if (event is OperatorRankPopupEvent) {
      yield* _mapOperatorRankPopupEventToState(event);
    }
  }

  Stream<OperatorPopupState> _mapOperatorLevelPopupEventToState(
      OperatorLevelPopupEvent event) async* {
    yield OperatorLevelPopup(operatorData: event.operatorData);
  }

  Stream<OperatorPopupState> _mapOperatorElitePopupEventToState(
      OperatorElitePopupEvent event) async* {
    yield OperatorElitePopup(operatorData: event.operatorData);
  }

  Stream<OperatorPopupState> _mapOperatorSkillPopupEventToState(
      OperatorSkillPopupEvent event) async* {
    yield OperatorSkillPopup(
        operatorData: event.operatorData,
        oper: event.oper,
        skills: event.skills);
  }

  Stream<OperatorPopupState> _mapOperatorRankPopupEventToState(
      OperatorRankPopupEvent event) async* {
    yield OperatorRankPopup(operatorData: event.operatorData);
  }
}
