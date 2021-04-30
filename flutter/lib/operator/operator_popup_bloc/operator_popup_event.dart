part of 'operator_popup_bloc.dart';

@immutable
abstract class OperatorPopupEvent extends Equatable {
  const OperatorPopupEvent();
  @override
  List<Object> get props => [];
}

class OperatorLevelPopupEvent extends OperatorPopupEvent {
  final OperatorData operatorData;
  const OperatorLevelPopupEvent({required this.operatorData});
}

class OperatorElitePopupEvent extends OperatorPopupEvent {
  final OperatorData operatorData;
  const OperatorElitePopupEvent({required this.operatorData});
}

class OperatorSkillPopupEvent extends OperatorPopupEvent {
  final OperatorData operatorData;
  final Operator oper;
  final List<Skill> skills;
  const OperatorSkillPopupEvent(
      {required this.operatorData, required this.oper, required this.skills});
}

class OperatorRankPopupEvent extends OperatorPopupEvent {
  final OperatorData operatorData;
  const OperatorRankPopupEvent({required this.operatorData});
}
