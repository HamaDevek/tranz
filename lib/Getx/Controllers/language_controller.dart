import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utility/prints.dart';

class LanguageController extends GetxController {
  static LanguageController get to =>
      Get.find<LanguageController>(tag: 'language');
  String _selectedLanguage = '';
  @override
  void onInit() {
    super.onInit();
    load();
  }

  load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    _selectedLanguage =
        "${prefs.getString('language') ?? 'en'}_${prefs.getString('dialect') ?? 'US'}";

    prints('${prefs.getString('language')}', tag: "error");
    prints('${prefs.getString('dialect')}', tag: "success");
    changeLanguage(
      language: prefs.getString('language') ?? 'en',
      dialect: prefs.getString('dialect') ?? 'US',
    );
  }

  void changeLanguage({required String language, required String dialect}) {
    final Locale locale = Locale(language, dialect);
    Get.updateLocale(locale);
    _selectedLanguage = "${language}_$dialect";
    _saveLanguage(language: language, dialect: dialect);
    update();
  }

  Future<void> _saveLanguage(
      {required String language, required String dialect}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
    prefs.setString('dialect', dialect);
  }

  final languages = [
    {'en_US': 'English'},
    {'ar_SO': 'Kurdish'},
    {'ar_IQ': 'Arabic'}
  ];

  String getSelectedLanguage() {
    return _selectedLanguage;
  }
}
