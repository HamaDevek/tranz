import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/theme_service.dart';
import '../../../app/controllers/city_api_controller.dart';
import '../../../app/controllers/language_controller.dart';
import '../../../app/controllers/webinfo_api_controller.dart';
import '../../../helpers/responsive.dart';
import '../../../services/is_first_service.dart';
import '../../../utils/extentions.dart';

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
    Get.put(CityApiController(), tag: 'city', permanent: true).getCity();
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
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                // color: Theme.of(context).primaryColor,
              ),
              child: ThemeService().getThemeMode() == ThemeMode.light
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.modulate,
                      ),
                      child: Image.asset('assets/images/logo-home.png'),
                    )
                  : Image.asset('assets/images/logo-home.png'),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'welcome.to'.tr,
              textAlign: 'language.rtl'.tr.parseBool
                  ? TextAlign.right
                  : TextAlign.left,
              style: TextStyle(
                fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                fontSize: 24,
                color: !ThemeService().isSavedDarkMode()
                    ? const Color(0xFF1E272E)
                    : Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }
}
