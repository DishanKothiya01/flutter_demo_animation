import 'package:get/get.dart';

class ImplicitAnimationController extends GetxController {
  RxBool toggled = false.obs;

  void toggleAll() {
    toggled.value = !toggled.value;
  }
}
