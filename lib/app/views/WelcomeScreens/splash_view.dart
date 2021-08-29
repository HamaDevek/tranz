import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trancehouse/app/controllers/language_controller.dart';
import 'package:trancehouse/app/controllers/webinfo_api_controller.dart';
import 'package:trancehouse/helpers/responsive.dart';
import 'package:trancehouse/services/is_first_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final LanguageController _languageController = Get.find<LanguageController>();
  final WebinfoApiController _webinfoapiController =
      Get.put(WebinfoApiController(), tag: 'webinfo', permanent: true);
  @override
  void initState() {
    super.initState();
    _webinfoapiController.fetchWebinfo();
    Future.delayed(const Duration(seconds: 2), () {
      ResponsiveConfig().init(context);
      if (IsFirstService().getIsFirst()) {
        _languageController.changeLanguage(language: 'ar', dialect: 'SO');
      }
      _loadLanguage().then((value) => Get.offAllNamed(
          IsFirstService().getIsFirst() ? '/choose-language' : '/main'));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageController.changeLanguage(
        dialect: prefs.getString('dialect').toString(),
        language: prefs.getString('language').toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
