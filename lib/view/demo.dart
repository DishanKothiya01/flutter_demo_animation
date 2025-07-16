import 'package:flutter/material.dart';
import 'package:flutter_demo_animation/utils/routes/app_routes.dart';
import 'package:get/get.dart';
import 'dart:ui';

class AnimatedListGridView2 extends StatelessWidget {
  AnimatedListGridView2({super.key});

  final AnimatedListGridController con = Get.put(AnimatedListGridController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.emojiSliderAnimationView),
          child: const Text('List/Grid View'),
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(con.isGrid.value ? Icons.list : Icons.grid_view),
              onPressed: con.toggleView,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: AnimatedBuilder(
              animation: con.animation,
              builder: (context, child) {
                return Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                  child: Wrap(
                    spacing: constraints.maxWidth * 0.03,
                    runSpacing: constraints.maxWidth * 0.03,
                    children: List.generate(10, (index) {
                      return AnimatedListItem(
                        index: index,
                        animationValue: con.animation.value,
                        screenWidth: constraints.maxWidth,
                        isGrid: con.isGrid.value,
                      );
                    }),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AnimatedListItem extends StatelessWidget {
  final int index;
  final double animationValue;
  final double screenWidth;
  final bool isGrid;

  const AnimatedListItem({
    super.key,
    required this.index,
    required this.animationValue,
    required this.screenWidth,
    required this.isGrid,
  });

  @override
  Widget build(BuildContext context) {
    final minItemWidth = screenWidth * 0.9;
    final maxItemWidth = (screenWidth * 0.5) - (screenWidth * 0.03 * 2);
    final minItemHeight = screenWidth * 0.25;
    final maxItemHeight = screenWidth * 0.6;

    final targetWidth = lerpDouble(minItemWidth, maxItemWidth, animationValue)!;
    final targetHeight = lerpDouble(minItemHeight, maxItemHeight, animationValue)!;

    return TweenAnimationBuilder<Size>(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuad,
      tween: Tween<Size>(
        begin: Size(minItemWidth, minItemHeight),
        end: Size(targetWidth, targetHeight),
      ),
      builder: (context, size, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1 * animationValue),
                blurRadius: 8 * animationValue,
                spreadRadius: 1 * animationValue,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Stack(
        children: [
          // Image with smoother animation
          AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            alignment: Alignment.topLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              height: lerpDouble(screenWidth * 0.25, screenWidth * 0.35, animationValue),
              width: lerpDouble(screenWidth * 0.3, screenWidth * 0.45, animationValue)!,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.04),
                  topRight: Radius.circular(screenWidth * 0.04 * animationValue),
                ),
                child: Image.network(
                  'https://picsum.photos/200/300?random=$index',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Heart icon with smoother movement
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            right: lerpDouble(screenWidth * 0.02, screenWidth * 0.32, animationValue)!,
            top: lerpDouble(screenWidth * 0.08, screenWidth * 0.03, animationValue)!,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              scale: lerpDouble(0.9, 1.1, animationValue)!,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: screenWidth * 0.04,
                child: Icon(Icons.favorite, color: Colors.white, size: screenWidth * 0.045),
              ),
            ),
          ),

          // Text with smoother transitions
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            bottom: lerpDouble(screenWidth * 0.08, screenWidth * 0.03, animationValue)!,
            left: lerpDouble(screenWidth * 0.4, screenWidth * 0.03, animationValue)!,
            right: screenWidth * 0.03,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedPadding(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                  padding: EdgeInsets.only(bottom: screenWidth * 0.01 * animationValue),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutQuad,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04 * (1 + (0.2 * animationValue)),
                      color: Colors.black,
                    ),
                    child: const Text('Place Name'),
                  ),
                ),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                  style: TextStyle(
                    color: Color.lerp(Colors.black26, Colors.black54, animationValue)!,
                    fontSize: screenWidth * 0.03 * (1 + (0.2 * animationValue)),
                  ),
                  child: const Text('Country, City'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedListGridController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final isGrid = false.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutQuad,
        reverseCurve: Curves.easeOutQuad,
      ),
    );
  }

  void toggleView() {
    isGrid.toggle();
    isGrid.value ? animationController.forward() : animationController.reverse();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
/////

// class AnimatedListGridView extends StatelessWidget {
//   AnimatedListGridView({super.key});
//
//   final AnimatedListGridController con = Get.put(AnimatedListGridController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: GestureDetector(
//           onTap: () => Get.toNamed(AppRoutes.customGridToListAnimationView),
//           child: const Text('Animated List/Grid View'),
//         ),
//         actions: [
//           Obx(
//                 () => IconButton(
//               icon: Icon(con.isGrid.value ? Icons.list : Icons.grid_view),
//               onPressed: con.toggleView,
//             ),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return AnimatedBuilder(
//             animation: con.animation,
//             builder: (context, child) {
//               return Padding(
//                 padding: EdgeInsets.all(constraints.maxWidth * 0.03),
//                 child: GridView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: 10,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: con.isGrid.value ? 2 : 1,
//                     mainAxisSpacing: constraints.maxWidth * 0.03,
//                     crossAxisSpacing: constraints.maxWidth * 0.03,
//                     childAspectRatio: con.isGrid.value
//                         ? 0.8 // Aspect ratio for grid
//                         : 3.5, // Aspect ratio for list
//                   ),
//                   itemBuilder: (context, index) {
//                     return AnimatedListItem(
//                       index: index,
//                       animationValue: con.animation.value,
//                       screenWidth: constraints.maxWidth,
//                       isGrid: con.isGrid.value,
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
