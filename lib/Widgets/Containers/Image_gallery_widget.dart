import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';

import '../../Theme/theme.dart';
import '../../Utility/utility.dart';
import '../Other/app_spacer.dart';
import '../Other/image_widget.dart';
import '../Text/text_widget.dart';

class ImageGalleryWidgetState extends StatefulWidget {
  const ImageGalleryWidgetState({
    super.key,
    required this.imagesUrl,
    required this.title,
    required this.description,
    this.category,
    this.price,
    this.date,
  });
  final List<String> imagesUrl;
  final String title;
  final String description;
  final String? category;
  final String? price;
  final DateTime? date;

  @override
  State<ImageGalleryWidgetState> createState() =>
      _ImageGalleryWidgetStateState();
}

class _ImageGalleryWidgetStateState extends State<ImageGalleryWidgetState> {
  late String selectedUrl;
  final List<GlobalKey> keys = <GlobalKey>[];

  @override
  void initState() {
    super.initState();
    selectedUrl = widget.imagesUrl[0];
    updateKeys();
  }

  void updateKeys() {
    keys.clear();
    for (int i = 0; i < widget.imagesUrl.length; i++) {
      keys.add(GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: Stack(
            children: [
              ImageWidget(
                imageUrl: selectedUrl,
                borderRadius: 0,
              ),
              GestureDetector(
                // onTap: () {
                //   ShowSingleImageDialog.showImage(
                //     ctx,
                //     imageUrl: selectedUrl,
                //   );
                //   print("object");
                // },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.centerStart,
                      end: AlignmentDirectional.centerEnd,
                      colors: [
                        Colors.black.withOpacity(.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.imagesUrl.length > 1)
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: List.generate(widget.imagesUrl.length, (index) {
                      return Padding(
                        key: keys[index],
                        padding: EdgeInsets.only(
                            bottom:
                                index == widget.imagesUrl.length - 1 ? 0 : 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedUrl = widget.imagesUrl[index];
                              scrollToSelectedContent(
                                expansionTileKey: keys[index],
                                alignment: .75,
                              );
                            });
                          },
                          child: ImageWidget(
                            imageUrl: widget.imagesUrl[index],
                            height: screenWidth(context) * .15,
                            width: screenWidth(context) * .15,
                            borderRadius: 10,
                            border: Border.all(
                              color: ColorPalette.whiteColor,
                              width: 1,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),
        AppSpacer.p16(),
        if (widget.category != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextWidget(
              widget.category ?? "",
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextWidget(
                  widget.title,
                  style: TextWidget.textStyleCurrent.copyWith(
                    color: ColorPalette.yellow,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                ),
              ),
              if (widget.price != null)
                TextWidget(
                  NumberFormat.currency(
                    customPattern: "###,###,###,### IQD",
                    decimalDigits: 0,
                  ).format(int.parse(widget.price!)),
                  style: TextWidget.textStyleCurrent.copyWith(
                    color: ColorPalette.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              if (widget.date != null)
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Ordered On:",
                        style: TextWidget.textStyleCurrent.copyWith(
                          color: ColorPalette.greyText,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      WidgetSpan(child: AppSpacer.p4()),
                      TextSpan(
                        text: dateTimeFormat(
                            date: widget.date.toString(), format: "dd.MM.yyyy"),
                        style: TextWidget.textStyleCurrent.copyWith(
                          color: ColorPalette.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        AppSpacer.p8(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: HtmlWidget(
            widget.description,
            textStyle: TextWidget.textStyleCurrent.copyWith(
              color: ColorPalette.greyText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
