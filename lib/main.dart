import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sitter_swipe/app/app.dart';
import 'package:sitter_swipe/services/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  initAppModule();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
  runApp(MyApp());
}
