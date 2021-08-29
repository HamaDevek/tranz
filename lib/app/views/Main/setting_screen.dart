import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trancehouse/app/controllers/webinfo_api_controller.dart';
import 'package:trancehouse/components/no_glow_component.dart';
import 'package:trancehouse/components/setting/setting_change_language_component.dart';
import 'package:trancehouse/components/setting/setting_change_mode_component.dart';
import 'package:trancehouse/components/setting/setting_component.dart';
import 'package:trancehouse/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:trancehouse/utils/extentions.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final WebinfoApiController _webinfoApiController =
      Get.find<WebinfoApiController>(tag: 'webinfo');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: NoGlowComponent(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Container(
                margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                width: double.infinity,
                child: Text(
                  'settings'.tr,
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                child: Text(
                  'account'.tr,
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Color(0xff818181),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingComponent(
                      onPress: () {
                        Get.toNamed('/archive');
                      },
                      icon: Icon(Iconsax.archive_1),
                      text: 'archive'.tr,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                child: Text(
                  'application'.tr,
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Color(0xff818181),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingComponent(
                      onPress: () {
                        showDialog(
                            context: context,
                            builder: (_) => SettingChangeLangaugeComponent());
                      },
                      icon: Icon(Iconsax.global),
                      text: 'lang'.tr,
                    ),
                    SettingComponent(
                      onPress: () {
                        showDialog(
                            context: context,
                            builder: (_) => SettingChangeColorComponent());
                      },
                      icon: Icon(Iconsax.brush),
                      text: 'color'.tr,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                child: Text(
                  'our'.tr,
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Color(0xff818181),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingComponent(
                      onPress: () {
                        Get.toNamed('/about',
                            arguments: _webinfoApiController.webInfo);
                      },
                      icon: Icon(Iconsax.warning_2),
                      text: 'about'.tr,
                    ),
                    SettingComponent(
                      onPress: () {
                        Get.toNamed('/contact',
                            arguments: _webinfoApiController.webInfo);
                      },
                      icon: Icon(Iconsax.call),
                      text: 'contact'.tr,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingComponent(
                      onPress: () {
                        Get.toNamed('/feedback');
                      },
                      icon: Icon(Iconsax.edit_2),
                      text: 'feedback.send'.tr,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
