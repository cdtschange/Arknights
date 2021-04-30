import 'package:flutter/material.dart';

import 'ui_pages.dart';

class PageAction {
  PageState state;
  PageConfiguration? page;
  List<PageConfiguration>? pages;
  Widget? widget;

  PageAction({this.state = PageState.none, this.page, this.pages, this.widget});
}

enum PageState { none, addPage, addAll, addWidget, pop, replace, replaceAll }

class AppState extends ChangeNotifier {
  bool _homeFinished = false;
  bool get homeFinished => _homeFinished;
  PageAction _currentAction = PageAction();
  PageAction get currentAction => _currentAction;
  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  AppState();

  void resetCurrentAction() {
    _currentAction = PageAction();
  }

  void setHomeFinished() {
    _homeFinished = true;
    notifyListeners();
  }
}
