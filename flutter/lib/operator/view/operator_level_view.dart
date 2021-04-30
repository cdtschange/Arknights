import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorLevelView extends StatelessWidget {
  final OperatorData operatorData;
  final Operator oper;
  final double width;

  const OperatorLevelView(
      {Key? key,
      required this.operatorData,
      required this.oper,
      required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      child: _Arc(
        thick: 1,
        color: Color(0xFFFFFF00),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 2),
              alignment: Alignment.center,
              child: Text(
                operatorData.level.toString(),
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 12),
              ),
            ),
            Positioned(
              top: 1,
              child: Container(
                width: width,
                alignment: Alignment.topCenter,
                child: Text(
                  "LV",
                  style: TextStyle(color: Colors.white, fontSize: 4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Arc extends StatelessWidget {
  const _Arc(
      {Key? key, required this.child, required this.color, required this.thick})
      : super(key: key);
  final Color color;
  final double thick;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _GradientArcPainter(progress: 100, width: thick, colors: [
          Colors.transparent,
          color,
          color,
          color,
          Colors.transparent
        ]),
        child: Center(child: this.child));
  }
}

class _GradientArcPainter extends CustomPainter {
  const _GradientArcPainter({
    required this.progress,
    required this.colors,
    required this.width,
  }) : super();

  final double progress;
  final List<Color> colors;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = new SweepGradient(
      startAngle: 1 * math.pi / 2,
      endAngle: 5 * math.pi / 2,
      tileMode: TileMode.repeated,
      colors: colors,
    );

    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (width / 2);
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
