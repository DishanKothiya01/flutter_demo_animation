import 'package:get/get.dart';

class CustomGridToListAnimationController extends GetxController{
  RxBool isGridView = false.obs;

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  final List<Map<String, dynamic>> items = List.generate(
    10,
        (index) => {
      "image": "https://picsum.photos/id/${index + 10}/200/300",
      "title": "Title $index",
      "subtitle": "Subtitle $index",
      "liked": false.obs,
    },
  );
}

