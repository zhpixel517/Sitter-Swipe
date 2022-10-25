// function that returns the correct text color depending on the image backgrounf

import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';

Color calculateTextColor(Color background) {
  return background.computeLuminance() >= 0.5 ? Colors.black : Colors.white;
}

Color calculateSecondaryTextColor(Color background) {
  return background.computeLuminance() >= 0.5
      ? TanPallete.darkGrey
      : TanPallete.tan;
}
