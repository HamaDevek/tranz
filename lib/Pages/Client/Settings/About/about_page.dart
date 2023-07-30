import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Getx/Controllers/client_controller.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

import '../../../../Theme/theme.dart';
import '../../../../Widgets/Other/app_spacer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  static const String routeName = "/about";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "About",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        primary: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacer.p20(),
            // TextWidget(
            //   getAboutDescription(),
            //   style: TextWidget.textStyleCurrent.copyWith(
            //     fontWeight: FontWeight.w300,
            //   ),
            //   // textAlign: TextAlign.start,
            // ),
            HtmlWidget(
              getAboutDescription(),

              textStyle: TextWidget.textStyleCurrent.copyWith(
                color: ColorPalette.whiteColor,
                fontWeight: FontWeight.w300,
              ),
              // textAlign: TextAlign.start,
            ),
            AppSpacer.p32(),
          ],
        ),
      ),
    );
  }

  String getAboutDescription() {
    switch ("x-lang".tr) {
      case "ku":
        return ClientController.to.metadata.value.descriptionKu ?? "";
      case "ar":
        return ClientController.to.metadata.value.descriptionAr ?? "";
      case "en":
        return ClientController.to.metadata.value.descriptionEn ?? "";

      default:
        return ClientController.to.metadata.value.descriptionKu ?? "";
    }
  }
}
