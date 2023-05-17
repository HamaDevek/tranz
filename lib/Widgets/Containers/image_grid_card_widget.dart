import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Getx/Controllers/language_controller.dart';
import '../../Theme/theme.dart';
import '../Other/app_spacer.dart';
import '../Other/image_widget.dart';
import '../Text/text_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class ImageGridCardWidget extends StatelessWidget {
  const ImageGridCardWidget({
    super.key,
    required this.imageUrl,
    required this.price,
    required this.title,
    this.category,
    this.isForArticle = false,
    this.date,
    required this.onTap,
  });
  final String imageUrl;
  final String title;
  final String? category;
  final DateTime? date;
  final int price;
  final bool isForArticle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: ColorPalette.black,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ImageWidget(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    borderRadius: 0,
                  ),
                  if (!isForArticle)
                    UnconstrainedBox(
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xe016191d),
                        ),
                        child: FittedBox(
                          child: TextWidget(
                            NumberFormat.currency(
                              symbol: "IQD",
                              decimalDigits: 0,
                              customPattern: "#,###IQD",
                            ).format(price),
                            style: TextWidget.textStyleCurrent.copyWith(
                              color: ColorPalette.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            AppSpacer.p16(),
            if (isForArticle)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextWidget(
                  timeago.format(
                    date!,
                    locale: LanguageController().getSelectedLanguage(),
                    allowFromNow: true,
                  ),
                  style: TextWidget.textStyleCurrent.copyWith(
                    color: ColorPalette.greyText,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextWidget(
                title,
                style: TextWidget.textStyleCurrent.copyWith(
                  color: ColorPalette.yellow,
                  fontSize: 14,
                ),
                maxLines: 2,
              ),
            ),
            if (!isForArticle)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextWidget(
                  "$category",
                  style: TextWidget.textStyleCurrent.copyWith(
                    color: ColorPalette.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                ),
              ),
            AppSpacer.p16(),
          ],
        ),
      ),
    );
  }
}
