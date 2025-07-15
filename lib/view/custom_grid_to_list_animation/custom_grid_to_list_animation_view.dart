import 'package:flutter/material.dart';
import 'package:flutter_demo_animation/utils/routes/app_routes.dart';
import 'package:flutter_demo_animation/view/custom_grid_to_list_animation/custom_grid_to_list_animation_controller.dart';
import 'package:get/get.dart';

class CustomGridToListAnimationView extends StatelessWidget {
  CustomGridToListAnimationView({super.key});

  final CustomGridToListAnimationController con = Get.put(CustomGridToListAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.emojiSliderAnimationView),
          child: const Text("List to Grid Animation"),
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(con.isGridView.value ? Icons.list : Icons.grid_view),
              onPressed: con.toggleView,
            ),
          ),
        ],
      ),
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: con.isGridView.value ? buildGridView() : buildListView(),
        );
      }),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      key: const ValueKey("listView"),
      itemCount: con.items.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        final item = con.items[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Image.network(item["image"], width: 60, height: 60, fit: BoxFit.cover),
            title: Text(item["title"]),
            subtitle: Text(item["subtitle"]),
            trailing: Obx(
              () => IconButton(
                icon: Icon(
                  item["liked"].value ? Icons.favorite : Icons.favorite_border,
                  color: item["liked"].value ? Colors.red : Colors.grey,
                ),
                onPressed: () => item["liked"].value = !item["liked"].value,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      key: const ValueKey("gridView"),
      itemCount: con.items.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final item = con.items[index];
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        item["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(item["subtitle"], style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Obx(() => IconButton(
                    icon: Icon(
                      item["liked"].value ? Icons.favorite : Icons.favorite_border,
                      color: item["liked"].value ? Colors.red : Colors.white,
                    ),
                    onPressed: () => item["liked"].value = !item["liked"].value,
                  )),
            )
          ],
        );
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_demo_animation/view/custom_grid_to_list_animation/custom_grid_to_list_animation_controller.dart';
// import 'package:get/get.dart';
//
// class CustomGridToListAnimationView extends StatelessWidget {
//   CustomGridToListAnimationView({super.key});
//
//   final CustomGridToListAnimationController con = Get.put(CustomGridToListAnimationController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("List to Grid Animation"),
//         actions: [
//           Obx(
//             () => IconButton(
//               icon: Icon(con.isGridView.value ? Icons.list : Icons.grid_view),
//               onPressed: con.toggleView,
//             ),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         return AnimatedCrossFade(
//           duration: const Duration(milliseconds: 600),
//           crossFadeState: con.isGridView.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
//           firstChild: buildGridView(),
//           secondChild: buildListView(),
//           layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
//             return Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Positioned.fill(
//                   key: bottomChildKey,
//                   child: bottomChild,
//                 ),
//                 Positioned.fill(
//                   key: topChildKey,
//                   child: topChild,
//                 ),
//               ],
//             );
//           },
//         );
//       }),
//     );
//   }
//
//   Widget buildListView() {
//     return ListView.builder(
//       key: const ValueKey("listView"),
//       itemCount: con.items.length,
//       padding: const EdgeInsets.all(12),
//       itemBuilder: (context, index) {
//         final item = con.items[index];
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           child: Card(
//             child: ListTile(
//               leading: Container(
//                 width: 80,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(item["image"]),
//                     fit: BoxFit.fill,
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               title: Text(item["title"]),
//               subtitle: Text(item["subtitle"]),
//               trailing: Obx(
//                 () => IconButton(
//                   icon: Icon(
//                     item["liked"].value ? Icons.favorite : Icons.favorite_border,
//                     color: item["liked"].value ? Colors.red : Colors.grey,
//                   ),
//                   onPressed: () => item["liked"].value = !item["liked"].value,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget buildGridView() {
//     return GridView.builder(
//       key: const ValueKey("gridView"),
//       itemCount: con.items.length,
//       padding: const EdgeInsets.all(12),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         childAspectRatio: 0.8,
//       ),
//       itemBuilder: (context, index) {
//         final item = con.items[index];
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           child: Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(color: Colors.black12, blurRadius: 6),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                         child: Image.network(
//                           item["image"],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(item["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 4),
//                           Text(item["subtitle"], style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: Obx(() => IconButton(
//                       icon: Icon(
//                         item["liked"].value ? Icons.favorite : Icons.favorite_border,
//                         color: item["liked"].value ? Colors.red : Colors.white,
//                       ),
//                       onPressed: () => item["liked"].value = !item["liked"].value,
//                     )),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
