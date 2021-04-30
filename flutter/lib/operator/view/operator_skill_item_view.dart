import 'package:flutter/material.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorSkillItemView extends StatelessWidget {
  final OperatorData operatorData;
  final Operator oper;
  final Skill skill;
  final int skillLevel;
  final double width;
  late final double dotSize;
  late final double skillImageSize;
  late final double dotBoxSize;

  OperatorSkillItemView(
      {Key? key,
      required this.operatorData,
      required this.oper,
      required this.skill,
      required this.skillLevel,
      required this.width})
      : super(key: key) {
    skillImageSize = width;
    dotBoxSize = skillImageSize * 0.3;
    dotSize = dotBoxSize * 0.3;
  }

  @override
  Widget build(BuildContext context) {
    return _skillView(skill);
  }

  Widget _skillView(Skill skill) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: dotSize * 2, top: dotSize),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: Offset(0.5, 0.5),
              ),
            ],
          ),
          child: Container(
            child: skill.image,
            width: skillImageSize,
            height: skillImageSize,
          ),
        ),
        _skillLevelView(skill)
      ],
    );
  }

  Widget _skillLevelView(Skill skill) {
    return Container(
      margin: EdgeInsets.only(left: dotSize * 0.8),
      width: dotBoxSize,
      height: dotBoxSize,
      color: Colors.black,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: dotSize),
            alignment: Alignment.center,
            child: ClipOval(
              child: Container(
                color: _dotColor(0, skillLevel),
                width: dotSize,
                height: dotSize,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: dotSize, right: dotSize * 1.1),
            alignment: Alignment.center,
            child: ClipOval(
              child: Container(
                color: _dotColor(1, skillLevel),
                width: dotSize,
                height: dotSize,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: dotSize, left: dotSize * 1.1),
            alignment: Alignment.center,
            child: ClipOval(
              child: Container(
                color: _dotColor(2, skillLevel),
                width: dotSize,
                height: dotSize,
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _dotColor(int index, int level) {
    return level > index ? Colors.white : Colors.grey;
  }
}
