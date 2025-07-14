import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLoaderController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
