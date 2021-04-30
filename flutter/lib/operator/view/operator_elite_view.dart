import 'package:flutter/material.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorEliteView extends StatelessWidget {
  final OperatorData operatorData;
  final Operator oper;
  final double width;

  const OperatorEliteView(
      {Key? key,
      required this.operatorData,
      required this.oper,
      required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (operatorData.elite == 0) {
      return Container();
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: width * 1.2,
          padding: EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(width: 0.5, color: Colors.white),
            ),
          ),
        ),
        Container(
          child: operatorData.eliteImage,
          width: width,
        )
      ],
    );
  }
}
