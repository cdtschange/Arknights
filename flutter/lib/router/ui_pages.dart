import 'package:arknights/item/view/view.dart';
import 'package:arknights/stage/view/view.dart';
import 'package:arknights/operator/view/view.dart';
import 'package:arknights/view/tabs.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

enum Pages { Home, Item, Stage, StageDetail, Operator }

class PageConfiguration extends Equatable {
  final String key;
  final String path;
  final Map<String, String>? arguments;
  final Pages uiPage;

  @override
  List<Object?> get props => [key, path, arguments, uiPage];

  String get queryParameter => Uri(queryParameters: arguments).query;
  String get location => arguments == null ? path : "$path?$queryParameter";

  PageConfiguration(
      {required this.key,
      required this.path,
      this.arguments,
      required this.uiPage});

  Widget? get page {
    switch (uiPage) {
      case Pages.Home:
        return TabsPage();
      case Pages.Item:
        final itemId = arguments?["itemId"];
        final name = arguments?["name"];
        if (itemId?.isNotEmpty == true && name?.isNotEmpty == true) {
          return ItemDetailPage(itemId: itemId!, name: name!);
        }
        return null;
      case Pages.Stage:
        final zoneId = arguments?["zoneId"];
        final itemId = arguments?["itemId"];
        final name = arguments?["name"];
        if (zoneId?.isNotEmpty == true && name?.isNotEmpty == true) {
          return StagePage.fromZone(zoneId: zoneId!, name: name!);
        } else if (itemId?.isNotEmpty == true && name?.isNotEmpty == true) {
          return StagePage.fromItem(itemId: itemId!, name: name!);
        } else {
          return null;
        }
      case Pages.StageDetail:
        final stageId = arguments?["stageId"];
        final name = arguments?["name"];
        if (stageId?.isNotEmpty == true && name?.isNotEmpty == true) {
          return StageDetailPage(stageId: stageId!, name: name!);
        }
        return null;
      case Pages.Operator:
        final name = arguments?["name"];
        if (name?.isNotEmpty == true) {
          return OperatorDetailPage(name: name!);
        }
        return null;
    }
  }
}

extension PagesExtension on Pages {
  String get name {
    switch (this) {
      case Pages.Home:
        return 'Home';
      case Pages.Item:
        return 'Item';
      case Pages.Stage:
        return 'Stage';
      case Pages.StageDetail:
        return 'StageDetail';
      case Pages.Operator:
        return 'Operator';
    }
  }

  String get path {
    switch (this) {
      case Pages.Home:
        return '/';
      case Pages.Item:
        return '/item';
      case Pages.Stage:
        return '/stage';
      case Pages.StageDetail:
        return '/stage/detail';
      case Pages.Operator:
        return '/operator';
    }
  }

  static Pages? from({required String path}) {
    switch (path) {
      case '/':
        return Pages.Home;
      case '/item':
        return Pages.Item;
      case '/stage':
        return Pages.Stage;
      case '/stage/detail':
        return Pages.StageDetail;
      case '/operator':
        return Pages.Operator;
    }
  }

  PageConfiguration pageConfig({Map<String, String>? arguments}) {
    return PageConfiguration(
        key: name + ":" + arguments.toString(),
        path: path,
        arguments: arguments,
        uiPage: this);
  }

  PageConfiguration itemPageConfig(
      {required String itemId, required String name}) {
    return pageConfig(arguments: {"itemId": itemId, "name": name});
  }

  PageConfiguration zoneStagePageConfig(
      {required String zoneId, required String name}) {
    return pageConfig(arguments: {"zoneId": zoneId, "name": name});
  }

  PageConfiguration itemStagePageConfig(
      {required String itemId, required String name}) {
    return pageConfig(arguments: {"itemId": itemId, "name": name});
  }

  PageConfiguration stagePageConfig(
      {required String stageId, required String name}) {
    return pageConfig(arguments: {"stageId": stageId, "name": name});
  }

  PageConfiguration operatorPageConfig({required String name}) {
    return pageConfig(arguments: {"name": name});
  }
}
