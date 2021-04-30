part of 'skill_bloc.dart';

@immutable
abstract class SkillEvent extends Equatable {
  const SkillEvent();
  @override
  List<Object> get props => [];
}

class SkillRequestEvent extends SkillEvent {
  const SkillRequestEvent();
}
