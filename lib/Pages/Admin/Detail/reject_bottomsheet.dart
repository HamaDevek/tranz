import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Widgets/Buttons/request_button.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import 'package:tranzhouse/Widgets/TextField/textfield_widget.dart';

class DeclineBottomsheetWidget extends StatefulWidget {
  const DeclineBottomsheetWidget({
    super.key,
    required this.onDeclinePressed,
  });
  final Function(String note) onDeclinePressed;

  static show({
    required Function(String note) onDeclinePressed,
  }) {
    Get.bottomSheet(
      DeclineBottomsheetWidget(
        onDeclinePressed: onDeclinePressed,
      ),
      isScrollControlled: true,
    );
  }

  @override
  State<DeclineBottomsheetWidget> createState() =>
      _DeclineBottomsheetWidgetState();
}

class _DeclineBottomsheetWidgetState extends State<DeclineBottomsheetWidget> {
  late TextEditingController _noteController;
  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: ColorPalette.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          AppSpacer.p20(),
          TextWidget(
            "Write a note",
            style: TextWidget.textStyleCurrent.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorPalette.whiteColor,
              fontSize: 20,
            ),
          ),
          AppSpacer.p4(),
          TextWidget(
            "write a note to the user why the order is declined",
            style: TextWidget.textStyleCurrent.copyWith(
              fontWeight: FontWeight.w400,
              color: ColorPalette.greyText,
            ),
          ),
          AppSpacer.p20(),
          TextFieldWidget(
            controller: _noteController,
            hintText: "Write a note",
            maxLines: 5,
            minLines: 5,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter note";
              }
              return null;
            },
          ),
          AppSpacer.p20(),
          RequestButtonWidget(
            color: ColorPalette.red,
            textColor: ColorPalette.whiteColor,
            width: double.maxFinite,
            onPressed: () async {
              if (TextFieldValidationController.instance.validate()) {
                await widget.onDeclinePressed(_noteController.text);
              }
            },
            text: "Decline",
          ),
          AppSpacer.p32(),
        ],
      ),
    );
  }
}
