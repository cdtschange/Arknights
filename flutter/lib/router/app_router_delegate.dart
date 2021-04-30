import 'package:arknights/router/ui_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_state.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final GlobalKey<NavigatorState> navigatorKey;

  final List<MaterialPage> _pages = [];
  final AppState appState;

  AppRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    appState.addListener(() {
      notifyListeners();
    });
  }

  /// Getter for a list that cannot be changed
  List<MaterialPage> get pages => List.unmodifiable(_pages);

  /// Number of pages function
  int numPages() => _pages.length;

  @override
  PageConfiguration get currentConfiguration =>
      _pages.last.arguments as PageConfiguration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: buildPages(),
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void _removePage(MaterialPage page) {
    _pages.remove(page);
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void _addPageData(Widget? child, PageConfiguration? pageConfig) {
    if (child == null || pageConfig == null) return;
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  void addPage(PageConfiguration? pageConfig) {
    if (pageConfig == null) return;
    final conainsPage = _pages
        .map((e) => e.arguments as PageConfiguration)
        .contains(pageConfig);
    if (conainsPage) {
      List<MaterialPage> newPages = [];
      for (var page in _pages) {
        newPages.add(page);
        if (page.arguments as PageConfiguration == pageConfig) {
          break;
        }
      }
      setPath(newPages);
      return;
    }
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration) != pageConfig;

    if (shouldAddPage) {
      final page = pageConfig.page;
      if (page != null) {
        _addPageData(page, pageConfig);
      }
    }
  }

  void replace(PageConfiguration? newRoute) {
    if (newRoute == null) return;
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replaceAll(PageConfiguration? newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfiguration newRoute) {
    addPage(newRoute);
  }

  void pushWidget(Widget? child, PageConfiguration? newRoute) {
    _addPageData(child, newRoute);
  }

  void addAll(List<PageConfiguration>? routes) {
    _pages.clear();
    routes?.forEach((route) {
      addPage(route);
    });
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration? pageData) {
    if (pageData == null) SynchronousFuture(null);
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration) != pageData!;
    if (shouldAddPage) {
      _pages.clear();
      addPage(pageData);
    }
    return SynchronousFuture(null);
  }

  List<Page> buildPages() {
    if (!appState.homeFinished) {
      replaceAll(Pages.Home.pageConfig());
    } else {
      switch (appState.currentAction.state) {
        case PageState.none:
          break;
        case PageState.addPage:
          addPage(appState.currentAction.page);
          break;
        case PageState.pop:
          pop();
          break;
        case PageState.replace:
          replace(appState.currentAction.page);
          break;
        case PageState.replaceAll:
          replaceAll(appState.currentAction.page);
          break;
        case PageState.addWidget:
          pushWidget(
              appState.currentAction.widget, appState.currentAction.page);
          break;
        case PageState.addAll:
          addAll(appState.currentAction.pages);
          break;
      }
    }
    appState.resetCurrentAction();
    return List.of(_pages);
  }
}
