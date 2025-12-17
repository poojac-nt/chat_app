import 'package:flutter/material.dart';

class SimpleCirclePainter extends CustomPainter {
  final List<Circle> circles;
  SimpleCirclePainter({required this.circles});
  @override
  void paint(Canvas canvas, Size size) {
    final paintObj = Paint()..style = PaintingStyle.fill;
    for (var c in circles) {
      paintObj.color = c.fillColor;
      final offset = Offset(size.width * c.xPos, size.height * c.yPos);
      final radius = size.width / c.radius;
      canvas.drawCircle(offset, radius, paintObj);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class Circle {
  final double radius;
  final double xPos;
  final double yPos;
  final Color fillColor;
  Circle({
    required this.radius,
    required this.xPos,
    required this.yPos,
    required this.fillColor,
  });
}
