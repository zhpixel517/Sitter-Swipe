// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function? retryActionFunction;

  StateRenderer(
      {super.key, required this.stateRendererType,
      String? message,
      String? title,
      required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? "";

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        _getItemsInColumn([_getAnimatedImage(''), _getMessage(message)]);
        break;
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        // TODO: Handle this case.
        break;
      case StateRendererType.CONTENT_SCREEN_STATE:
        // TODO: Handle this case.
        break;
      case StateRendererType.EMPTY_SCREEN_STATE:
        // TODO: Handle this case.
        break;
    }
    return Container();
  }
}

Widget _getItemsInColumn(List<Widget> children) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ),
  );
}

Widget _getAnimatedImage(String animationName) {
  return SizedBox(
      height: AppSizes.s100,
      width: AppSizes.s100,
      child: Lottie.file(animationName));
}

Widget _getMessage(String message) {
  return Center(
    child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: Fonts.mediumStyle,
        )),
  );
}
