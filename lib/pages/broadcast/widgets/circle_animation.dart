
import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';

class CircleRipplePainter extends CustomPainter {
  double? radius;

  CircleRipplePainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    final paint = Paint()
      ..color = TanPallete.tan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    /// I have to add 75 to each, since the "center" is actually the top
    /// left pixel so it hides behind the avatar
    canvas.drawCircle(
      Offset(center.width + 75, center.height + 75),
      radius!,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
