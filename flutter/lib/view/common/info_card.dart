import 'package:flutter/material.dart';
import 'view.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const InfoCard({Key? key, required this.title, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideCard(title: title, child: child);
  }
}
