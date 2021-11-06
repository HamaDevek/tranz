import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/button_custom_component.dart';
import '../../../components/button_custom_dark_component.dart';
import '../../../components/no_glow_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

class ChooseMode extends StatefulWidget {
  const ChooseMode({Key? key}) : super(key: key);

  @override
  _ChooseModeState createState() => _ChooseModeState();
}

class _ChooseModeState extends State<ChooseMode> {
  @override
  Widget build(BuildContext context) {
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
                  height: y > 600 ? 50 : 25,
                ),
                Container(
                  height: y > 600 ? 300 : 150,
                  width: y > 600 ? 300 : 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    // color: Theme.of(context).primaryColor,
                  ),
                  child: ThemeService().getThemeMode() == ThemeMode.light
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.modulate,
                          ),
                          child: Image.asset('assets/images/logo-home.png'),
                        )
                      : Image.asset('assets/images/logo-home.png'),
                ),
                SizedBox(
                  height: y > 600 ? 20 : 10,
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
                  height: y > 600 ? 10 : 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustomDarkComponent(
                      isSelected:
                          ThemeService().getThemeMode() == ThemeMode.dark,
                      onPress: () {
                        setState(() {
                          ThemeService().changeThemeToDark();
                        });
                      },
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
                      isSelected:
                          ThemeService().getThemeMode() == ThemeMode.light,
                      onPress: () {
                        setState(() {
                          ThemeService().changeThemeToLight();
                        });
                      },
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
                          fontFamily:
                              'language.rtl'.tr.parseBool ? 'Rabar' : '',
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
