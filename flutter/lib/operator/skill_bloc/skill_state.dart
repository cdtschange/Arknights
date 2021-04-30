part of 'skill_bloc.dart';

@immutable
abstract class SkillState extends Equatable {
  const SkillState();
  @override
  List<Object> get props => [];
}

class SkillInitial extends SkillState {}

class SkillLoadInProgress extends SkillState {}

class SkillLoadSuccess extends SkillState {
  final List<Skill> skills;

  const SkillLoadSuccess({required this.skills}) : super();

  @override
  List<Object> get props => [skills];
}

class SkillLoadFailure extends SkillState {
  final String message;
  const SkillLoadFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
