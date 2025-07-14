import 'package:flutter/material.dart';
import 'package:flutter_demo_animation/utils/routes/app_routes.dart';
import 'package:flutter_demo_animation/view/hero_animation/hero_animation_view/hero_animation_controller.dart';
import 'package:get/get.dart';

class HeroAnimationView extends StatelessWidget {
  HeroAnimationView({super.key});

  final HeroAnimationController con = Get.put(HeroAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hero"), actions: [
        GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.implicitAnimationView);
            },
            child: Text('Next').paddingOnly(right: 10))
      ]),
      body: ListView.builder(
        itemCount: con.items.length,
        itemBuilder: (_, index) {
          final item = con.items[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.heroDetailView, arguments: {'item': item, 'index': index});
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Hero(
                    tag: 'hero$index',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.imageUrl ?? '',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ListTile(
                      title: Text(item.title ?? ''),
                      subtitle: Text(item.subtitle ?? ''),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
