import 'package:flutter/material.dart';

class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background Grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFFE2EAF0)
      ..strokeWidth = 1.0;

    const double gridSpacing = 40.0;
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Road styling: casing border first, then pink/beige inner fill.
    final borderPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFFFEE2E2) // Light pink/beige road
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Define main route paths
    final path1 = Path();
    path1.moveTo(0, size.height * 0.15);
    path1.quadraticBezierTo(size.width * 0.4, size.height * 0.25, size.width * 0.6, size.height * 0.6);
    path1.quadraticBezierTo(size.width * 0.7, size.height * 0.85, size.width, size.height * 0.9);

    final path2 = Path();
    path2.moveTo(size.width * 0.1, size.height);
    path2.quadraticBezierTo(size.width * 0.25, size.height * 0.6, size.width * 0.5, size.height * 0.45);
    path2.quadraticBezierTo(size.width * 0.75, size.height * 0.3, size.width, size.height * 0.2);

    final path3 = Path();
    path3.moveTo(0, size.height * 0.6);
    path3.quadraticBezierTo(size.width * 0.3, size.height * 0.5, size.width * 0.5, size.height * 0.45);
    path3.quadraticBezierTo(size.width * 0.7, size.height * 0.4, size.width, size.height * 0.7);

    final path4 = Path();
    path4.moveTo(size.width * 0.8, 0);
    path4.lineTo(size.width * 0.4, size.height);

    // Draw borders (casing)
    canvas.drawPath(path1, borderPaint);
    canvas.drawPath(path2, borderPaint);
    canvas.drawPath(path3, borderPaint);
    canvas.drawPath(path4, borderPaint);

    // Draw fills
    canvas.drawPath(path1, fillPaint);
    canvas.drawPath(path2, fillPaint);
    canvas.drawPath(path3, fillPaint);
    canvas.drawPath(path4, fillPaint);

    // Intersection Nodes (circles)
    final nodeBorderPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final nodeFillPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..style = PaintingStyle.fill;

    final List<Offset> intersections = [
      Offset(size.width * 0.42, size.height * 0.32),
      Offset(size.width * 0.59, size.height * 0.36),
      Offset(size.width * 0.15, size.height * 0.44),
      Offset(size.width * 0.88, size.height * 0.66),
    ];

    for (final pos in intersections) {
      canvas.drawCircle(pos, 12.0, nodeFillPaint);
      canvas.drawCircle(pos, 12.0, nodeBorderPaint);

      // inner pink dot
      canvas.drawCircle(pos, 6.0, Paint()..color = const Color(0xFFFEE2E2));
      canvas.drawCircle(pos, 6.0, Paint()..color = const Color(0xFF94A3B8)..style = PaintingStyle.stroke..strokeWidth = 2.0);
    }

    // Vehicle dots (solid blue circles)
    final vehiclePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.fill;
    final vehicleShadow = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.fill;

    final List<Offset> vehicles = [
      Offset(size.width * 0.64, size.height * 0.23),
      Offset(size.width * 0.52, size.height * 0.46),
      Offset(size.width * 0.36, size.height * 0.61),
    ];

    for (final pos in vehicles) {
      canvas.drawCircle(pos + const Offset(0, 2), 9.0, vehicleShadow);
      canvas.drawCircle(pos, 9.0, vehiclePaint);
      canvas.drawCircle(pos, 9.0, Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 2.0);
    }

    // Text labels for roads (e.g. A620, A624, A628)
    const textStyle = TextStyle(
      color: Color(0xFF15803D), // Green text
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );

    _drawText(canvas, 'A620', Offset(size.width * 0.78, size.height * 0.06), textStyle);
    _drawText(canvas, 'A624', Offset(size.width * 0.16, size.height * 0.50), textStyle);
    _drawText(canvas, 'A628', Offset(size.width * 0.81, size.height * 0.59), textStyle);
    _drawText(canvas, 'A624', Offset(size.width * 0.77, size.height * 0.70), textStyle);
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}