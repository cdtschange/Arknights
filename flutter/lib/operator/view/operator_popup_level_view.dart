import 'dart:math';

import 'package:arknights/operator/operator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorLevelPopupView extends StatelessWidget {
  final OperatorData operatorData;
  final textController = new TextEditingController();

  OperatorLevelPopupView({Key? key, required this.operatorData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    textController.text = operatorData.level.toString();
    return AlertDialog(
      backgroundColor: Colors.black87,
      title: Text(
        '等级',
        style: TextStyle(color: Colors.white),
      ),
      content: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buttonView(
                    onTap: () =>
                        textController.text = OperatorData.maxLevel.toString(),
                    child: Text(
                      "MAX",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  _buttonView(
                    onTap: () =>
                        textController.text = OperatorData.minLevel.toString(),
                    child: Text(
                      "MIN",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: Container(
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buttonView(
                    onTap: () {
                      var level = int.parse(textController.text) + 1;
                      level = min(level, OperatorData.maxLevel);
                      textController.text = level.toString();
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  _buttonView(
                    onTap: () {
                      var level = int.parse(textController.text) - 1;
                      level = max(level, OperatorData.minLevel);
                      textController.text = level.toString();
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            var level = int.parse(textController.text);
            level = max(level, OperatorData.minLevel);
            level = min(level, OperatorData.maxLevel);
            BlocProvider.of<OperatorDataBloc>(context).add(
                OperatorDataUpdateEvent(
                    data: operatorData.copyWith(level: level)));
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
          minimumSize: Size(50, 40),
          padding: EdgeInsets.zero),
      child: child,
    );
  }
}
