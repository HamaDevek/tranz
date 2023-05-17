import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Theme/theme.dart';
import '../Text/text_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.pageTitle = '',
    this.iconColor = ColorPalette.primary,
    this.iconBackgroundColor = ColorPalette.whiteColor,
    this.onPressedBackButton,
    this.backgroundColor = ColorPalette.primary,
    this.textColor = ColorPalette.whiteColor,
    this.actions,
    this.gradient,
    this.centerTitle = true,
    this.titleWidget,
    this.isBottomDividerVisible = false,
    this.isBottomHasPadding = false,
  });
  final String? pageTitle;
  final Color iconColor;
  final Color textColor;
  final Color iconBackgroundColor;
  final Color backgroundColor;
  final VoidCallback? onPressedBackButton;
  final List<Widget>? actions;
  final Gradient? gradient;
  final bool centerTitle;
  final bool isBottomDividerVisible;
  final bool isBottomHasPadding;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: backgroundColor,
          blurRadius: 1,
          offset: const Offset(0, 1),
          spreadRadius: 3,
        ),
      ], gradient: gradient),
      child: AppBar(
          leadingWidth: 0,
          elevation: 0,
          leading: const SizedBox.shrink(),
          backgroundColor: backgroundColor,
          centerTitle: false,
          bottom: isBottomDividerVisible
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isBottomHasPadding ? 16 : 0),
                    child: const Divider(
                      color: ColorPalette.greyText,
                    ),
                  ),
                )
              : null,
          title: Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UnconstrainedBox(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(iconBackgroundColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(iconColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      const CircleBorder(),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                    ),
                    animationDuration: const Duration(seconds: 2),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(35, 35),
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (onPressedBackButton != null) {
                      onPressedBackButton?.call();
                    } else {
                      Get.back();
                    }
                  },
                  child: const Icon(
                    CupertinoIcons.back,
                    size: 20,
                  ),
                ),
              ),
              titleWidget ?? const SizedBox(width: 0),
              if (titleWidget == null)
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          end: actions == null ? 40 : 0),
                      child: TextWidget(
                        '$pageTitle',
                        style: TextWidget.textStyleCurrent.copyWith(
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          actions: actions),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
