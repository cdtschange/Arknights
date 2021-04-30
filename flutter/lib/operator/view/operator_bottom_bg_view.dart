import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:operator_repository/operator_repository.dart';

class OperatorBottomBackgroudView extends StatelessWidget {
  final Operator oper;
  final double width;
  final double height;

  const OperatorBottomBackgroudView(
      {Key? key, required this.oper, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: height * 2.8,
        left: -width * 0.5,
        width: width * 2,
        child: Transform.rotate(
            angle: math.pi / 12,
            child: Container(
                height: height * 1.6,
                child: _Rectangle(
                  colors: colors,
                  width: width * 2,
                  height: height * 1.6,
                ))));
  }

  List<Color> get colors {
    switch (oper.rarity) {
      case 0:
        return [
          Colors.transparent,
          Color(0x11232323),
          Color(0x66585858),
          Color(0x88FFFFFF),
          Color(0xAAFFFFFF),
          Color(0xFFFFFFFF),
          Color(0xFFFFFFFF)
        ];
      case 1:
        return [
          Colors.transparent,
          Color(0x22232323),
          Color(0x88405623),
          Color(0xAACCCC33),
          Color(0xDDDCE537),
          Color(0xFFDCE537),
          Color(0xFFFFFF66)
        ];
      case 2:
        return [
          Colors.transparent,
          Color(0x55233D56),
          Color(0xAA233D56),
          Color(0xDD489DEC),
          Color(0xDD99CCFF),
          Color(0xFF99CCFF),
          Color(0xFF3366CC)
        ];
      case 3:
        return [
          Colors.transparent,
          Color(0x88756D7E),
          Color(0xAA756D7E),
          Color(0xDDCC99CC),
          Color(0xFFEED4EE),
          Color(0xFFFFFFEE),
          Color(0xFFFFFFFF)
        ];
      case 4:
        return [
          Colors.transparent,
          Color(0x5FFEF7DA),
          Color(0xAFFFCC33),
          Color(0xDDFEF7DA),
          Color(0xDDFFFFCC),
          Color(0xFFFFFFCC),
          Color(0xFFFFFFFF)
        ];
      case 5:
        return [
          Colors.transparent,
          Color(0x4FD66400),
          Color(0xAFD66400),
          Color(0xDFFF9900),
          Color(0xAFF0E659),
          Color(0xDFF0E659),
          Color(0xFFF0E659)
        ];
      default:
        return [];
    }
  }
}

class _Rectangle extends StatelessWidget {
  const _Rectangle(
      {Key? key,
      required this.colors,
      required this.width,
      required this.height})
      : super(key: key);
  final List<Color> colors;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: height * 0.4,
          width: width,
          child: Container(
            height: height * 0.6,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2E2E2E),
                    Color(0xFF64433A),
                    Color(0xFF814B3B),
                    Color(0xFF64433A),
                    Color(0xFF2E2E2E),
                    Color(0xFF232323),
                    Color(0xFF232323),
                  ],
                  stops: [0, .01, .05, .15, .30, .41, 1],
                )),
          )),
      Container(
        height: height * 0.4,
        decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
              stops: [0, 0.3, 0.5, 0.7, 0.85, 0.95, 1],
            )),
      )
    ]);
  }
}
