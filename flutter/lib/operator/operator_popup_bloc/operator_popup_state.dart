part of 'operator_popup_bloc.dart';

@immutable
abstract class OperatorPopupState {
  const OperatorPopupState();
}

class OperatorPopupInitial extends OperatorPopupState {
  const OperatorPopupInitial() : super();
}

class OperatorLevelPopup extends OperatorPopupState {
  final OperatorData operatorData;
  const OperatorLevelPopup({required this.operatorData}) : super();
}

class OperatorElitePopup extends OperatorPopupState {
  final OperatorData operatorData;
  const OperatorElitePopup({required this.operatorData}) : super();
}

class OperatorSkillPopup extends OperatorPopupState {
  final OperatorData operatorData;
  final Operator oper;
  final List<Skill> skills;
  const OperatorSkillPopup(
      {required this.operatorData, required this.oper, required this.skills})
      : super();
}

class OperatorRankPopup extends OperatorPopupState {
  final OperatorData operatorData;
  const OperatorRankPopup({required this.operatorData}) : super();
}
