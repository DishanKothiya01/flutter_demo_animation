import 'package:flutter/material.dart';
import 'package:flutter_demo_animation/utils/routes/app_page.dart';
import 'package:flutter_demo_animation/utils/routes/app_routes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.heroAnimationView,
    );
  }
}
