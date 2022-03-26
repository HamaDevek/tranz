import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../components/no_glow_component.dart';
import '../../../components/setting/setting_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

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
                              ? await launch(_url, forceSafariVC: false)
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
                              text: e,
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
                                        'https://www.facebook.com/${Get.arguments['links']['facebook']}',
                                        forceSafariVC: false)
                                    : throw 'Could not launch ${Get.arguments['links']['facebook']}';
                              },
                              icon: Icon(FontAwesomeIcons.facebook),
                              text: 'Facebook',
                            ),
                          ),
                    Get.arguments['links']['linkedin'] == ''
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SettingComponent(
                              onPress: () async {
                                await canLaunch(
                                  '${Get.arguments['links']['linkedin']}',
                                )
                                    ? await launch(
                                        'https://www.snapchat.com/add/${Get.arguments['links']['linkedin']}',
                                        forceSafariVC: false)
                                    : throw 'Could not launch ${Get.arguments['links']['linkedin']}';
                              },
                              icon: Icon(FontAwesomeIcons.snapchatGhost),
                              text: 'Snapchat',
                            ),
                          ),
                    Get.arguments['links']['instagram'] == ''
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SettingComponent(
                              onPress: () async {
                                await canLaunch(
                                        '${Get.arguments['links']['instagram']}')
                                    ? await launch(
                                        'https://www.instagram.com/${Get.arguments['links']['instagram']}',
                                        forceSafariVC: false)
                                    : throw 'Could not launch ${Get.arguments['links']['instagram']}';
                              },
                              icon: Icon(FontAwesomeIcons.instagram),
                              text: 'Instagram',
                            ),
                          ),
                    Get.arguments['links']['twitter'] == ''
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SettingComponent(
                              onPress: () async {
                                await canLaunch(
                                        '${Get.arguments['links']['twitter']}')
                                    ? await launch(
                                        'https://twitter.com/${Get.arguments['links']['twitter']}',
                                        forceSafariVC: false)
                                    : throw 'Could not launch ${Get.arguments['links']['twitter']}';
                              },
                              icon: Icon(FontAwesomeIcons.twitter),
                              text: 'Twitter',
                            ),
                          ),
                    Get.arguments['links']['youtube'] == ''
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SettingComponent(
                              onPress: () async {
                                await canLaunch(
                                        '${Get.arguments['links']['youtube']}')
                                    ? await launch(
                                        'https://www.youtube.com/${Get.arguments['links']['youtube']}',
                                        forceSafariVC: false)
                                    : throw 'Could not launch ${Get.arguments['links']['youtube']}';
                              },
                              icon: Icon(FontAwesomeIcons.youtube),
                              text: 'Youtube',
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
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              'language.rtl'.tr.parseBool
                                  ? Iconsax.arrow_right_3
                                  : Iconsax.arrow_left_2,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                'contact'.tr,
                                textAlign: 'language.rtl'.tr.parseBool
                                    ? TextAlign.left
                                    : TextAlign.right,
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
