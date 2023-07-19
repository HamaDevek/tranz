import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Widgets/Containers/Image_gallery_widget.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';
import '../../../Models/services_model.dart';
import '../../../Theme/theme.dart';
import '../../../Utility/utility.dart';
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
  Service service = Service();
  @override
  void initState() {
    super.initState();
    service = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        pageTitle: "Service Details",
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
            // SingleArticleWidget(
            //   imageUrl: service.images?[0] ?? "https://picsum.photos/400/200",
            //   title: getText(service.title ?? LanguagesModel()),
            //   description: getText(service.description ?? LanguagesModel()),
            // ),
            ImageGalleryWidgetState(
              imagesUrl: service.images ?? [],
              title: getText(service.title ?? LanguagesModel()),
              description: getText(service.description ?? LanguagesModel()),
              date: DateTime.parse(
                  DateTime.now().subtract(const Duration(days: 1)).toString()),
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
