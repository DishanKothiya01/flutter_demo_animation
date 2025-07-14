import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/routes/app_routes.dart';

class PageRouteTransitionView extends StatelessWidget {
  const PageRouteTransitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title: const Text("First Page"),actions: [
        GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.lottieAnimationView);
            },
            child: Text('Next').paddingOnly(right: 10))
      ]),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.pageRoutesTransitionView2);
          },
          child: const Text("Go to Second Page"),
        ),
      ),
    );
  }
}
