import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Getx/Controllers/language_controller.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';

import '../../../../Theme/theme.dart';
import '../../../../Utility/utility.dart';
import '../../../../Widgets/Other/app_spacer.dart';
import '../../../../Widgets/Text/text_widget.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});
  static const String routeName = '/language';

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  var lang = LanguageController.to.getSelectedLanguage().split("_");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(LanguageController.to.getSelectedLanguage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Language",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacer.p20(),
            GetBuilder<LanguageController>(
                init: LanguageController.to,
                builder: (LanguageController controller) {
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(3, (index) {
                      final language = LanguageController.to.languages[index];

                      return LanguageButtonWidget(
                        name: language.values.first,
                        imageUrl: getButtonImages(index),
                        isSelected:
                            LanguageController.to.getSelectedLanguage() ==
                                language.keys.first,
                        onPressed: () {
                          if (language.keys.first.split("_").last !=
                              lang.last) {
                            lang = language.keys.first.split("_");

                            LanguageController.to.changeLanguage(
                                language: lang.first, dialect: lang.last);
                          }
                        },
                      );
                    }),
                  );
                }),
          ],
        ),
      ),
    );
  }

  String getButtonNames(int index) {
    switch (index) {
      case 0:
        return "English";
      case 1:
        return "Kurdish";
      case 2:
        return "Arabic";
      default:
        return "";
    }
  }

  String getButtonImages(int index) {
    switch (index) {
      case 0:
        return "assets/images/UK.png";
      case 1:
        return "assets/images/kurdish.png";
      case 2:
        return "assets/images/iraq.png";
      default:
        return "";
    }
  }
}

class LanguageButtonWidget extends StatelessWidget {
  const LanguageButtonWidget({
    super.key,
    required this.onPressed,
    required this.imageUrl,
    required this.name,
    this.isSelected = false,
  });
  final VoidCallback onPressed;
  final bool isSelected;
  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        width: (screenWidth(context) - 48) / 2,
        height: screenWidth(context) * 0.35,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorPalette.black,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageUrl,
              width: 35,
              height: 35,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: TextWidget(
                    name,
                    style: TextWidget.textStyleCurrent.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                  ),
                ),
                AppSpacer.p8(),
                Icon(
                  !isSelected
                      ? CupertinoIcons.circle
                      : CupertinoIcons.checkmark_circle_fill,
                  color:
                      !isSelected ? ColorPalette.greyText : ColorPalette.yellow,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
