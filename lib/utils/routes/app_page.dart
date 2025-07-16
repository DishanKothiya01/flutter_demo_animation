import 'package:flutter_demo_animation/view/custom_animation/custom_animation_view.dart';
import 'package:flutter_demo_animation/view/custom_animation/glowing_boarder/glowing_boarder_view.dart';
import 'package:flutter_demo_animation/view/custom_grid_to_list_animation/custom_grid_to_list_animation_view.dart';
import 'package:flutter_demo_animation/view/emoji_slider_animation/emoji_slider_view.dart';
import 'package:flutter_demo_animation/view/explicit_animation/explicit_animation_view.dart';
import 'package:flutter_demo_animation/view/hero_animation/hero_animation_view/hero_animation_view.dart';
import 'package:flutter_demo_animation/view/lottie_and_rive_animation/lottie_animation/lottie_animation_view.dart';
import 'package:flutter_demo_animation/view/lottie_and_rive_animation/rive_animation/rive_animation_view.dart';
import 'package:flutter_demo_animation/view/physics_based_animation/physics_animation_view.dart';
import 'package:get/get.dart';

import '../../view/custom_animation/custom_loader/custom_loader_view.dart';
import '../../view/hero_animation/hero_details_view/hero_details_view.dart';
import '../../view/implicit_animation/implicit_animation_view.dart';
import '../../view/page_route_transition/page_route_transition_view.dart';
import '../../view/page_route_transition/page_route_transition_view2.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    /// Hero Animation
    GetPage(name: AppRoutes.heroAnimationView, page: () => HeroAnimationView()),
    GetPage(name: AppRoutes.heroDetailView, page: () => HeroDetailScreen()),

    /// Implicit Animation
    GetPage(name: AppRoutes.implicitAnimationView, page: () => ImplicitAnimationView()),

    /// Explicit Animation
    GetPage(name: AppRoutes.explicitAnimationView, page: () => ExplicitAnimationView()),

    /// Page Routes Transition
    GetPage(name: AppRoutes.pageRoutesTransitionView, page: () => PageRouteTransitionView()),
    GetPage(
      name: AppRoutes.pageRoutesTransitionView2, page: () => PageRouteTransitionView2(),
      transition: Transition.cupertino, // rightToLeft, downToUp, zoom, etc.
      transitionDuration: const Duration(milliseconds: 600),
    ),

    /// Physics Animation
    GetPage(name: AppRoutes.physicsAnimationView, page: () => PhysicsAnimationView()),

    /// Lottie Animation
    GetPage(name: AppRoutes.lottieAnimationView, page: () => LottieAnimationView()),
    GetPage(name: AppRoutes.riveAnimationView, page: () => RiveAnimationView()),

    /// Custom Animation
    GetPage(name: AppRoutes.customAnimationView, page: () => CustomAnimationView()),
    GetPage(name: AppRoutes.glowingBoarderView, page: () => GlowingBoarderView()),
    GetPage(name: AppRoutes.customLoaderView, page: () => CustomLoaderView()),

    /// Custom Grid to List Animation
    // GetPage(name: AppRoutes.customGridToListAnimationView, page: () =>  CustomGridToListAnimationView()),

    /// Emoji Slider Animation
    GetPage(name: AppRoutes.emojiSliderAnimationView, page: () =>  EmojiSliderView()),
  ];
}
