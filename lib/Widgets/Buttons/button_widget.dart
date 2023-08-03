import 'package:flutter/material.dart';

import '../../Theme/theme.dart';
import '../Other/app_spacer.dart';
import '../Text/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double? height;
  final double? width;
  final Widget? leading;
  final Widget? trailing;
  final double borderRadius;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final AlignmentGeometry textAlignment;
  final double fontSize;

  const ButtonWidget({
    Key? key,
    required this.text,
    this.backgroundColor = ColorPalette.yellow,
    this.textColor = ColorPalette.primary,
    required this.onPressed,
    this.height,
    this.width,
    this.leading,
    this.trailing,
    this.borderColor,
    this.borderRadius = 20,
    this.textStyle,
    this.onLongPress,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
    this.textAlignment = Alignment.center,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
          ),
        ),
        onLongPress: onLongPress,
        child: FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSpacer.p8(),
              if (leading != null) ...[leading!, AppSpacer.p8()],
              TextWidget(
                text,
                style: textStyle ??
                    TextWidget.textStyleCurrent.copyWith(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                maxLines: 1,
              ),
              if (trailing != null) ...[AppSpacer.p8(), trailing!],
              AppSpacer.p16(),
            ],
          ),
        ),
      ),
    );
  }
}
