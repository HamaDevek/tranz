import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Admin/Main/admin_main_page.dart';
import 'package:tranzhouse/Pages/Client/Main%20Page/main_page.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

import '../../Getx/Controllers/language_controller.dart';
import '../../Getx/Controllers/user_controller.dart';
import '../../Models/user_model.dart';
import '../../Utility/prints.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToNextPage();
    });
  }

  void _navigateToNextPage() async {
    Future.delayed(const Duration(seconds: 2), () async {
      LanguageController.to.load();

      if (UserController.to.user?.value.token == null) {
        UserController.to.user?.value = UserModel();
        await UserController.to.authStorage.remove('auth');
        prints('access token splash: ${UserController.to.user?.value.token}',
            tag: 'error');
        Get.offAllNamed(ClientMainPage.routeName);
      } else {
        if (UserController.to.user?.value.user?.employee != null &&
            UserController.to.user?.value.user?.employee ==true) {
          Get.offAllNamed(AdminMainPage.routeName);
          prints('access token splash: ${UserController.to.user?.value.token}',
              tag: 'success');
        } else {
          Get.offAllNamed(ClientMainPage.routeName);
          prints('access token splash: ${UserController.to.user?.value.token}',
              tag: 'success');
        }
      }

      // Get.toNamed(ClientMainPage.routeName);

      // Get.offNamed(AdminMainPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            "assets/images/logo.png",
          ),
          Transform.translate(
            offset: const Offset(0, 0 - 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  "Welcome to",
                  style: TextWidget.textStyleCurrent.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacer.p4(),
                TextWidget(
                  "Tranzhouse",
                  style: TextWidget.textStyleCurrent.copyWith(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
