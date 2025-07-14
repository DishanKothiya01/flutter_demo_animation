import 'package:get/get.dart';

class HeroAnimationController extends GetxController {
  final List<ItemModel> items = List.generate(
    10,
    (index) => ItemModel(
      title: 'Item $index',
      subtitle: 'This is the subtitle for item $index',
      imageUrl: 'https://picsum.photos/200?random=$index',
    ),
  );
}

// Sample data model
class ItemModel {
  final String? title;
  final String? subtitle;
  final String? imageUrl;

  ItemModel({this.title, this.subtitle, this.imageUrl});
}
