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
    /*
    sliderTheme: const SliderThemeData(
        activeTrackColor: TanPallete.tan,
        inactiveTrackColor: TanPallete.creamWhite,
        thumbColor: TanPallete.tan,
        overlayColor: TanPallete.creamWhite),
        */
    chipTheme: ChipThemeData(
        elevation: 0,
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
      bodyLarge: Fonts.poppins.copyWith(fontSize: 15),
      displayLarge:
          Fonts.poppins.copyWith(fontWeight: FontWeight.w800, fontSize: 25),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(TanPallete.tan),
      elevation: MaterialStateProperty.all<double>(0.0),
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

InputDecoration globalInputDecoration(
    FocusNode focusNode, String labelText, IconData prefixIcon) {
  return InputDecoration(
      filled: true,
      fillColor: TanPallete.creamWhite,
      prefixIcon: Icon(
        prefixIcon,
        color: focusNode.hasFocus ? TanPallete.tan : TanPallete.darkGrey,
      ),
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
