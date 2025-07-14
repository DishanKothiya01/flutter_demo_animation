import 'package:get/get.dart';

import 'package:flutter/material.dart';

class ExplicitAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> sizeAnimation;
  late Animation<Color?> colorAnimation;
  late Animation<double> rotationAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    sizeAnimation = Tween<double>(begin: 100, end: 200).animate(animationController);
    colorAnimation = ColorTween(begin: Colors.amber, end: Colors.purple)
        .animate(animationController);
    rotationAnimation = Tween<double>(begin: 0, end: 1 * 3.1416) // radians
        .animate(animationController);
  }

  void toggleAnimation() {
    if (animationController.status == AnimationStatus.completed) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
