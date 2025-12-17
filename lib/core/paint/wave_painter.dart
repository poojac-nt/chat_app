import 'package:flutter/cupertino.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A90E2)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.lineTo(0, size.height * 0.33);

    // First curve
    path.quadraticBezierTo(
      size.width * 0.12, // control point X
      size.height * 0.3, // control point Y
      size.width * 0.25, // end point X
      size.height * 0.33, // end point Y
    );
    // Second curve
    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.36,
      size.width * 0.57,
      size.height * 0.32,
    );
    // Third curve
    path.quadraticBezierTo(
      size.width * 0.66,
      size.height * 0.3,
      size.width * 0.8,
      size.height * 0.34,
    );
    //Fourth Curve
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.36,
      size.width,
      size.height * 0.33,
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
