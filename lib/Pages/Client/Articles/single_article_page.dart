import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';
import '../../../Getx/Controllers/language_controller.dart';
import '../../../Models/blogs_model.dart';
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
  BlogsModel? blog;

  @override
  void initState() {
    super.initState();

    blog = Get.arguments as BlogsModel?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Blog",
      ),
      body: SingleChildScrollView(
        primary: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacer.p8(),
            SingleArticleWidget(
              imageUrl: blog?.images![0] ?? "",
              title: getText(
                  blog?.title ?? LanguagesModel(en: "", ar: "", ku: "")),
              date: blog?.updatedAt ?? DateTime.now(),
              description: getText(
                  blog?.description ?? LanguagesModel(en: "", ar: "", ku: "")),
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
              // allowFromNow: true,
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
        ),
      ],
    );
  }
}
