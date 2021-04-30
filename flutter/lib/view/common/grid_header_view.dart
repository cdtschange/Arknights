import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridHeaderView extends SliverPersistentHeader {
  final String title;
  final String? detail;
  final bool isMain;
  final VoidCallback? onTap;

  GridHeaderView(
      {required this.title, this.detail, this.isMain = true, this.onTap})
      : super(
            floating: false,
            delegate: _GridHeaderDelegate(
                title: title, detail: detail, isMain: isMain, onTap: onTap));
}

class _GridHeaderDelegate extends SliverPersistentHeaderDelegate {
  _GridHeaderDelegate(
      {required this.title, this.detail, required this.isMain, this.onTap});

  final String title;
  final String? detail;
  final bool isMain;
  final VoidCallback? onTap;

  double get _headerHeight => isMain ? 40 : 30;
  double get _elevation => isMain ? 5 : 3;
  EdgeInsets get _margin =>
      isMain ? EdgeInsets.zero : EdgeInsets.only(bottom: 5);
  Color _backgroundColorOf(BuildContext context) => isMain
      ? Theme.of(context).primaryColor
      : Theme.of(context).secondaryHeaderColor;
  double get _titleTextSize => isMain ? 14 : 12;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
        elevation: _elevation,
        margin: _margin,
        child: Container(
          color: _backgroundColorOf(context),
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.centerLeft,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: _titleTextSize)),
            detail == null
                ? Container()
                : Text(detail!,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: _titleTextSize))
          ]),
        ),
      ),
    );
  }

  @override
  double get maxExtent => _headerHeight;

  @override
  double get minExtent => _headerHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
