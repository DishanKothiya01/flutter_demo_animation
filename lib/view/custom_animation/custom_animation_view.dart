import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/routes/app_routes.dart';
import 'custom_animation_controller.dart';

class CustomAnimationView extends StatelessWidget {
  CustomAnimationView({super.key});

  final CustomAnimationController con = Get.put(CustomAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Animation'),actions: [
        GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.glowingBoarderView);
            },
            child: Text('Next').paddingOnly(right: 10))
      ]),
      body: Center(
        child: AnimatedBuilder(
          animation: con.animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: con.scaleAnimation.value,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.blueGrey,
              ),
            );
          },
          // child: FlutterLogo(size: 120),
        ),
      ),
    );
  }
}
