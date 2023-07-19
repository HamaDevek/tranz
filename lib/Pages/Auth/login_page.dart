import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Buttons/request_button.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import 'package:tranzhouse/Widgets/TextField/textfield_widget.dart';

import '../../Getx/Controllers/user_controller.dart';
import '../../Widgets/Buttons/button_widget.dart';
import '../Client/Main Page/main_page.dart';
import 'sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _showEye = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _toggleObsecure() {
    _isObscure.value = !_isObscure.value;
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                PositionedDirectional(
                  end: 16,
                  top: 64,
                  child: ButtonWidget(
                    text: "Skip",
                    textColor: ColorPalette.primary,
                    fontSize: 14,
                    borderRadius: 100,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    onPressed: () {
                      Get.offAllNamed(ClientMainPage.routeName);
                    },
                  ),
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
                      TextFieldWidget(
                        controller: phoneController,
                        hintText: "Phone Number",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your phone number";
                          } else if (value.length < 12) {
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
                      ),
                      AppSpacer.p16(),
                      AnimatedBuilder(
                          animation: Listenable.merge([_isObscure, _showEye]),
                          builder: (context, snapshot) {
                            return TextFieldWidget(
                              controller: passwordController,
                              hintText: "Password",
                              obscureText: _isObscure.value,
                              suffix: _showEye.value
                                  ? IconButton(
                                      onPressed: () {
                                        _toggleObsecure();
                                      },
                                      icon: Icon(
                                        _isObscure.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: _isObscure.value
                                            ? ColorPalette.greyText
                                            : ColorPalette.whiteColor,
                                      ),
                                    )
                                  : null,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _showEye.value = true;
                                } else {
                                  _showEye.value = false;
                                  _isObscure.value = true;
                                }
                              },
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "Please enter your password";
                                } else if (text.length < 6) {
                                  return "Password must be at least 8 characters";
                                }

                                return null;
                              },
                            );
                          }),
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
                          if (TextFieldValidationController.instance
                              .validate()) {
                            final res = await UserController.to.login(
                              phone: phoneController.text
                                  .replaceAll(' ', '')
                                  .trim(),
                              password: passwordController.text,
                            );

                            if (res.isSuccess) {
                              Get.offAllNamed(ClientMainPage.routeName);
                            }
                          }
                          // Get.toNamed(AdminMainPage.routeName);
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
                              Get.offNamed(SignupPage.routeName);
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
