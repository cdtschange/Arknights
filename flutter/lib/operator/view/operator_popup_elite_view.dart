import 'dart:math';

import 'package:arknights/operator/operator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorElitePopupView extends StatefulWidget {
  final OperatorData operatorData;

  const OperatorElitePopupView({Key? key, required this.operatorData})
      : super(key: key);
  @override
  OperatorElitePopupState createState() =>
      OperatorElitePopupState(operatorData: operatorData);
}

class OperatorElitePopupState extends State<OperatorElitePopupView> {
  final OperatorData operatorData;
  int elite;

  OperatorElitePopupState({Key? key, required this.operatorData})
      : elite = operatorData.elite;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      title: Text(
        '精英化',
        style: TextStyle(color: Colors.white),
      ),
      content: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                elite == 0
                    ? "无精英化"
                    : elite == 1
                        ? "精英化一"
                        : "精英化二",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: Colors.white),
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
                      setState(() {
                        elite++;
                        elite = min(elite, OperatorData.maxElite);
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
                        elite--;
                        elite = max(elite, OperatorData.minElite);
                      });
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
            elite = max(elite, OperatorData.minElite);
            elite = min(elite, OperatorData.maxElite);
            BlocProvider.of<OperatorDataBloc>(context).add(
                OperatorDataUpdateEvent(
                    data: operatorData.copyWith(elite: elite)));
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
