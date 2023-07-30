import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Getx/Controllers/client_controller.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Widgets/Buttons/request_button.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/swipe_off_keyborad.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import 'package:tranzhouse/Widgets/TextField/textfield_widget.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});
  static const String routeName = "/feedback";

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    // dispose the controllers
    emailController.dispose();
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Feedback",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SwipeOffKeyborad(
              ctx: context,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacer.p20(),
                    TextWidget(
                      "Tell us your feedback",
                      style: TextWidget.textStyleCurrent.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextWidget(
                      "We are always looking for ways to improve our service. Your feedback is important to us.",
                      style: TextWidget.textStyleCurrent.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    AppSpacer.p20(),
                    TextFieldWidget(
                      controller: emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        } else if (!value.isEmail) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                    ),
                    
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.info,
                          color: ColorPalette.greyText,
                          size: 18,
                        ),
                        AppSpacer.p8(),
                        TextWidget(
                          "We will contact you on this email",
                          style: TextWidget.textStyleCurrent.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 16, vertical: 8),
                    AppSpacer.p16(),
                    TextFieldWidget(
                      controller: titleController,
                      hintText: "Title",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Title is required";
                        } else if (value.length < 3) {
                          return "Title must be at least 3 characters long";
                        }
                        return null;
                      },
                    ),
                    AppSpacer.p16(),
                    TextFieldWidget(
                      controller: descriptionController,
                      hintText: "Write your feedback here...",
                      maxLines: 7,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Description is required";
                        } else if (value.length < 10) {
                          return "Description must be at least 10 characters long";
                        }
                        return null;
                      },
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        RequestButtonWidget(
          width: Get.width,
          onPressed: () async {
            if (TextFieldValidationController.instance.validate()) {
              final res = await ClientController.to.feedBack(
                email: emailController.text,
                title: titleController.text,
                description: descriptionController.text,
              );
              if (res.isSuccess) {
                clearTextFields();
                unfocus();
              }
            }
          },
          text: "Send",
        ).paddingSymmetric(horizontal: 8),
      ],
    );
  }

  void clearTextFields() {
    emailController.clear();
    titleController.clear();
    descriptionController.clear();
  }

  void unfocus() {
    FocusScope.of(context).unfocus();
  }
}
