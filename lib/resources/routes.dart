import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/base_screen/base_screen.dart';
import 'package:sitter_swipe/resources/strings.dart';

class Routes {
  static const baseScreen = '/baseScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.baseScreen:
        return MaterialPageRoute(builder: (_) => const BaseScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
