import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';

class RadioBackground extends StatelessWidget {
  const RadioBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomPaint(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        painter: RadioBackgroundCustomPainter(),
      );
    });
  }
}

class RadioBackgroundCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    var paint = Paint()
      ..color = TanPallete.lightGrey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        Offset(center.width, center.height + (size.height * 0.7)), 450, paint);
    canvas.drawCircle(
        Offset(center.width, center.height + (size.height * 0.6)), 450, paint);
    canvas.drawCircle(
        Offset(center.width, center.height + (size.height * 0.5)), 450, paint);
    canvas.drawCircle(
        Offset(center.width, center.height + (size.height * 0.4)), 450, paint);
    canvas.drawCircle(
        Offset(center.width, center.height + (size.height * 0.3)), 450, paint);
    canvas.drawCircle(
        Offset(center.width, center.height + (size.height * 0.2)), 450, paint);
    canvas.drawCircle(
        Offset(center.width, center.height + (size.height * 0.1)), 450, paint);
    canvas.drawCircle(
        Offset(center.width, center.height + (size.height * 0.0)), 450, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
