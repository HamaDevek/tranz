import 'package:get/get.dart';
import 'package:trancehouse/app/views/Blogs/single_blog_screen.dart';
import 'package:trancehouse/app/views/Cart/cart_screen.dart';
import 'package:trancehouse/app/views/Settings/setting_about_screen.dart';
import 'package:trancehouse/app/views/Settings/setting_archive_screen.dart';
import 'package:trancehouse/app/views/Settings/setting_contact_screen.dart';
import 'package:trancehouse/app/views/Settings/setting_feedback_screen.dart';
import 'package:trancehouse/app/views/Shop/single_item_screen.dart';
import 'package:trancehouse/app/views/WelcomeScreens/choose_language_view.dart';
import 'package:trancehouse/app/views/WelcomeScreens/choose_mode_view.dart';
import 'package:trancehouse/app/views/WelcomeScreens/welcome_screen_view.dart';
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
  ];
}
