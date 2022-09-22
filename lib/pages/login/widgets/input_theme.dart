import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/nums.dart';

InputDecoration getLoginInputDecoration(
  BuildContext context,
  String labelText,
) {
  return InputDecoration(
      labelText: labelText,
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              width: AppSizes.focusedInputBorderSize, color: Colors.red)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: AppSizes.focusedInputBorderSize,
              color: Theme.of(context).primaryColor),
          borderRadius:
              BorderRadius.circular(AppSizes.elevatedButtonBorderRadius)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: AppSizes.enabledInputBorderSize),
          borderRadius:
              BorderRadius.circular(AppSizes.elevatedButtonBorderRadius)));
}
