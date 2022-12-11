// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/routes.dart';
import 'package:sitter_swipe/resources/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.login, //TODO: check login/registered state here?
        theme: getApplicationTheme());
  }
}
