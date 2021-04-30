import 'package:flutter/material.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorRarityView extends StatelessWidget {
  final Operator oper;

  const OperatorRarityView({Key? key, required this.oper}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: 12,
          child: _Triangle(
            color: Colors.black,
          )),
      Row(
        children: [
          Container(
            child: Container(
              child: oper.rarityYellowImage,
              height: 14,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ],
      )
    ]);
  }
}

class _TriangleShapesPainter extends CustomPainter {
  final Color color;
  _TriangleShapesPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _Triangle extends StatelessWidget {
  const _Triangle({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _TriangleShapesPainter(color), child: Container());
  }
}
