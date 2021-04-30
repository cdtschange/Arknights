import 'package:flutter/material.dart';
import 'package:stage_repository/stage_repository.dart';

class ZoneView extends StatelessWidget {
  final Zone zone;
  final VoidCallback onTap;

  const ZoneView({Key? key, required this.zone, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: zone.isMainLine
                      ? zone.image
                      : Container(
                          padding: EdgeInsets.all(0.5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black87,
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(0.5, 2),
                              ),
                            ],
                          ),
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(2),
                            child: Container(
                                color: Theme.of(context).primaryColorDark,
                                child: zone.image),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 2),
              Container(
                child: Text(
                  zone.displayName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
