import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/routes/app_routes.dart';
import 'explicit_animation_controller.dart';

class ExplicitAnimationView extends StatelessWidget {
  ExplicitAnimationView({super.key});

  final ExplicitAnimationController con = Get.put(ExplicitAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explicit Animation"),actions: [
        GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.pageRoutesTransitionView);
            },
            child: Text('Next').paddingOnly(right: 10))
      ]),
      body: Center(
        child: AnimatedBuilder(
          animation: con.animationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: con.rotationAnimation.value,
              child: Container(
                width: con.sizeAnimation.value,
                height: con.sizeAnimation.value,
                decoration: BoxDecoration(
                  color: con.colorAnimation.value,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: con.toggleAnimation,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
