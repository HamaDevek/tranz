import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../components/no_glow_component.dart';
import '../../../services/theme_service.dart';
import 'package:get/get.dart';
import '../../../utils/extentions.dart';

class SettingAboutScreen extends StatelessWidget {
  const SettingAboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: NoGlowComponent(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Text(
                        '${Get.arguments["aboutus"]?["x-lang".tr] ?? ""}',
                        textAlign: 'language.rtl'.tr.parseBool
                            ? TextAlign.right
                            : TextAlign.left,
                        style: TextStyle(
                          fontFamily:
                              'language.rtl'.tr.parseBool ? "Rabar" : "",
                          fontSize: 20,
                          color: !ThemeService().isSavedDarkMode()
                              ? Color(0xFF1E272E)
                              : Colors.white,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.4),
                      spreadRadius: 6,
                      blurRadius: 7,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'about'.tr,
                                textAlign: 'language.rtl'.tr.parseBool
                                    ? TextAlign.right
                                    : TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'language.rtl'.tr.parseBool
                                      ? "Rabar"
                                      : "",
                                  fontSize: 24,
                                  color: !ThemeService().isSavedDarkMode()
                                      ? Color(0xFF1E272E)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                'language.rtl'.tr.parseBool
                                    ? Iconsax.arrow_left_2
                                    : Iconsax.arrow_right_3,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
