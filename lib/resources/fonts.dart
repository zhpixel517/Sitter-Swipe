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
}

class FontSizes {
  static double secondaryFontSize = 15.0;
}
