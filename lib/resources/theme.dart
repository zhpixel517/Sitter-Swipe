import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    focusColor: TanPallete.tan,
    splashColor: TanPallete.creamWhite,
    colorScheme: ThemeData().colorScheme.copyWith(secondary: TanPallete.tan),
    primaryColor: TanPallete.tan,
    secondaryHeaderColor: TanPallete.darkGrey,
    textTheme: TextTheme(
      headline1:
          Fonts.poppins.copyWith(fontWeight: FontWeight.w800, fontSize: 25),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(TanPallete.tan),
          elevation: MaterialStateProperty.all<double>(2.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.elevatedButtonBorderRadius)))),
          textStyle: MaterialStateProperty.all(
            Fonts.poppins.copyWith(fontWeight: FontWeight.w500),
          ),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
              horizontal: AppPadding.elevatedButtonHorizontalPadding,
              vertical: AppPadding.elevatedButtonVerticalPadding))),
    ),
  );
}

BottomNavigationBarTheme getBottomNavigationBarTheme(
    List<BottomNavigationBarItem> items, int index, Function(int) onTap) {
  return BottomNavigationBarTheme(
      data: const BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          unselectedIconTheme:
              IconThemeData(color: TanPallete.darkGrey, size: 30.0),
          selectedIconTheme: IconThemeData(color: TanPallete.tan, size: 40.0)),
      child:
          BottomNavigationBar(items: items, currentIndex: index, onTap: onTap));
}
