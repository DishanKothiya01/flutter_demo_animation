import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'hero_details_controller.dart';

class HeroDetailScreen extends StatelessWidget {
  HeroDetailScreen({super.key});

  final HeroDetailsController con = Get.put(HeroDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(con.itemModel.title ?? ''),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'hero${con.index}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                con.itemModel.imageUrl ?? '',
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              con.itemModel.title ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              con.itemModel.subtitle ?? '',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
