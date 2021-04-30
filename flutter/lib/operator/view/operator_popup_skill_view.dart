import 'dart:math';

import 'package:arknights/operator/operator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorSkillPopupView extends StatefulWidget {
  final OperatorData operatorData;
  final Operator oper;
  final List<Skill> skills;

  const OperatorSkillPopupView(
      {Key? key,
      required this.operatorData,
      required this.oper,
      required this.skills})
      : super(key: key);
  @override
  OperatorSkillPopupState createState() => OperatorSkillPopupState(
      operatorData: operatorData, oper: oper, skills: skills);
}

class OperatorSkillPopupState extends State<OperatorSkillPopupView> {
  final OperatorData operatorData;
  final Operator oper;
  final List<Skill> skills;
  List<int> skillLevel;

  OperatorSkillPopupState(
      {Key? key,
      required this.operatorData,
      required this.oper,
      required this.skills})
      : skillLevel = operatorData.skillLevel {
    if (skillLevel.length == 0) {
      skillLevel = List.filled(oper.skills.length, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      title: Text(
        '技能专精',
        style: TextStyle(color: Colors.white),
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _skillViews(),
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            skillLevel = skillLevel
                .map((e) => max(e, OperatorData.minSkillLevel))
                .map((e) => min(e, OperatorData.maxSkillLevel))
                .toList();
            BlocProvider.of<OperatorDataBloc>(context).add(
                OperatorDataUpdateEvent(
                    data: operatorData.copyWith(skillLevel: skillLevel)));
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: Size(50, 30),
              padding: EdgeInsets.zero),
          child: Text(
            "确定",
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: Size(50, 30),
              padding: EdgeInsets.zero),
          child: Text(
            "取消",
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buttonView({required Widget child, required VoidCallback onTap}) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white),
          minimumSize: Size(30, 30),
          padding: EdgeInsets.zero),
      child: child,
    );
  }

  List<Widget> _skillViews() {
    return skills.map((e) => _skillItemView(e, skills.indexOf(e))).toList();
  }

  Widget _skillItemView(Skill skill, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OperatorSkillItemView(
              operatorData: operatorData,
              oper: oper,
              skill: skill,
              skillLevel: skillLevel[index],
              width: 60,
            ),
            SizedBox(height: 5),
            Text(
              skill.name,
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
        SizedBox(width: 5),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buttonView(
              onTap: () {
                setState(() {
                  skillLevel[index] += 1;
                  skillLevel[index] =
                      min(skillLevel[index], OperatorData.maxSkillLevel);
                });
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            _buttonView(
              onTap: () {
                setState(() {
                  skillLevel[index] -= 1;
                  skillLevel[index] =
                      max(skillLevel[index], OperatorData.minSkillLevel);
                });
              },
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
