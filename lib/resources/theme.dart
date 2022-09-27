import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
    listTileTheme: const ListTileThemeData(shape: BeveledRectangleBorder()),
    chipTheme: ChipThemeData(
        backgroundColor: TanPallete.lightGrey,
        labelStyle: Fonts.smallText.copyWith(color: Colors.white)),
    appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: TanPallete.darkGrey),
        centerTitle: false,
        titleTextStyle: Fonts.bold.copyWith(
            color: TanPallete.darkGrey,
            fontSize: AppSizes.forgotPasswordAppBarTitleTextSize)),
    secondaryHeaderColor: TanPallete.darkGrey,
    inputDecorationTheme: InputDecorationTheme(
        errorStyle: Fonts.bold.copyWith(color: Colors.red),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: AppSizes.focusedInputBorderSize, color: Colors.red),
            borderRadius:
                BorderRadius.circular(AppSizes.elevatedButtonBorderRadius)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: AppSizes.focusedInputBorderSize, color: TanPallete.tan),
            borderRadius:
                BorderRadius.circular(AppSizes.elevatedButtonBorderRadius)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: AppSizes.enabledInputBorderSize),
            borderRadius:
                BorderRadius.circular(AppSizes.elevatedButtonBorderRadius))),
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
    )),
  );
}

BottomNavigationBarTheme getBottomNavigationBarTheme(
    List<BottomNavigationBarItem> items, int index, Function(int) onTap) {
  return BottomNavigationBarTheme(
      data: const BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          unselectedIconTheme: IconThemeData(
              color: TanPallete.darkGrey, size: AppSizes.largeIconSize),
          selectedIconTheme: IconThemeData(color: TanPallete.tan, size: 40.0)),
      child:
          BottomNavigationBar(items: items, currentIndex: index, onTap: onTap));
}

InputDecoration searchBarDecoration(FocusNode focusNode, String labelText) {
  return InputDecoration(
      filled: true,
      fillColor: TanPallete.creamWhite,
      prefixIcon: const Icon(EvaIcons.search),
      labelText: labelText,
      labelStyle: Fonts.smallText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.searchBarBorderRadius))),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TanPallete.creamWhite),
          borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.searchBarBorderRadius))),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TanPallete.creamWhite),
          borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.searchBarBorderRadius))));
}
