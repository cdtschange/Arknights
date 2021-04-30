import 'package:flutter/material.dart';
import 'view.dart';

class InfoTextCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoTextCard({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: title,
      child: Text(
        content,
        style: TextStyle(color: Colors.black54, fontSize: 12),
      ),
    );
  }
}
