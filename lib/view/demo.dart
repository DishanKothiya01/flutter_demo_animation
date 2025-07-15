import 'package:flutter/material.dart';
import 'package:flutter_demo_animation/utils/routes/app_routes.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'custom_grid_to_list_animation/custom_grid_to_list_animation_controller.dart';

class CustomGridToListAnimation extends StatelessWidget {
  CustomGridToListAnimation({super.key});

  final CustomGridToListAnimationController con = Get.put(CustomGridToListAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Get.to(AnimatedListGridView()),
          child: const Text("Animated Cards"),
        ),
        actions: [
          Obx(() => IconButton(
                icon: Icon(con.isGridView.value ? Icons.list : Icons.grid_view),
                onPressed: con.toggleView,
              )),
        ],
      ),
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: con.isGridView.value ? GridViewAnimationWrapper(key: const ValueKey('grid'), controller: con) : ListViewAnimationWrapper(key: const ValueKey('list'), controller: con),
        );
      }),
    );
  }
}

class ListViewAnimationWrapper extends StatelessWidget {
  final CustomGridToListAnimationController controller;

  const ListViewAnimationWrapper({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        final item = controller.items[index];
        return Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.bounceInOut,
              switchOutCurve: Curves.bounceInOut,
              child: Card(
                key: key,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  onTap: controller.toggleView,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Hero(
                          tag: "image-$index",
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(item["image"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: "title-$index",
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    item["title"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Hero(
                                tag: "subtitle-$index",
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    item["subtitle"],
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            item["liked"].value ? Icons.favorite : Icons.favorite_border,
                            color: item["liked"].value ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => item["liked"].value = !item["liked"].value,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class GridViewAnimationWrapper extends StatelessWidget {
  final CustomGridToListAnimationController controller;

  const GridViewAnimationWrapper({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        final item = controller.items[index];
        return Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.bounceInOut,
            switchOutCurve: Curves.bounceInOut,
            child: Card(
              key: key,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: controller.toggleView,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: "image-$index",
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.network(
                                item["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: "title-$index",
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    item["title"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Hero(
                                tag: "subtitle-$index",
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    item["subtitle"],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => item["liked"].value = !item["liked"].value,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(50),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item["liked"].value ? Icons.favorite : Icons.favorite_border,
                            color: item["liked"].value ? Colors.red : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/////////
// class ViewToggleController extends GetxController {
//   RxBool isGrid = false.obs;
//   final List<Map<String, dynamic>> places = List.generate(
//     10,
//     (index) => {
//       "image": "https://picsum.photos/id/${index + 10}/200/300",
//       "title": "Title $index",
//       "subtitle": "Subtitle $index",
//       "liked": false.obs,
//     },
//   );
// }
//
// class AnimatedListGridSwitcher extends StatelessWidget {
//   AnimatedListGridSwitcher({super.key});
//
//   final ViewToggleController con = Get.put(ViewToggleController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: GestureDetector(onTap: () => Get.to(CustomGridToListAnimation()),child :const Text("Places")),
//         actions: [
//           Obx(() => IconButton(
//                 icon: Icon(con.isGrid.value ? Icons.list : Icons.grid_view),
//                 onPressed: () {
//                   con.isGrid.toggle();
//                 },
//               ))
//         ],
//       ),
//       body: Obx(() {
//         return AnimatedSwitcher(
//           duration: const Duration(milliseconds: 800),
//           transitionBuilder: (child, animation) {
//             return FadeTransition(
//               opacity: animation,
//               child: ScaleTransition(
//                 scale: animation,
//                 child: child,
//               ),
//             );
//           },
//           child: con.isGrid.value
//               ? GridView.builder(
//                   key: const ValueKey(true),
//                   padding: const EdgeInsets.all(12),
//                   itemCount: con.places.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 0.75,
//                   ),
//                   itemBuilder: (_, index) => AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 800),
//                     transitionBuilder: (child, animation) {
//                       return FadeTransition(
//                         opacity: animation,
//                         child: ScaleTransition(
//                           scale: animation,
//                           child: child,
//                         ),
//                       );
//                     },
//                     child: PlaceCard(
//                       data: con.places[index],
//                       isGrid: true,
//                     ),
//                   ),
//                 )
//               : ListView.builder(
//                   key: const ValueKey(false),
//                   padding: const EdgeInsets.all(12),
//                   itemCount: con.places.length,
//                   itemBuilder: (_, index) => Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 800),
//                       transitionBuilder: (child, animation) {
//                         return FadeTransition(
//                           opacity: animation,
//                           child: ScaleTransition(
//                             scale: animation,
//                             child: child,
//                           ),
//                         );
//                       },
//                       child: PlaceCard(
//                         data: con.places[index],
//                         isGrid: false,
//                       ),
//                     ),
//                   ),
//                 ),
//         );
//       }),
//     );
//   }
// }
//
//
// class PlaceCard extends StatelessWidget {
//   final Map<String, dynamic> data;
//   final bool isGrid;
//
//   const PlaceCard({required this.data, required this.isGrid, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1),
//         ],
//       ),
//       child: isGrid
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                     child: Image.network(
//                       data['image']!,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(data['title']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                             Text(data['subtitle']!, style: const TextStyle(color: Colors.grey)),
//                           ],
//                         ),
//                       ),
//                       const Icon(Icons.favorite, color: Colors.red),
//                     ],
//                   ),
//                 )
//               ],
//             )
//           : Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
//                   child: Image.network(
//                     data['image']!,
//                     width: 120,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(data['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 4),
//                         Text(data['subtitle']!, style: const TextStyle(color: Colors.grey)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(right: 12),
//                   child: Icon(Icons.favorite, color: Colors.red),
//                 )
//               ],
//             ),
//     );
//   }
// }

//////////

class AnimatedListGridView extends StatefulWidget {
  const AnimatedListGridView({super.key});

  @override
  _AnimatedListGridViewState createState() => _AnimatedListGridViewState();
}

class _AnimatedListGridViewState extends State<AnimatedListGridView> with SingleTickerProviderStateMixin {
  bool isGrid = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void toggleView() {
    setState(() => isGrid = !isGrid);
    isGrid ? _controller.forward() : _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.customGridToListAnimationView),
          child: const Text('Animated List/Grid View'),
        ),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: toggleView,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(10, (index) {
                  final itemWidth = lerpDouble(size.width, (size.width - 36) / 2, _animation.value)!;
                  final itemHeight = lerpDouble(100, 250, _animation.value)!;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: itemWidth,
                    height: itemHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 5),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20 * _animation.value),
                            ),
                            child: Image.network(
                              'https://picsum.photos/200/300?random=$index',
                              height: lerpDouble(100, 150, _animation.value),
                              width:  lerpDouble(150, 200, _animation.value)!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top:  lerpDouble(40, 10, _animation.value)!,
                          child: Icon(Icons.favorite, color: Colors.red),
                        ),
                        Positioned(
                          bottom:  lerpDouble(25, 12, _animation.value)!,
                          left:  lerpDouble(170, 12, _animation.value)!,
                          right: 12,
                          child: Opacity(
                            opacity: 1.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Place Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                SizedBox(height: 4),
                                Text('Country, City', style: TextStyle(color: Colors.black26)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
