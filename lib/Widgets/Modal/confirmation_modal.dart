import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Theme/theme.dart';
import '../Buttons/request_button.dart';
import '../Other/app_spacer.dart';
import '../Text/text_widget.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  final String? bodyText;
  final String? titleText;
  final String? confirmText;
  final String? cancelText;
  final Future Function() onConfirmed;
  final Future Function()? onCancel;

  final Color? confirmButtonColor;
  final Color? cancelButtonColor;
  final Color? confirmTextColor;
  final Color? cancelTextColor;
  const ConfirmationDialogWidget({
    Key? key,
    required this.onConfirmed,
    this.onCancel,
    required this.bodyText,
    this.titleText,
    this.confirmText,
    this.cancelText,
    this.confirmButtonColor,
    this.cancelButtonColor,
    this.confirmTextColor,
    this.cancelTextColor,
  }) : super(key: key);

  static Future<bool?> show(
    BuildContext context, {
    required Future Function() onConfirmed,
    Future Function()? onCancel,
    required String? bodyText,
    String? titleText,
    String? confirmText,
    String? cancelText,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    Color? confirmTextColor,
    Color? cancelTextColor,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ConfirmationDialogWidget(
          bodyText: bodyText,
          onConfirmed: onConfirmed,
          onCancel: onCancel,
          titleText: titleText,
          confirmText: confirmText,
          cancelText: cancelText,
          confirmButtonColor: confirmButtonColor,
          cancelButtonColor: cancelButtonColor,
          confirmTextColor: confirmTextColor,
          cancelTextColor: cancelTextColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      backgroundColor: ColorPalette.whiteColor,
      insetPadding: const EdgeInsets.all(32),
      contentPadding: const EdgeInsets.all(32),
      content: Builder(builder: (context) {
        return SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                bodyText ?? '',
                style: TextWidget.textStyleCurrent.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.primary,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacer.p32(),
              Row(
                children: [
                  Expanded(
                    child: RequestButtonWidget(
                      fontSize: 14,
                      color: cancelButtonColor ?? ColorPalette.red,
                      textColor: cancelTextColor ?? ColorPalette.whiteColor,
                      text: cancelText ?? 'No',
                      onPressed: () async {
                        if (onCancel != null) {
                          onCancel!();
                        }
                        Get.back(result: false);
                      },
                    ),
                  ),
                  AppSpacer.p16(),
                  Expanded(
                    child: RequestButtonWidget(
                      fontSize: 14,
                      color: confirmButtonColor ?? ColorPalette.green,
                      text: confirmText ?? 'Yes',
                      textColor: confirmTextColor ?? ColorPalette.primary,
                      onPressed: onConfirmed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
