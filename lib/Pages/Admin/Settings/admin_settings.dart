import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Client/Settings/Feedback/feedback_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/About/about_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Contact/contact_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/Language/language_page.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import '../../../Getx/Controllers/user_controller.dart';
import '../../../Theme/theme.dart';
import '../../../Widgets/Modal/confirmation_modal.dart';
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
              AdminProfileCardWidget(
                onTap: () {},
                name: UserController.to.user?.value.user?.name ?? '',
                email: UserController.to.user?.value.user?.email ?? '',
              ),
              AppSpacer.p20(),
              // const TextWidget(
              //   "Application",
              // ),
              // AppSpacer.p16(),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: List.generate(1, (index) {
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

class AdminProfileCardWidget extends StatelessWidget {
  const AdminProfileCardWidget({
    super.key,
    required this.name,
    required this.email,
    required this.onTap,
  });
  final String name;
  final String email;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: ColorPalette.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      dense: false,
      horizontalTitleGap: 16,
      leading: const FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              CupertinoIcons.person,
              size: 50,
              color: ColorPalette.greyText,
            )
          ],
        ),
      ),
      title: TextWidget(
        name,
        style: TextWidget.textStyleCurrent.copyWith(),
      ),
      subtitle: TextWidget(
        email,
        style: TextWidget.textStyleCurrent.copyWith(
          fontSize: 14,
          color: ColorPalette.greyText,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          ConfirmationDialogWidget.show(
            context,
            onConfirmed: () async {
              UserController.to.logOut();
            },
            bodyText: "Are you sure you want to logout?",
          );
        },
        icon: const Icon(
          Icons.logout,
          color: ColorPalette.red,
        ),
      ),
    );
  }
}
