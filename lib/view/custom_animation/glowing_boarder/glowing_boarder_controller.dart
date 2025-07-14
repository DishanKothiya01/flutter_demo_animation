import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlowingBoarderController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Color?> colorAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    colorAnimation = ColorTween(
      begin: Colors.purple,
      end: Colors.blue,
    ).animate(animationController);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
