import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../components/no_glow_component.dart';
import '../../../components/setting/setting_component.dart';
import '../../../services/theme_service.dart';
import 'package:get/get.dart';
import '../../../utils/extentions.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingContactScreen extends StatelessWidget {
  const SettingContactScreen({Key? key}) : super(key: key);

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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SettingComponent(
                        onPress: () async {
                          String _url =
                              'https://www.google.com/maps/search/?api=1&query=${Get.arguments["location"]["lat"]},${Get.arguments["location"]["long"]}';
                          await canLaunch(_url)
                              ? await launch(_url)
                              : throw 'Could not launch :$_url';
                        },
                        icon: Icon(Iconsax.location),
                        text: Get.arguments['address'],
                      ),
                    ),
                    ...Get.arguments['email']
                        .toString()
                        .split('~')
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: SettingComponent(
                                onPress: () async {
                                  await canLaunch('mailto:$e')
                                      ? await launch('mailto:$e')
                                      : throw 'Could not launch mailto:$e';
                                },
                                icon: Icon(Iconsax.global),
                                text: e,
                              ),
                            )),
                    ...Get.arguments['phone'].toString().split('~').map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SettingComponent(
                              onPress: () async {
                                await canLaunch('tel:$e')
                                    ? await launch('tel:$e')
                                    : throw 'Could not launch tel:$e';
                              },
                              icon: Icon(Iconsax.call),
                              text: 'language.rtl'.tr.parseBool
                                  ? e.split('').reversed.join()
                                  : e,
                            ),
                          ),
                        ),
                    Get.arguments['links']['facebook'] == ''
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SettingComponent(
                              onPress: () async {
                                await canLaunch(
                                        '${Get.arguments['links']['facebook']}')
                                    ? await launch(
                                        '${Get.arguments['links']['facebook']}')
                                    : throw 'Could not launch ${Get.arguments['links']['facebook']}';
                              },
                              icon: Icon(Iconsax.call),
                              text: 'Facebook',
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
                                'contact'.tr,
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
