import 'package:get/get.dart';
import 'package:flutter/material.dart';

// class CustomGridToListAnimationController extends GetxController with GetSingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<double> animation;
//   final isGrid = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );
//
//     animation = Tween(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: Curves.fastOutSlowIn,
//         reverseCurve: Curves.fastOutSlowIn,
//       ),
//     );
//   }
//
//   void toggleView() {
//     isGrid.toggle();
//     isGrid.value ? animationController.forward() : animationController.reverse();
//   }
//
//   @override
//   void onClose() {
//     animationController.dispose();
//     super.onClose();
//   }
// }
class CustomGridToListAnimationController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;
  final isGrid = false.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600), // Slightly longer duration
    );

    // Main animation for layout changes
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn,
      ),
    );

    // Additional scale animation for items
    scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.95), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 50),
    ]).animate(animationController);

    // Slide animation for items
    slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
  }

  void toggleView() {
    isGrid.toggle();
    if (isGrid.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
