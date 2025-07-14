import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_loader_controller.dart';

class CustomLoaderView extends StatelessWidget {
  CustomLoaderView({super.key});

  final CustomLoaderController con = Get.put(CustomLoaderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Custom Loader'),),
      body: Center(
        child: AnimatedBuilder(
          animation: con.animationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: con.animationController.value * 2 * pi,
              child: CustomPaint(
                painter: LoaderPainter(
                  strokeWidth: 8,
                  color: Colors.orangeAccent,
                  startAngle: 5,
                  sweepAngle: pi * 1.6,
                  strokeCap: StrokeCap.round,
                  style: PaintingStyle.stroke,
                ),
                child: const SizedBox(height: 100, width: 100),
              ),
            );

          },
        ),
      ),
    );
  }
}

class LoaderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double startAngle;
  final double sweepAngle;
  final StrokeCap strokeCap;
  final PaintingStyle style;

  LoaderPainter({
    required this.strokeWidth,
    required this.color,
    this.startAngle = 0,
    this.sweepAngle = 3.14 * 1.6, // default 288 degrees
    this.strokeCap = StrokeCap.round,
    this.style = PaintingStyle.stroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = style
      ..strokeCap = strokeCap;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2.2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
