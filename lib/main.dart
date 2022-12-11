import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sitter_swipe/app/app.dart';
import 'package:sitter_swipe/services/di.dart';
import 'package:sitter_swipe/services/responsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  await initAppModule();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(MyApp());
}
