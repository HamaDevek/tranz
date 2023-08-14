import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Theme/theme.dart';
import '../../Utility/utility.dart';
import '../Other/image_widget.dart';
import '../Text/text_widget.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    super.key,
    required this.profileUrl,
    required this.name,
    required this.phoneNumber,
    required this.onTap,
    this.isLoggedIn = false,
  });
  final String profileUrl;
  final String name;
  final int phoneNumber;
  final VoidCallback onTap;
  final bool isLoggedIn;

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
      leading: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoggedIn
                ? ImageWidget(
                    isCircle: true,
                    height: screenWidth(context) * 0.18,
                    width: screenWidth(context) * 0.18,
                    imageUrl: profileUrl,
                  )
                : const Icon(
                    CupertinoIcons.person_circle_fill,
                    size: 80,
                    color: ColorPalette.whiteColor,
                  )
          ],
        ),
      ),
      title: TextWidget(
        isLoggedIn ? name : "Sign In",
        style: TextWidget.textStyleCurrent.copyWith(),
      ),
      subtitle: isLoggedIn
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  formatPhoneNumber(
                    phoneNumber,
                  ),
                  style: TextWidget.textStyleCurrent.copyWith(
                    fontSize: 14,
                    color: ColorPalette.greyText,
                    fontWeight: FontWeight.w400,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            )
          : null,
      trailing: Icon(
        isRtl() ? CupertinoIcons.chevron_left : CupertinoIcons.chevron_right,
        color: ColorPalette.whiteColor,
        size: 20,
      ),
    );
  }
}
