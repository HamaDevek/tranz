import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';
import '../../../Getx/Controllers/language_controller.dart';
import '../../../Theme/theme.dart';
import '../../../Widgets/Text/text_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class SingleArticlePage extends StatefulWidget {
  const SingleArticlePage({super.key});
  static const String routeName = "/single-article";

  @override
  State<SingleArticlePage> createState() => _SingleArticlePageState();
}

class _SingleArticlePageState extends State<SingleArticlePage> {
  late List arguments;
  late String? title;
  late String? description;
  late String? imageUrl;

  @override
  void initState() {
    super.initState();
    arguments = Get.arguments;
    title = arguments[0];
    description = arguments[1];
    imageUrl = arguments[2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        pageTitle: "Article",
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: ColorPalette.whiteColor,
              foregroundColor: ColorPalette.primary,
              shape: const CircleBorder(),
              minimumSize: const Size(35, 35),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            child: const Icon(
              CupertinoIcons.bookmark,
              size: 15,
            ),
          ),
          AppSpacer.p16(),
        ],
      ),
      body: SingleChildScrollView(
        primary: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacer.p8(),
            SingleArticleWidget(
              imageUrl: imageUrl ?? "https://picsum.photos/400/200",
              title: title ?? "Title",
              date: DateTime.parse("2022-10-17T09:29:12.000000Z"),
              description: description ?? "Description",
            ),
            AppSpacer.p32(),
          ],
        ),
      ),
    );
  }
}

class SingleArticleWidget extends StatelessWidget {
  const SingleArticleWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
  });
  final String imageUrl;
  final String title;
  final String description;
  final DateTime date;

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
                imageUrl: imageUrl,
                borderRadius: 0,
              ),
              Container(
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
              )
            ],
          ),
        ),
        AppSpacer.p16(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextWidget(
            timeago.format(
              date,
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
            ),
            maxLines: 2,
          ),
        ),
        AppSpacer.p8(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: HtmlWidget(
            description,
            textStyle: TextWidget.textStyleCurrent.copyWith(
              color: ColorPalette.greyText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          // child: TextWidget(
          //   description,
          //   style: TextWidget.textStyleCurrent.copyWith(
          //     color: ColorPalette.greyText,
          //     fontSize: 14,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
        ),
      ],
    );
  }
}
