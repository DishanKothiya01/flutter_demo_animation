import 'package:get/get.dart';

import '../hero_animation_view/hero_animation_controller.dart';

class HeroDetailsController extends GetxController {
  ItemModel itemModel = ItemModel();
  int index = 0;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments['item'].runtimeType == ItemModel) {
        itemModel = Get.arguments['item'];
      }
      if (Get.arguments['index'].runtimeType == int) {
        index = Get.arguments['index'];
      }
    }
  }
}
