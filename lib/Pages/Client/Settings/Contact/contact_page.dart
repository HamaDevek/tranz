import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Getx/Controllers/client_controller.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';

import '../../../../Theme/theme.dart';
import '../../../../Utility/utility.dart';
import '../../../../Widgets/Other/app_spacer.dart';
import '../../../../Widgets/Text/text_widget.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  static const String routeName = "/contact";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Contact",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacer.p20(),
            Row(
              children: [
                if (ClientController.to.metadata.value.phone1 != '' &&
                    ClientController.to.metadata.value.phone1 != null)
                  Expanded(
                    child: ContactButton(
                      onPressed: () {
                        launchPhoneCall(
                            "${ClientController.to.metadata.value.phone1}");
                      },
                      icon: CupertinoIcons.phone,
                      phoneNumber:
                          "${ClientController.to.metadata.value.phone1}",
                    ),
                  ),
                if (ClientController.to.metadata.value.phone1 != '' &&
                    ClientController.to.metadata.value.phone1 != null)
                  AppSpacer.p16(),
                if (ClientController.to.metadata.value.phone2 != '' &&
                    ClientController.to.metadata.value.phone2 != null)
                  Expanded(
                    child: ContactButton(
                      onPressed: () {
                        launchPhoneCall(
                            "${ClientController.to.metadata.value.phone2}");
                      },
                      icon: CupertinoIcons.phone,
                      phoneNumber:
                          "${ClientController.to.metadata.value.phone2}",
                    ),
                  ),
              ],
            ),
            AppSpacer.p16(),
            if (ClientController.to.metadata.value.email != '' &&
                ClientController.to.metadata.value.email != null)
              ContactButton(
                onPressed: () {},
                icon: Icons.mail_outline_sharp,
                name: ClientController.to.metadata.value.email ?? "",
              ),
            AppSpacer.p16(),
            if (getAddress() != '')
              ContactButton(
                isFullWidth: true,
                onPressed: () {},
                icon: Icons.location_on_outlined,
                name: getAddress(),
              ),
          ],
        ),
      ),
    );
  }

  String getAddress() {
    switch ("x-lang".tr) {
      case "ku":
        return ClientController.to.metadata.value.addressKu ?? "";
      case "ar":
        return ClientController.to.metadata.value.addressAr ?? "";
      case "en":
        return ClientController.to.metadata.value.addressEn ?? "";

      default:
        return ClientController.to.metadata.value.addressEn ?? "";
    }
  }
}

class ContactButton extends StatelessWidget {
  const ContactButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.name,
    this.isFullWidth = false,
    this.phoneNumber,
  });
  final VoidCallback onPressed;
  final bool isFullWidth;
  final IconData icon;
  final String? name;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
            AppSpacer.p8(),
            isFullWidth
                ? TextWidget(
                    "$name",
                  )
                : FittedBox(
                    child: TextWidget(
                      phoneNumber != null ? phoneNumber ?? "" : "$name",
                      maxLines: 1,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
