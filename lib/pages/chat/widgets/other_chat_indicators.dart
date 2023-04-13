// other chat indicators
// status, read indicators, and time?

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class ChatIndicators {
  static Widget timeIndicator(String time, bool isSelfMessage) {
    return Text(time,
        style: Fonts.smallText,
        textAlign: isSelfMessage ? TextAlign.end : TextAlign.start);
  }

  static Widget readIndicator() {
    return Text("Read", style: Fonts.smallText, textAlign: TextAlign.end);
  }

  static Widget typingIndicator() {
    return const SpinKitThreeBounce(
        color: TanPallete.darkGrey, size: AppSizes.typingIndicatorSize);
  }
}
