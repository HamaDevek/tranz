import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Theme/theme.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final int? maxLines;
  const TextWidget(this.text,
      {Key? key,
      this.style,
      this.textAlign,
      this.textDirection,
      this.softWrap,
      this.maxLines})
      : super(key: key);

  static TextStyle get textStyleCurrent {
    switch ('language.code'.tr) {
      case 'ar_SO':
        return TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'font'.tr,
          color: ColorPalette.whiteColor,
          wordSpacing: 2,
          // overflow: TextOverflow.visible,
        );
      case 'ar_IQ':
        return TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'font'.tr,
          color: ColorPalette.whiteColor,
          wordSpacing: 2,
          // overflow: TextOverflow.visible,
        );
      case 'en_US':
        return TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'font'.tr,
          color: ColorPalette.whiteColor,
          // overflow: TextOverflow.visible,
        );
    }
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'font'.tr,
      color: ColorPalette.primary,
      // overflow: TextOverflow.visible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      style: style ?? textStyleCurrent,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      maxLines: maxLines,
    );
  }
}
