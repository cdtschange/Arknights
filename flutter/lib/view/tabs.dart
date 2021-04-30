import 'dart:async';

import 'package:arknights/model/image_resource.dart';
import 'package:arknights/operator/view/operator_page.dart';
import 'package:arknights/router/app_state.dart';
import 'package:arknights/stage/view/zone_page.dart';
import 'package:arknights/item/view/item_group_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  bool _initialized = false;
  int tabIndex = 0;
  List<Widget> tabs = [];
  late AppState appState;
  @override
  void initState() {
    super.initState();
    tabs = [
      OperatorPage(),
      ItemGroupPage(),
      ZonePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    return Scaffold(
      body: tabs[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(ImageResource.iconOperator)),
              label: '干员',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(ImageResource.iconDepot)),
              label: '道具',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(ImageResource.iconOperation)),
              label: '关卡',
            ),
          ]),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;
      Timer(const Duration(milliseconds: 1000), () {
        appState.setHomeFinished();
      });
    }
  }
}
