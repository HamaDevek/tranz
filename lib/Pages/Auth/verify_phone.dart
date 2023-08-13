import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';

import '../../Getx/Controllers/user_controller.dart';
import '../../Theme/theme.dart';
import '../../Widgets/Buttons/request_button.dart';
import '../../Widgets/Other/app_spacer.dart';
import '../../Widgets/Text/text_widget.dart';
import '../Client/Main Page/main_page.dart';

class VerifyPhoneNumberPage extends StatefulWidget {
  const VerifyPhoneNumberPage({super.key});
  static const String routeName = '/verify_phone_number';

  @override
  State<VerifyPhoneNumberPage> createState() => _VerifyPhoneNumberPageState();
}

class _VerifyPhoneNumberPageState extends State<VerifyPhoneNumberPage> {
  final StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  final TextEditingController textController = TextEditingController();
  late String phoneNumber;
  String sessionInfo = "";
  String name = "";
  String password = "";
  String address = "";
  bool isResendAvailable = false;

  @override
  void initState() {
    super.initState();
    phoneNumber = Get.arguments['phone'] as String;
    name = Get.arguments['name'] as String;
    password = Get.arguments['password'] as String;
    address = Get.arguments['address'] as String;

    print(
        "PHONE: $phoneNumber, NAME: $name, PASSWORD: $password, ADDRESS: $address");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      UserController.to
          .firebaseVerifyPhoneNumber(
        phoneNumber,
      )
          .then((value) {
        if (value != null) {
          sessionInfo = value;
        }
      });
    });
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
                "Verify Phone Number",
                style: TextWidget.textStyleCurrent.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppSpacer.p4(),
              TextWidget(
                "We have sent you an SMS with a verification code to\n +964 @param please enter it below"
                    .trParams({
                  "param": formatPhoneNumber(
                    int.parse(phoneNumber),
                    withCountryCode: false,
                  ),
                }),
                // "We have sent you an SMS with a verification code to\n +964 ${formatPhoneNumber(
                //   int.parse(phoneNumber),
                //   withCountryCode: false,
                // )} please enter it below",
                style: TextWidget.textStyleCurrent.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.greyText,
                ),
              ),
              AppSpacer.p20(),
              PinTextFieldWidget(
                errorController: errorController,
                textController: textController,
                onCompleted: (value) {},
              ),
              AppSpacer.p32(),
              Center(
                child: isResendAvailable
                    ? Text.rich(
                        TextSpan(
                          text: "Didn't receive the code? ",
                          style: TextWidget.textStyleCurrent.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.greyText,
                          ),
                          children: [
                            TextSpan(
                              text: "Resend",
                              style: TextWidget.textStyleCurrent.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.whiteColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  textController.clear();

                                  setState(() {
                                    isResendAvailable = false;
                                  });
                                  UserController.to
                                      .firebaseVerifyPhoneNumber(
                                    phoneNumber,
                                  )
                                      .then((value) {
                                    if (value != null) {
                                      sessionInfo = value;
                                    }
                                  });
                                },
                            ),
                          ],
                        ),
                      )
                    : PinTimerWidget(
                        onTimerEnd: () {
                          setState(() {
                            isResendAvailable = true;
                          });
                        },
                      ),
              ),
              const Spacer(),
              RequestButtonWidget(
                width: double.infinity,
                onPressed: () async {
                  print(
                    "PHONE: $phoneNumber, NAME: $name, PASSWORD: $password, CODE: ${textController.text}, SESSION: $sessionInfo",
                  );

                  if (textController.text.length == 6) {
                    final res = await UserController.to.signUp(
                      name: name,
                      phone: phoneNumber,
                      code: textController.text,
                      sessionInfo: sessionInfo,
                      password: password,
                      address: address,
                    );
                    if (res.isSuccess) {
                      Get.offAllNamed(ClientMainPage.routeName);
                    }
                  } else {
                    Get.snackbar(
                      "Error",
                      "Please enter a valid verification code",
                      backgroundColor: ColorPalette.red,
                      colorText: ColorPalette.whiteColor,
                      snackPosition: SnackPosition.TOP,
                      snackStyle: SnackStyle.FLOATING,
                      borderRadius: 10,
                    );
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

class PinTextFieldWidget extends StatefulWidget {
  final StreamController<ErrorAnimationType> errorController;
  final TextEditingController textController;
  final ValueChanged<String>? onCompleted;

  const PinTextFieldWidget(
      {Key? key,
      required this.errorController,
      this.onCompleted,
      required this.textController})
      : super(key: key);

  @override
  State<PinTextFieldWidget> createState() => _PinTextFieldWidgetState();
}

class _PinTextFieldWidgetState extends State<PinTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    double actualWidth = screenWidth(context) - 32;
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      textStyle: TextStyle(
        fontFamily: 'font'.tr,
        fontSize: 16,
        color: ColorPalette.whiteColor,
      ),
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        // fieldHeight: 50,
        // fieldWidth: 50,
        fieldHeight: actualWidth / 7,
        fieldWidth: actualWidth / 7,
        borderWidth: 1,
        // fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
        activeFillColor: Colors.transparent,
        inactiveColor: Colors.grey.shade300,
        errorBorderColor: ColorPalette.red,
        inactiveFillColor: Colors.transparent,
        selectedFillColor: Theme.of(context).primaryColor,
        activeColor: Colors.grey.shade300,
        selectedColor: ColorPalette.yellow,
      ),
      cursorColor: Colors.white,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      errorAnimationController: widget.errorController,
      controller: widget.textController,
      onCompleted: widget.onCompleted,
      onChanged: (value) {
        // print(value);
        setState(() {
          // currentText = value;
        });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      appContext: context,
    );
  }
}

class PinTimerWidget extends StatefulWidget {
  final VoidCallback onTimerEnd;

  const PinTimerWidget({Key? key, required this.onTimerEnd}) : super(key: key);

  @override
  State<PinTimerWidget> createState() => _PinTimerWidgetState();
}

class _PinTimerWidgetState extends State<PinTimerWidget> {
  Timer? _timer;
  Duration _duration = const Duration(seconds: 180);

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
      _duration = Duration(seconds: _duration.inSeconds - 1);
      if (timer.tick == 180) {
        _timer?.cancel();
        widget.onTimerEnd();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(
          formatHHMMSS(_duration.inSeconds),
          style: TextWidget.textStyleCurrent.copyWith(
            fontSize: 16,
            color: ColorPalette.greyText,
          ),
        ),
      ],
    );
  }

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }
    return "$hoursStr:$minutesStr:$secondsStr";
  }
}
