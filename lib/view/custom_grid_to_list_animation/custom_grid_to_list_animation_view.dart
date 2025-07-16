import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_demo_animation/view/custom_grid_to_list_animation/custom_grid_to_list_animation_controller.dart';
import 'package:get/get.dart';

import '../demo.dart';

class AnimatedListGridView extends StatelessWidget {
  AnimatedListGridView({super.key});

  final CustomGridToListAnimationController con = Get.put(CustomGridToListAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(onTap: () => Get.to(AnimatedListGridView2()), child : const Text('Grid/List Animation')),
        actions: [
          Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: IconButton(
                key: ValueKey(con.isGrid.value),
                icon: Icon(con.isGrid.value ? Icons.list : Icons.grid_view),
                onPressed: con.toggleView,
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: con.animationController,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: con.isGrid.value ? 2 : 1,
                    mainAxisSpacing: constraints.maxWidth * 0.03,
                    crossAxisSpacing: constraints.maxWidth * 0.03,
                    childAspectRatio: con.isGrid.value ? 0.8 : 3.5,
                  ),
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: con.animationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..scale(con.scaleAnimation.value)
                            ..translate(
                              0.0,
                              con.slideAnimation.value.dy * constraints.maxHeight,
                            ),
                          child: AnimatedListItem(
                            index: index,
                            animationValue: con.animation.value,
                            screenWidth: constraints.maxWidth,
                            isGrid: con.isGrid.value,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
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
    final minItemWidth = screenWidth * (isGrid ? 0.5 : 0.9);
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
              width: lerpDouble(screenWidth * 0.3, screenWidth * 0.46, animationValue)!,
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

          // Replace the text section in your Stack with this:
          Positioned(
            bottom: lerpDouble(screenWidth * 0.09, screenWidth * 0.03, animationValue)!,
            left: lerpDouble(screenWidth * 0.4, screenWidth * 0.03, animationValue)!,
            right: screenWidth * 0.03,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Transform.translate(
                  offset: Offset(0, 8 * (1 - animationValue)),
                  child: Text(
                    'Place Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * lerpDouble(0.04, 0.045, animationValue)!,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 4),

                // Subtitle
                Transform.translate(
                  offset: Offset(0, 8 * (1 - animationValue)),
                  child: Text(
                    'Country, City',
                    style: TextStyle(
                      color: Color.lerp(Colors.black54, Colors.black54, animationValue)!,
                      fontSize: screenWidth * lerpDouble(0.035, 0.04, animationValue)!,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
