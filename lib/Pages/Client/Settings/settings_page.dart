import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Getx/Controllers/client_controller.dart';
import 'package:tranzhouse/Getx/Controllers/user_controller.dart';
import 'package:tranzhouse/Pages/Auth/login_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/About/about_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Contact/contact_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Language/language_page.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

import '../../../Utility/utility.dart';
import '../../../Widgets/Containers/profile_card_Widget.dart';
import 'Feedback/feedback_page.dart';
import 'Profile/edit_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    ClientController.to.metaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final isUserLoggedin = UserController.to.isUserLoggedin();
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            primary: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacer.appBarHeight(),
                TextWidget(
                  "Settings",
                  style: TextWidget.textStyleCurrent.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSpacer.p20(),
                ProfileCardWidget(
                  onTap: () {
                    isUserLoggedin
                        ? Get.toNamed(EditProfilePage.routeName)
                        //  UserController.to.logOut()
                        : Get.offAllNamed(LoginPage.routeName);
                  },
                  isLoggedIn: isUserLoggedin,
                  profileUrl: "https://picsum.photos/400/200",
                  name: UserController.to.user?.value.user?.name ?? "User Name",
                  phoneNumber: int.parse(
                      UserController.to.user?.value.user?.phone?.substring(
                              4,
                              UserController
                                  .to.user?.value.user?.phone?.length) ??
                          "0"),
                ),
                AppSpacer.p20(),
                const TextWidget(
                  "Application",
                ),
                AppSpacer.p16(),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SettingsButtonWidget(
                      name: "Language",
                      onPressed: () {
                        Get.toNamed(LanguagePage.routeName);
                      },
                      icon: CupertinoIcons.globe,
                    ),
                    // if (isUserLoggedin)
                    //   SettingsButtonWidget(
                    //     name: "Bookmarks",
                    //     onPressed: () {
                    //       Get.toNamed(BookmarksPage.routeName);
                    //     },
                    //     icon: CupertinoIcons.bookmark,
                    //   ),
                    // if (isUserLoggedin)
                    //   SettingsButtonWidget(
                    //     name: "Liked",
                    //     onPressed: () {
                    //       Get.toNamed(LikedksPage.routeName);
                    //     },
                    //     icon: CupertinoIcons.heart,
                    //   ),
                    SettingsButtonWidget(
                      name: "Contact",
                      onPressed: () {
                        Get.toNamed(ContactPage.routeName);
                      },
                      icon: CupertinoIcons.phone,
                    ),
                    SettingsButtonWidget(
                      name: "About",
                      onPressed: () {
                        Get.toNamed(AboutPage.routeName);
                      },
                      icon: CupertinoIcons.info,
                    ),
                    if (isUserLoggedin)
                      SettingsButtonWidget(
                        name: "Feedback",
                        onPressed: () {
                          Get.toNamed(FeedbackPage.routeName);
                        },
                        icon: CupertinoIcons.exclamationmark_bubble,
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SettingsButtonWidget extends StatelessWidget {
  const SettingsButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.name,
  });
  final VoidCallback onPressed;

  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        width: (screenWidth(context) - 48) / 2,
        height: screenWidth(context) * 0.35,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorPalette.black,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: ColorPalette.yellow,
              size: 30,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: TextWidget(
                    name,
                    style: TextWidget.textStyleCurrent.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                  ),
                ),
                AppSpacer.p8(),
                Icon(
                  isRtl()
                      ? CupertinoIcons.chevron_left
                      : CupertinoIcons.chevron_right,
                  color: ColorPalette.whiteColor,
                  size: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
