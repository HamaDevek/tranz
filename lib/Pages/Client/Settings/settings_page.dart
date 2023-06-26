import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Client/Settings/About/about_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Bookmarks/bookmarks_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Contact/contact_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Language/language_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Liked/liked_page.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

import '../../../Utility/utility.dart';
import '../../../Widgets/Containers/profile_card_Widget.dart';
import '../../Admin/Settings/Feedback/admin_feedback_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
          const ProfileCardWidget(
            profileUrl: "https://picsum.photos/400/200",
            name: "Jaza Yahya",
            phoneNumber: 07501380755,
          ),
          AppSpacer.p20(),
          const TextWidget(
            "Application",
          ),
          AppSpacer.p16(),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(6, (index) {
              return SettingsButtonWidget(
                name: getButtonNames(index),
                onPressed: getCallBacks(index),
                icon: getButtonIcons(index),
              );
            }),
          ),
        ],
      ),
    ));
  }

  String getButtonNames(int index) {
    switch (index) {
      case 0:
        return "Language";
      case 1:
        return "Bookmarks";
      case 2:
        return "Liked";
      case 3:
        return "Contact";
      case 4:
        return "About";
      case 5:
        return "Feedback";
      default:
        return "Language";
    }
  }

  IconData getButtonIcons(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.globe;
      case 1:
        return CupertinoIcons.bookmark;
      case 2:
        return CupertinoIcons.heart;
      case 3:
        return CupertinoIcons.phone;
      case 4:
        return CupertinoIcons.info;
      case 5:
        return CupertinoIcons.exclamationmark_bubble;
      default:
        return CupertinoIcons.globe;
    }
  }

  VoidCallback getCallBacks(int index) {
    switch (index) {
      case 0:
        return () {
          Get.toNamed(LanguagePage.routeName);
        };
      case 1:
        return () {
          Get.toNamed(BookmarksPage.routeName);
        };
      case 2:
        return () {
          Get.toNamed(LikedksPage.routeName);
        };
      case 3:
        return () {
          Get.toNamed(ContactPage.routeName);
        };
      case 4:
        return () {
          Get.toNamed(AboutPage.routeName);
        };
      case 5:
        return () {
          Get.toNamed(FeedbackPage.routeName);
        };
      default:
        return () {};
    }
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
