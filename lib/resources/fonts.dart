import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sitter_swipe/resources/colors.dart';

class Fonts {
  static TextStyle poppins = GoogleFonts.poppins();
  static TextStyle bold = poppins.copyWith(fontWeight: FontWeight.w600);
  static TextStyle secondaryFont = poppins.copyWith(
      fontWeight: FontWeight.w300,
      color: TanPallete.tan,
      fontSize: FontSizes.secondaryFontSize);
  static TextStyle mediumStyle = poppins.copyWith(
      fontWeight: FontWeight.w500,
      color: TanPallete.darkGrey,
      fontSize: FontSizes.stateRendererMessageSize);
  static TextStyle smallText = poppins.copyWith(
    fontWeight: FontWeight.w200,
    color: TanPallete.lightGrey,
  );
  static TextStyle swipeScreenLocationTitle = poppins.copyWith(
    fontWeight: FontWeight.w300,
    color: TanPallete.darkGrey,
    fontSize: 15.0,
  );
  static TextStyle interestedTitle = poppins.copyWith(
      fontWeight: FontWeight.w300, color: Colors.white, fontSize: 10.0);
  static TextStyle otherChatTextStyle = poppins.copyWith(
      fontWeight: FontWeight.w600,
      color: TanPallete.richBlack,
      fontSize: 15,
      letterSpacing: 0.25);

  static TextStyle selfChatTextStyle =
      otherChatTextStyle.copyWith(color: Colors.white);
}

class FontSizes {
  static double secondaryFontSize = 15.0;
  static double stateRendererMessageSize = 16.0;
  static double dollarAmountFontSize = 25.0;
  static double profileAttributesSize = 30.0;
}
