import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Admin/Settings/Feedback/admin_feedback_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/About/about_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Contact/contact_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Language/language_page.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import '../../../Widgets/Containers/profile_card_Widget.dart';
import '../../Client/Settings/settings_page.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});
  static const String routeName = "/admin-settings";

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(
          pageTitle: "Settings",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          primary: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                children: List.generate(4, (index) {
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
        return "About";
      case 2:
        return "Contact";
      case 3:
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
        return CupertinoIcons.info;
      case 2:
        return CupertinoIcons.phone;
      case 3:
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
          Get.toNamed(AboutPage.routeName);
        };
      case 2:
        return () {
          Get.toNamed(ContactPage.routeName);
        };
      case 3:
        return () {
          Get.toNamed(FeedbackPage.routeName);
        };

      default:
        return () {};
    }
  }
}
