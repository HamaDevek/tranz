import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Auth/verify_phone.dart';
import 'package:tranzhouse/Widgets/TextField/textfield_widget.dart';

import '../../Theme/theme.dart';
import '../../Widgets/Buttons/request_button.dart';
import '../../Widgets/Other/app_spacer.dart';
import '../../Widgets/Text/text_widget.dart';

class AddPhoneNumberPage extends StatefulWidget {
  const AddPhoneNumberPage({super.key});
  static const String routeName = '/add_phone_number';

  @override
  State<AddPhoneNumberPage> createState() => _AddPhoneNumberPageState();
}

class _AddPhoneNumberPageState extends State<AddPhoneNumberPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacer.appBarHeight(),
              AppSpacer.p20(),
              TextWidget(
                "Add Phone Number",
                style: TextWidget.textStyleCurrent.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppSpacer.p4(),
              TextWidget(
                "You will receive an SMS verification that may apply message and data rates",
                style: TextWidget.textStyleCurrent.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.greyText,
                ),
              ),
              AppSpacer.p20(),
              const TextFieldWidget(
                hintText: "Phone Number",
                keyboardType: TextInputType.phone,
              ),
              const Spacer(),
              RequestButtonWidget(
                width: double.infinity,
                onPressed: () async {
                  await Future.delayed(
                    const Duration(milliseconds: 500),
                    () {
                      Get.toNamed(VerifyPhoneNumberPage.routeName);
                    },
                  );
                },
                text: "Continue",
              ),
              AppSpacer.p32(),
            ],
          ),
        ),
      ),
    );
  }
}
