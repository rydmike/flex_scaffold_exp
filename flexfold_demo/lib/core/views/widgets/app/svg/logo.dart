import 'dart:ui' as ui;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required this.side,
    this.foregroundColor = const Color.fromARGB(255, 1, 156, 100),
    this.backgroundColor = const Color.fromARGB(255, 243, 80, 33),
  });

  final double side;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(side, side),
      painter: LogoPainter(foregroundColor, backgroundColor),
    );
  }
}

class LogoPainter extends CustomPainter {
  const LogoPainter(
    this.foregroundColor,
    this.backgroundColor,
  );
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint0 = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
      Offset(size.width * 0.50, size.height * 0.05),
      Offset(size.width * 0.95, size.height * 0.95),
      <Color>[
        backgroundColor.brighten(20),
        backgroundColor.lighten(10),
        backgroundColor,
        backgroundColor.darken(10),
        backgroundColor.darken(20),
      ],
      <double>[0, 0.2, 0.5, 0.9, 1],
    );

    final Path path0 = Path();
    path0.moveTo(size.width * 0.5003965, size.height * 0.0491882);
    path0.cubicTo(
        size.width * 0.6821000,
        size.height * 0.0498000,
        size.width * 0.9529900,
        size.height * 0.1758600,
        size.width * 0.9518302,
        size.height * 0.5006218);
    path0.cubicTo(
        size.width * 0.9529900,
        size.height * 0.6816600,
        size.width * 0.8175900,
        size.height * 0.9527000,
        size.width * 0.5003965,
        size.height * 0.9520555);
    path0.cubicTo(
        size.width * 0.3209600,
        size.height * 0.9527000,
        size.width * 0.0501300,
        size.height * 0.8172000,
        size.width * 0.0489629,
        size.height * 0.5006218);
    path0.cubicTo(
        size.width * 0.0501300,
        size.height * 0.3206700,
        size.width * 0.1856400,
        size.height * 0.0498000,
        size.width * 0.5003965,
        size.height * 0.0491882);
    path0.close();

    canvas.drawPath(path0, paint0);

    final Paint paint1 = Paint()
      ..color = foregroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 7.19;

    final Path path1 = Path();
    path1.moveTo(size.width * 0.2700000, size.height * 0.9300000);
    path1.quadraticBezierTo(size.width * 0.1768000, size.height * 0.6442200,
        size.width * 0.0800000, size.height * 0.3900000);
    path1.cubicTo(
        size.width * 0.0067100,
        size.height * 0.1239100,
        size.width * 0.0940200,
        size.height * 0.0239500,
        size.width * 0.1900000,
        size.height * 0.0900000);
    path1.quadraticBezierTo(size.width * 0.3519000, size.height * 0.2431500,
        size.width * 0.2900000, size.height * 0.8800000);
    path1.quadraticBezierTo(size.width * 0.5453900, size.height * 0.7337900,
        size.width * 0.6381819, size.height * 0.3509091);
    path1.cubicTo(
        size.width * 0.6863500,
        size.height * 0.1742500,
        size.width * 0.8152300,
        size.height * 0.0174100,
        size.width * 0.9100000,
        size.height * 0.0800000);
    path1.cubicTo(
        size.width * 0.9976100,
        size.height * 0.1972500,
        size.width * 0.9434600,
        size.height * 0.3436600,
        size.width * 0.8981819,
        size.height * 0.4409091);
    path1.quadraticBezierTo(size.width * 0.7378900, size.height * 0.7534100,
        size.width * 0.2700000, size.height * 0.9300000);
    path1.close();

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
