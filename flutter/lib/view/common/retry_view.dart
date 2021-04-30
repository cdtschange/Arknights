import 'package:flutter/material.dart';

class RetryView extends StatelessWidget {
  final VoidCallback onTap;
  RetryView(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.replay),
          onPressed: onTap),
    );
  }
}
