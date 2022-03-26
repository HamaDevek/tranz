import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../../app/controllers/webinfo_api_controller.dart';
import '../../../components/no_glow_component.dart';
import '../../../components/setting/setting_change_language_component.dart';
import '../../../components/setting/setting_change_mode_component.dart';
import '../../../components/setting/setting_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

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
              const SizedBox(
                height: 32,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                        ? const Color(0xFF1E272E)
                        : Colors.white,
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.all(16),
              //   width: double.infinity,
              //   child: Text(
              //     'account'.tr,
              //     textAlign: 'language.rtl'.tr.parseBool
              //         ? TextAlign.right
              //         : TextAlign.left,
              //     style: TextStyle(
              //       fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //       color: !ThemeService().isSavedDarkMode()
              //           ? Color(0xFF1E272E)
              //           : Color(0xff818181),
              //     ),
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 16),
              //   height: 80,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: Theme.of(context).accentColor,
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       SettingComponent(
              //         onPress: () {
              //           Get.toNamed('/archive');
              //         },
              //         icon: Icon(Iconsax.archive_1),
              //         text: 'archive'.tr,
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.all(16),
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
                        ? const Color(0xFF1E272E)
                        : const Color(0xff818181),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingComponent(
                      onPress: () {
                        showDialog(
                            context: context,
                            builder: (_) => const SettingChangeLangaugeComponent());
                      },
                      icon: const Icon(Iconsax.global),
                      text: 'lang'.tr,
                    ),
                    SettingComponent(
                      onPress: () {
                        showDialog(
                            context: context,
                            builder: (_) => const SettingChangeColorComponent());
                      },
                      icon: const Icon(Iconsax.brush),
                      text: 'color'.tr,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
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
                        ? const Color(0xFF1E272E)
                        : const Color(0xff818181),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingComponent(
                      onPress: () {
                        Get.toNamed('/about',
                            arguments: _webinfoApiController.webInfo);
                      },
                      icon: const Icon(Iconsax.warning_2),
                      text: 'about'.tr,
                    ),
                    SettingComponent(
                      onPress: () {
                        Get.toNamed('/contact',
                            arguments: _webinfoApiController.webInfo);
                      },
                      icon: const Icon(Iconsax.call),
                      text: 'contact'.tr,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingComponent(
                      onPress: () {
                        Get.toNamed('/feedback');
                      },
                      icon: const Icon(Iconsax.edit_2),
                      text: 'feedback.send'.tr,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
