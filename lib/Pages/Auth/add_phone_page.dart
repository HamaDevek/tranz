import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Getx/Controllers/user_controller.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/TextField/textfield_widget.dart';

import '../../Theme/theme.dart';
import '../../Widgets/Buttons/request_button.dart';
import '../../Widgets/Other/app_spacer.dart';
import '../../Widgets/Text/text_widget.dart';
import 'verify_phone.dart';

class AddPhoneNumberPage extends StatefulWidget {
  const AddPhoneNumberPage({super.key});
  static const String routeName = '/add_phone_number';

  @override
  State<AddPhoneNumberPage> createState() => _AddPhoneNumberPageState();
}

class _AddPhoneNumberPageState extends State<AddPhoneNumberPage> {
  TextEditingController phoneController = TextEditingController();
  late String name;
  late String password;
  late String address;

  @override
  void initState() {
    super.initState();
    name = Get.arguments['name'] as String;
    password = Get.arguments["password"] as String;
    address = Get.arguments["address"] as String;
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppSpacer.appBarHeight(),
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
                "Your phone number will be used to verify your account",
                style: TextWidget.textStyleCurrent.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.greyText,
                ),
              ),
              AppSpacer.p20(),
              TextFieldWidget(
                controller: phoneController,
                hintText: "Phone Number",
                keyboardType: TextInputType.phone,
                // prefixText: "+964",
                prefixIcon: TextWidget(
                  "+964",
                  style: TextWidget.textStyleCurrent.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.whiteColor,
                  ),
                ).paddingSymmetric(horizontal: 8),
                onChanged: (value) {
                  if (value.length == 12) {
                    TextFieldValidationController.instance.validate();
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your phone number";
                  } else if (value.length < 12) {
                    return "Please enter a valid phone number";
                  } else if (value.startsWith("7") == false) {
                    return "Please enter a valid phone number";
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
                  MaskedTextInputFormatter(
                    mask: "### ### ####",
                    separator: ' ',
                  ),
                ],
              ).ltr,
              Row(
                children: [
                  TextWidget(
                    "E.g.",
                    style: TextWidget.textStyleCurrent.copyWith(
                      // fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: ColorPalette.whiteColor,
                    ),
                  ),
                  AppSpacer.p4(),
                  TextWidget(
                    "770 366 2766",
                    style: TextWidget.textStyleCurrent.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: ColorPalette.greyText,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ).directionalPadding(start: 16, top: 4),
              const Spacer(),
              RequestButtonWidget(
                width: double.infinity,
                onPressed: () async {
                  if (TextFieldValidationController.instance.validate()) {
                    final res = await UserController.to.phoneTaken(
                        phone: phoneController.text.replaceAll(' ', '').trim());

                    if (res.isSuccess &&
                        UserController.to.isPhoneTaken.value == false) {
                      Get.toNamed(
                        VerifyPhoneNumberPage.routeName,
                        arguments: {
                          "name": name,
                          "password": password,
                          "phone":
                              phoneController.text.replaceAll(' ', '').trim(),
                          "address": address,
                        },
                      );
                    }
                  }
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
