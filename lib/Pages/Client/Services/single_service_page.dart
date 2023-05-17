import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';
import '../../../Theme/theme.dart';
import '../../../Widgets/Buttons/order_now_button.dart';
import '../../../Widgets/Text/text_widget.dart';

class SingleServicePage extends StatefulWidget {
  const SingleServicePage({super.key});
  static const String routeName = "/single-service";

  @override
  State<SingleServicePage> createState() => _SingleServicePageState();
}

class _SingleServicePageState extends State<SingleServicePage> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        pageTitle: "Title Name",
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
            child: SvgPicture.asset("assets/icons/cart.svg"),
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
            const SingleArticleWidget(
              imageUrl: "https://picsum.photos/400/200",
              title: "New product unlocked: Blush",
              description:
                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
            ),
            AppSpacer.p20(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AspectRatio(
                aspectRatio: 16 / 8,
                child: Container(
                  color: ColorPalette.greyText,
                  child: const Center(
                    child: TextWidget(
                      "Video",
                    ),
                  ),
                ),
              ),
            ),
            AppSpacer.p32(),
          ],
        ),
      ),
      bottomNavigationBar: OrderNowButtonWidget(
        isLiked: ValueNotifier<bool>(_isLiked),
        orderNowPressed: () {},
        onLikeChanged: (value) async {
          _isLiked = value;
          print(_isLiked);
        },
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
  });
  final String imageUrl;
  final String title;
  final String description;

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
          child: TextWidget(
            description,
            style: TextWidget.textStyleCurrent.copyWith(
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
