import 'package:arknights/router/ui_pages.dart';
import 'package:flutter/material.dart';

class AppRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    if (uri.pathSegments.isEmpty) {
      return Pages.Home.pageConfig();
    }

    final page = PagesExtension.from(path: "/" + uri.pathSegments[0])
            ?.pageConfig(arguments: uri.queryParameters) ??
        Pages.Home.pageConfig();
    return page;
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    return RouteInformation(location: configuration.location);
  }
}
