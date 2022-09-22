import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';

ThemeData getApplicationTheme() {
  return ThemeData();
}

BottomNavigationBarTheme getBottomNavigationBarTheme(
    List<BottomNavigationBarItem> items, int index, Function(int) onTap) {
  return BottomNavigationBarTheme(
      data: const BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          selectedIconTheme: IconThemeData(color: TanPallete.tan, size: 30.0)),
      child:
          BottomNavigationBar(items: items, currentIndex: index, onTap: onTap));
}
