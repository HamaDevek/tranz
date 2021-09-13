import 'package:get/get.dart';
import 'package:trancehouse/app/views/Services/service_order_screen.dart';
import 'package:trancehouse/app/views/Services/service_subservice_screen.dart';
import 'package:trancehouse/app/views/Services/single_service_with_blog.dart';
import '../app/views/Blogs/single_blog_screen.dart';
import '../app/views/Cart/cart_finish_screen.dart';
import '../app/views/Cart/cart_screen.dart';
import '../app/views/Settings/setting_about_screen.dart';
import '../app/views/Settings/setting_archive_screen.dart';
import '../app/views/Settings/setting_contact_screen.dart';
import '../app/views/Settings/setting_feedback_screen.dart';
import '../app/views/Shop/single_item_screen.dart';
import '../app/views/WelcomeScreens/choose_language_view.dart';
import '../app/views/WelcomeScreens/choose_mode_view.dart';
import '../app/views/WelcomeScreens/welcome_screen_view.dart';
import '../app/views/Main/mian_screen.dart';

import '../app/views/PageNotFound/unknowen_route_page.dart';
import '../app/views/WelcomeScreens/splash_view.dart';

class RouteName {
  RouteName._();
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: '/',
      page: () => const SplashView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/notfound',
      page: () => const UnknownRoutePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: '/choose-language',
        page: () => const ChooseLanguage(),
        transition: Transition.fadeIn),
    GetPage(
      name: '/choose-mode',
      page: () => const ChooseMode(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/welcome',
      page: () => const WelcomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/main',
      page: () => const MainScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/single-blog',
      page: () => const SingleBlogScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/about',
      page: () => const SettingAboutScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/contact',
      page: () => const SettingContactScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/feedback',
      page: () => const SettingFeedbackScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/archive',
      page: () => const SettingArchiveScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/cart',
      page: () => const CartScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/single-item',
      page: () => const SingleItemScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/finish-cart',
      page: () => const CartFinishScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/subservice',
      page: () => const ServiceSubserviceScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/subservice/blogs',
      page: () => const SingleServiceWithBlog(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/service/order',
      page: () => const ServiceOrderScreen(),
      transition: Transition.downToUp,
    ),
  ];
}
