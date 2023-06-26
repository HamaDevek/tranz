import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Widgets/Buttons/request_button.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import 'package:tranzhouse/Widgets/TextField/textfield_widget.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});
  static const String routeName = "/feedback";

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Feedback",
      ),
      body: Column(
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
          const TextFieldWidget(
            hintText: "Write your feedback here",
            maxLines: 7,
          ),
          const Spacer(),
          RequestButtonWidget(
            width: Get.width,
            onPressed: () async {},
            text: "Send",
          ),
          AppSpacer.p32(),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
