import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'emoji_slider_controller.dart';

class EmojiSliderView extends StatelessWidget {
  EmojiSliderView({super.key});

  final EmojiSliderController con = Get.put(EmojiSliderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smooth Emoji Expression")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return CustomPaint(
              painter: FacePainter(expressionValue: con.expressionValue.value),
              child: const SizedBox(height: 200, width: 200),
            );
          }),
          const SizedBox(height: 40),
          Obx(() {
            return Slider(
              value: con.expressionValue.value,
              onChanged: (val) => con.expressionValue.value = val,
              min: 0.0,
              max: 1.0,
            );
          }),
        ],
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final double expressionValue;

  FacePainter({required this.expressionValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRadius = size.width / 2;

    final paint = Paint()..color = Colors.orangeAccent;

    // Draw face
    canvas.drawCircle(center, faceRadius, paint);

    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(center.dx - 40, center.dy - 30), 5, eyePaint);
    canvas.drawCircle(Offset(center.dx + 40, center.dy - 30), 5, eyePaint);

    // Mouth Path
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Control mouth curve based on expression
    final smileOffset = (expressionValue - 0.5) * 100;

    final mouthPath = Path()
      ..moveTo(center.dx - 40, center.dy + 30)
      ..quadraticBezierTo(
        center.dx,
        center.dy + 30 + smileOffset,
        center.dx + 40,
        center.dy + 30,
      );

    canvas.drawPath(mouthPath, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant FacePainter oldDelegate) => oldDelegate.expressionValue != expressionValue;
}
