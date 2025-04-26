import 'package:flutter/material.dart';
import 'package:merhab/theme/themes.dart';

class GreenWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Wave Layer 1 – farthest, lightest
    final paint1 = Paint()
      ..color = AppTheme.primaryGreenColor.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height);
    path1.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.75,
      size.width * 0.5,
      size.height * 0.85,
    );
    path1.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.95,
      size.width,
      size.height * 0.8,
    );
    path1.lineTo(size.width, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Wave Layer 2 – mid opacity
    final paint2 = Paint()
      ..color = AppTheme.primaryGreenColor.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height);
    path2.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.8,
      size.width * 0.55,
      size.height * 0.88,
    );
    path2.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.95,
      size.width,
      size.height * 0.85,
    );
    path2.lineTo(size.width, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Wave Layer 3 – front, solid
    final paint3 = Paint()
      ..color = AppTheme.primaryGreenColor
      ..style = PaintingStyle.fill;

    final path3 = Path();
    path3.moveTo(0, size.height);
    path3.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.85,
      size.width * 0.6,
      size.height * 0.9,
    );
    path3.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.95,
      size.width,
      size.height * 0.9,
    );
    path3.lineTo(size.width, size.height);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
