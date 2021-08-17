import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trancehouse/components/button_custom_component.dart';
import 'package:trancehouse/components/button_custom_dark_component.dart';
import 'package:trancehouse/components/no_glow_component.dart';
import 'package:trancehouse/services/theme_service.dart';
import 'package:trancehouse/utils/extentions.dart';

class ChooseMode extends StatefulWidget {
  const ChooseMode({Key? key}) : super(key: key);

  @override
  _ChooseModeState createState() => _ChooseModeState();
}

class _ChooseModeState extends State<ChooseMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:ScrollConfiguration(
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
                    'mode'.tr,
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
                      isSelected: Get.isDarkMode,
                      onPress: () => ThemeService().changeThemeToDark(),
                      text: "mode.dark".tr,
                      fontFamily: 'language.rtl'.tr.parseBool ? 'Rabar' : '',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustomDarkComponent(
                      isSelected: !Get.isDarkMode,
                      onPress: () => ThemeService().changeThemeToLight(),
                      text: "mode.light".tr,
                      fontFamily: 'language.rtl'.tr.parseBool ? 'Rabar' : '',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustomComponent(
                      onPress: () {
                        Get.toNamed('/welcome');
                      },
                      child: Text(
                        'next'.tr.firstUpperCase,
                        style: TextStyle(
                          fontFamily: 'language.rtl'.tr.parseBool ? 'Rabar' : '',
                          fontSize: 20,
                          color: Color(0xFF1E272E),
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
}
