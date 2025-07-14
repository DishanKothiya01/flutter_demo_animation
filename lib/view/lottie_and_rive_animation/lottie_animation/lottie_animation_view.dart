import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/routes/app_routes.dart';


class LottieAnimationView extends StatelessWidget {
  const LottieAnimationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lottie Animation"),actions: [
        GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.customAnimationView);
            },
            child: Text('Next').paddingOnly(right: 10))
      ]),
      body: Center(
        child: Lottie.asset(
          'assets/animation/lottie_animation.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
          repeat: true,
        ),
      ),
    );
  }
}
