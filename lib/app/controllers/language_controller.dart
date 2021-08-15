import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  void changeLanguage({required String language, required String dialect}) {
    final Locale locale = Locale(language, dialect);
    Get.updateLocale(locale);
    _saveLanguage(language: language, dialect: dialect);
    update();
  }

  Future<void> _saveLanguage(
      {required String language, required String dialect}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
    prefs.setString('dialect', dialect);
  }

 
}
