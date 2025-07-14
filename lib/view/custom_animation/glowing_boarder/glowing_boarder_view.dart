import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/routes/app_routes.dart';
import 'glowing_boarder_controller.dart';

class GlowingBoarderView extends StatelessWidget {
  GlowingBoarderView({super.key});

  final GlowingBoarderController con = Get.put(GlowingBoarderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Glowing Border"),actions: [
        GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.customLoaderView);
            },
            child: Text('Next').paddingOnly(right: 10))
      ]),
      body: Center(
        child: AnimatedBuilder(
          animation: con.animationController,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: con.colorAnimation.value!.withAlpha(150),
                    blurRadius: 25,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: AssetImage(
                  'assets/images/avatar_image.png',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
