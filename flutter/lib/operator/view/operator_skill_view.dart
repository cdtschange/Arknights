import 'package:arknights/operator/operator.dart';
import 'package:flutter/material.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorSkillView extends StatelessWidget {
  final OperatorData operatorData;
  final Operator oper;
  final List<Skill> skills;
  final double width;

  OperatorSkillView(
      {Key? key,
      required this.operatorData,
      required this.oper,
      required this.skills,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _skillView(),
    );
  }

  List<Widget> _skillView() {
    final operSkills =
        oper.skills.map((e) => skills.firstWhere((s) => s.id == e)).toList();
    return operSkills.map((e) {
      final skillIndex = operSkills.indexOf(e);
      final levels = operatorData.skillLevel;
      final level = levels.length > skillIndex ? levels[skillIndex] : 0;
      return OperatorSkillItemView(
        operatorData: operatorData,
        oper: oper,
        skill: e,
        skillLevel: level,
        width: width,
      );
    }).toList();
  }
}
