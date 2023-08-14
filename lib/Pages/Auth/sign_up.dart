import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Auth/add_phone_page.dart';
import 'package:tranzhouse/Pages/Auth/login_page.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Buttons/request_button.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import 'package:tranzhouse/Widgets/TextField/textfield_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static const String routeName = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  late TextEditingController _passwordController;
  TextEditingController addressController = TextEditingController();
  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _showEye = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    _passwordController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _toggleObsecure() {
    _isObscure.value = !_isObscure.value;
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
                // PositionedDirectional(
                //   end: 16,
                //   top: 64,
                //   child: ButtonWidget(
                //     text: "Skip",
                //     textColor: ColorPalette.primary,
                //     fontSize: 14,
                //     borderRadius: 100,
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 16,
                //       vertical: 0,
                //     ),
                //     onPressed: () {
                //       Get.offAllNamed(ClientMainPage.routeName);
                //     },
                //   ),
                // ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: screenHeight(context) * 0.52,
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
                        "Register",
                        style: TextWidget.textStyleCurrent.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppSpacer.p4(),
                      TextWidget(
                        "Create your account",
                        style: TextWidget.textStyleCurrent.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.greyText,
                        ),
                      ),
                      AppSpacer.p20(),
                      TextFieldWidget(
                        controller: nameController,
                        hintText: "Name",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),
                      AppSpacer.p16(),
                      AnimatedBuilder(
                          animation: Listenable.merge([_isObscure, _showEye]),
                          builder: (context, chil) {
                            return TextFieldWidget(
                              obscureText: _isObscure.value,
                              controller: _passwordController,
                              hintText: "Password",
                              suffix: _showEye.value
                                  ? IconButton(
                                      onPressed: _toggleObsecure,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your password";
                                } else if (value.length < 8) {
                                  return "Password must be at least 8 characters";
                                }

                                return null;
                              },
                            );
                          }),
                      AppSpacer.p16(),
                      TextFieldWidget(
                        controller: addressController,
                        hintText: "Address",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your address";
                          } else if (value.length < 6) {
                            return "Address must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      AppSpacer.p20(),
                      RequestButtonWidget(
                        width: double.infinity,
                        onPressed: () async {
                          if (TextFieldValidationController.instance
                              .validate()) {
                            Get.toNamed(AddPhoneNumberPage.routeName,
                                arguments: {
                                  "name": nameController.text,
                                  "password": _passwordController.text,
                                  "address": addressController.text,
                                });
                          }
                        },
                        text: "Sign Up",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            "Already have an account?",
                            style: TextWidget.textStyleCurrent.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.greyText,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offNamed(LoginPage.routeName,
                                  arguments: true);
                            },
                            child: TextWidget(
                              "Sign In",
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
