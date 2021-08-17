import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trancehouse/app/controllers/language_controller.dart';
import 'package:trancehouse/components/button_custom_component.dart';
import 'package:trancehouse/components/button_custom_dark_component.dart';
import 'package:trancehouse/components/no_glow_component.dart';
import 'package:trancehouse/model/language_model.dart';
import 'package:trancehouse/services/theme_service.dart';
import 'package:trancehouse/utils/extentions.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  bool _isSelectAny = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
                        behavior: NoGlowComponent(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                ),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  width: double.infinity,
                  child: Text(
                    'language.choose'.tr,
                    textAlign: 'language.rtl'.tr.parseBool
                        ? TextAlign.right
                        : TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                      fontSize: 24,
                      color: !ThemeService().isSavedDarkMode()
                          ? Color(0xFF1E272E)
                          : Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustomDarkComponent(
                      onPress: () => _changeLanguage(
                        LanguageModel(
                          name: 'کوردی',
                          value: 'ku',
                          code: 'ar_SO',
                        ),
                      ),
                      isSelected: 'x-lang'.tr == 'ku',
                      text: "کوردی",
                      fontFamily: "Rabar",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustomDarkComponent(
                      onPress: () => _changeLanguage(
                        LanguageModel(
                          name: 'العربي',
                          value: 'ar',
                          code: 'ar_IQ',
                        ),
                      ),
                      isSelected: 'x-lang'.tr == 'ar',
                      fontFamily: "Rabar",
                      text: "عربي",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustomDarkComponent(
                      isSelected: 'x-lang'.tr == 'en',
                      onPress: () => _changeLanguage(
                        LanguageModel(
                          name: 'English',
                          value: 'en',
                          code: 'en_US',
                        ),
                      ),
                      text: "English",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustomComponent(
                      onPress: () {
                        if (!_isSelectAny)
                          _changeLanguage(LanguageModel(
                            name: 'کوردی',
                            value: 'ku',
                            code: 'ar_SO',
                          ));
        
                        Get.toNamed('/choose-mode');
                      },
                      child: Text(
                        'next'.tr.firstUpperCase,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF1E272E),
                          fontFamily: 'language.rtl'.tr.parseBool ? 'Rabar' : '',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _changeLanguage(languageModel) async {
    _isSelectAny = true;
    final List<String> _temp = languageModel!.code.split('_');
    Get.put(LanguageController())
        .changeLanguage(language: _temp[0], dialect: _temp[1]);
  }
}
