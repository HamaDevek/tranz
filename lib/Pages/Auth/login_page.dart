import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Client/Main%20Page/main_page.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Buttons/request_button.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import 'package:tranzhouse/Widgets/TextField/textfield_widget.dart';

import 'sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.black,
      body: SizedBox(
        height: screenHeight(context),
        child: Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/intro.image.png",
                  height: screenHeight(context) * 0.52,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: screenWidth(context) * 0.5,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: screenHeight(context) * 0.50,
                decoration: const BoxDecoration(
                  color: ColorPalette.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacer.p20(),
                      TextWidget(
                        "Welcome Back!",
                        style: TextWidget.textStyleCurrent.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppSpacer.p4(),
                      TextWidget(
                        "Long time no see! Let’s login to get started",
                        style: TextWidget.textStyleCurrent.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.greyText,
                        ),
                      ),
                      AppSpacer.p16(),
                      const TextFieldWidget(
                        hintText: "Phone Number",
                      ),
                      AppSpacer.p16(),
                      const TextFieldWidget(
                        hintText: "Password",
                        obscureText: true,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: () {},
                          child: TextWidget(
                            "Forgot Password?",
                            style: TextWidget.textStyleCurrent.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.greyText,
                            ),
                          ),
                        ),
                      ),
                      RequestButtonWidget(
                        width: double.infinity,
                        onPressed: () async {
                          Get.toNamed(ClientMainPage.routeName);
                        },
                        text: "Sign In",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            "Don’t have an account?",
                            style: TextWidget.textStyleCurrent.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.greyText,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(SignupPage.routeName);
                            },
                            child: TextWidget(
                              "Register",
                              style: TextWidget.textStyleCurrent.copyWith(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
