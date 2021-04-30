import 'package:flutter/material.dart';

class SlideCard extends StatelessWidget {
  final double sideBarWidth;
  final double padding;
  final String title;
  final Widget child;
  final VoidCallback? arrowOnTap;
  const SlideCard(
      {Key? key,
      required this.title,
      required this.child,
      this.sideBarWidth = 5,
      this.padding = 10,
      this.arrowOnTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: Theme.of(context).secondaryHeaderColor,
                    width: sideBarWidth))),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  arrowOnTap != null
                      ? InkWell(
                          child: Icon(
                            Icons.navigate_next,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: arrowOnTap,
                        )
                      : Container()
                ],
              ),
              SizedBox(height: 5),
              child
            ],
          ),
        ),
      ),
    );
  }
}
