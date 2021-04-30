import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final Widget child;

  const HeaderCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(padding: EdgeInsets.all(10), child: child),
    );
  }
}
