import 'dart:math';

import 'package:arknights/operator/operator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorRankPopupView extends StatelessWidget {
  final OperatorData operatorData;
  final textController = new TextEditingController();

  OperatorRankPopupView({Key? key, required this.operatorData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    textController.text = operatorData.rankLevel.toString();
    return AlertDialog(
      backgroundColor: Colors.black87,
      title: Text(
        '技能等级',
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
                    onTap: () => textController.text =
                        OperatorData.maxRankLevel.toString(),
                    child: Text(
                      "MAX",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  _buttonView(
                    onTap: () => textController.text =
                        OperatorData.minRankLevel.toString(),
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
                      var rankLevel = int.parse(textController.text) + 1;
                      rankLevel = min(rankLevel, OperatorData.maxRankLevel);
                      textController.text = rankLevel.toString();
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  _buttonView(
                    onTap: () {
                      var rankLevel = int.parse(textController.text) - 1;
                      rankLevel = max(rankLevel, OperatorData.minRankLevel);
                      textController.text = rankLevel.toString();
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
            var rankLevel = int.parse(textController.text);
            rankLevel = max(rankLevel, OperatorData.minLevel);
            rankLevel = min(rankLevel, OperatorData.maxLevel);
            BlocProvider.of<OperatorDataBloc>(context).add(
                OperatorDataUpdateEvent(
                    data: operatorData.copyWith(rankLevel: rankLevel)));
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
