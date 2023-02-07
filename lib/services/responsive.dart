import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) /
        (_mediaQueryData!.size.width * 0.252);
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) /
        (_mediaQueryData!.size.height * 0.252);
  }
  // that 0.252 was the constant that just seemed to work in my use case
  // gotta learn how to do this correctly
}

class Responsive extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  const Responsive({this.mobile, this.tablet});

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 850;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width < 200 &&
        MediaQuery.of(context).size.width >= 850;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return (size.width >= 850 && tablet != null)
        ? tablet!
        : (size.width < 850)
            ? mobile!
            : const Center(
                child: Text("size err"),
              );
  }
}
