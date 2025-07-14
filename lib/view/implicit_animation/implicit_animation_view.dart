import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/routes/app_routes.dart';
import 'implicit_animation_controller.dart';

class ImplicitAnimationView extends StatelessWidget {
  ImplicitAnimationView({super.key});

  final ImplicitAnimationController con = Get.put(ImplicitAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Implicit Animation"),actions: [
        GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.explicitAnimationView);
            },
            child: Text('Next').paddingOnly(right: 10))
      ],),
      body: Center(
        child: Obx(() {
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: con.toggled.value ? 200 : 100,
            height: con.toggled.value ? 200 : 100,
            decoration: BoxDecoration(
              color: con.toggled.value ? Colors.purple : Colors.amber,
              borderRadius: BorderRadius.circular(con.toggled.value ? 30 : 50),
              border: Border.all(color: con.toggled.value ? Colors.white : Colors.white,width: 2),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(80),offset: Offset(2, 2),spreadRadius: 2,blurRadius: 2)]
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(seconds: 1),
                style: TextStyle(
                  color: con.toggled.value ? Colors.white : Colors.greenAccent,
                  shadows: [
                    Shadow(
                      color: con.toggled.value ? Colors.black : Colors.black,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                  fontWeight: FontWeight.w800,
                  fontSize:con.toggled.value ?  18 : 14,
                ),
                child: Text(
                  "Tap Button",
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: con.toggleAll,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
