import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';
import '../../../Theme/theme.dart';
import '../../../Widgets/Buttons/order_now_button.dart';
import '../../../Widgets/Text/text_widget.dart';

class SingleProductPage extends StatefulWidget {
  const SingleProductPage({super.key});
  static const String routeName = "/single-product";

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        pageTitle: "Product Name",
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
            SinglePruductWidget(
              ctx: context,
              imageUrl: const [
                "https://picsum.photos/100/200",
                "https://picsum.photos/200/200",
                "https://picsum.photos/300/200",
                "https://picsum.photos/400/200",
                "https://picsum.photos/500/200",
                "https://picsum.photos/600/200",
                "https://picsum.photos/700/200",
              ],
              title: "Title Name",
              category: "Category Name",
              description:
                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
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

class SinglePruductWidget extends StatelessWidget {
  const SinglePruductWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.category,
    required this.ctx,
  });
  final List<String> imageUrl;
  final String title;
  final String description;
  final String category;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    String selectedUrl = imageUrl[0];
    final List<GlobalKey> keys = <GlobalKey>[];
    for (int i = 0; i < imageUrl.length; i++) {
      keys.add(GlobalKey());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: StatefulBuilder(builder: (context, setState) {
            return Stack(
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
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: List.generate(imageUrl.length, (index) {
                      return Padding(
                        key: keys[index],
                        padding: EdgeInsets.only(
                            bottom: index == imageUrl.length - 1 ? 0 : 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedUrl = imageUrl[index];
                              scrollToSelectedContent(
                                expansionTileKey: keys[index],
                                alignment: .8,
                              );
                            });
                          },
                          child: ImageWidget(
                            imageUrl: imageUrl[index],
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
            );
          }),
        ),
        AppSpacer.p16(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextWidget(
            category,
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextWidget(
                  title,
                  style: TextWidget.textStyleCurrent.copyWith(
                    color: ColorPalette.yellow,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                ),
              ),
              TextWidget(
                "\$18",
                style: TextWidget.textStyleCurrent.copyWith(
                  color: ColorPalette.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ],
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

class ShowSingleImageDialog extends StatelessWidget {
  const ShowSingleImageDialog({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  static showImage(
    BuildContext context, {
    required String imageUrl,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(.7),
      builder: (context) {
        return ShowSingleImageDialog(
          imageUrl: imageUrl,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(0),
      content: Builder(builder: (context) {
        return SizedBox(
            width: screenWidth(context),
            child: AspectRatio(
              aspectRatio: 1,
              child: ImageWidget(
                imageUrl: imageUrl,
                borderRadius: 0,
              ),
            ));
      }),
    );
  }
}
