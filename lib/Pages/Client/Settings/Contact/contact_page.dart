import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';

import '../../../../Theme/theme.dart';
import '../../../../Widgets/Other/app_spacer.dart';
import '../../../../Widgets/Text/text_widget.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  static const String routeName = "/contact";

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
                Expanded(
                  child: ContactButton(
                    onPressed: () {},
                    icon: CupertinoIcons.phone,
                    phoneNumber: 07501380755,
                  ),
                ),
                AppSpacer.p16(),
                Expanded(
                  child: ContactButton(
                    onPressed: () {},
                    icon: Icons.mail_outline_sharp,
                    name: "hhish4m@gmail.com",
                  ),
                ),
              ],
            ),
            AppSpacer.p16(),
            ContactButton(
              isFullWidth: true,
              onPressed: () {},
              icon: Icons.location_on_outlined,
              name:
                  "Iraq, Kurdistan, Erbil, Empire Towers , 12th Floor, Office NO.8",
            ),
          ],
        ),
      ),
    );
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
  final int? phoneNumber;

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
                      phoneNumber != null
                          ? formatPhoneNumber(phoneNumber!)
                          : "$name",
                      maxLines: 1,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
