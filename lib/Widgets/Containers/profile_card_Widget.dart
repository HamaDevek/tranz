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
  });
  final String profileUrl;
  final String name;
  final int phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
            ImageWidget(
              isCircle: true,
              height: screenWidth(context) * 0.18,
              width: screenWidth(context) * 0.18,
              imageUrl: profileUrl,
            ),
          ],
        ),
      ),
      title: TextWidget(
        name,
        style: TextWidget.textStyleCurrent.copyWith(),
      ),
      subtitle: TextWidget(
        formatPhoneNumber(phoneNumber),
        style: TextWidget.textStyleCurrent.copyWith(
          fontSize: 14,
          color: ColorPalette.greyText,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(
        isRtl() ? CupertinoIcons.chevron_left : CupertinoIcons.chevron_right,
        color: ColorPalette.whiteColor,
        size: 20,
      ),
    );
  }
}
