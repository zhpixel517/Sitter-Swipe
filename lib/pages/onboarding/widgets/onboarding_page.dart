import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/fonts.dart';

class CarouselPage extends StatelessWidget {
  final String? pageText;
  CarouselPage({this.pageText});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Placeholder(),
          ),
          Expanded(
            child: Center(
                child: Text(
              pageText!,
              style: Fonts.mediumStyle,
            )),
          ),
        ],
      );
    });
  }
}
