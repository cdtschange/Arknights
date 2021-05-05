import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'skill_event.dart';
part 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {
  bool isLoaded = false;
  final OperatorRepository _operatorRepository;

  SkillBloc({required OperatorRepository operatorRepository})
      : _operatorRepository = operatorRepository,
        super(SkillInitial());

  @override
  Stream<SkillState> mapEventToState(
    SkillEvent event,
  ) async* {
    if (event is SkillRequestEvent) {
      yield* _mapSkillRequestEventToState(event);
    }
  }

  Stream<SkillState> _mapSkillRequestEventToState(
      SkillRequestEvent event) async* {
    yield SkillLoadInProgress();
    try {
      final skills = await _operatorRepository.fetchSkills(refresh: !isLoaded);
      isLoaded = true;
      yield SkillLoadSuccess(skills: skills);
    } catch (e) {
      yield SkillLoadFailure(message: e.toString());
    }
  }
}
