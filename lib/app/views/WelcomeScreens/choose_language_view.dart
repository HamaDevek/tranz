import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/language_controller.dart';
import '../../../components/button_custom_component.dart';
import '../../../components/button_custom_dark_component.dart';
import '../../../components/no_glow_component.dart';
import '../../../model/language_model.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  bool _isSelectAny = false;
  @override
  Widget build(BuildContext context) {
    // var x = MediaQuery.of(context).size.width;
    var y = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlowComponent(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: y > 600 ? 10 : 5,
                ),
                Container(
                  height: y > 600 ? 200 : 100,
                  width: y > 600 ? 200 : 100,
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
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(
                      horizontal: 16, vertical: y > 600 ? 8 : 4),
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
                          ? const Color(0xFF1E272E)
                          : Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustomComponent(
                      onPress: () {
                        if (!_isSelectAny) {
                          _changeLanguage(LanguageModel(
                            name: 'کوردی',
                            value: 'ku',
                            code: 'ar_SO',
                          ));
                        }

                        Get.toNamed('/choose-mode');
                      },
                      child: Text(
                        'next'.tr.firstUpperCase,
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xFF1E272E),
                          fontFamily:
                              'language.rtl'.tr.parseBool ? 'Rabar' : '',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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
