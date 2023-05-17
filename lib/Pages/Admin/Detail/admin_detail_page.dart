import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Admin/Detail/reject_bottomsheet.dart';
import 'package:tranzhouse/Widgets/Buttons/request_button.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';

import '../../../Theme/theme.dart';
import '../../../Utility/utility.dart';
import '../../../Widgets/Other/app_spacer.dart';
import '../../../Widgets/Other/image_widget.dart';
import '../../../Widgets/Text/text_widget.dart';

class AmdinOrderDetailPage extends StatefulWidget {
  const AmdinOrderDetailPage({super.key});
  static const String routeName = "/admin-order-detail";

  @override
  State<AmdinOrderDetailPage> createState() => _AmdinOrderDetailPageState();
}

class _AmdinOrderDetailPageState extends State<AmdinOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Order Details",
      ),
      body: SingleChildScrollView(
        primary: false,
        child: Column(
          children: [
            AppSpacer.p20(),
            AdminOrderDetailWidget(
              imageUrl: const [
                "https://picsum.photos/100/200",
                "https://picsum.photos/200/200",
                "https://picsum.photos/300/200",
                "https://picsum.photos/400/200",
                "https://picsum.photos/500/200",
                "https://picsum.photos/600/200",
                "https://picsum.photos/700/200",
              ],
              title: "Order Name",
              description:
                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
              category: "Category",
              date: DateTime.parse(DateTime.now()
                      .subtract(const Duration(days: 10))
                      .toString())
                  .toString(),
              ctx: context,
            ),
            AppSpacer.p20(),
          ],
        ),
      ),
      bottomNavigationBar: UnconstrainedBox(
        child: Container(
          width: screenWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: const BoxDecoration(
            color: ColorPalette.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: RequestButtonWidget(
                      height: screenWidth(context) * .1,
                      verticalPadding: 0,
                      color: ColorPalette.red,
                      textColor: ColorPalette.whiteColor,
                      text: "Decline",
                      onPressed: () async {
                        DeclineBottomsheetWidget.show(
                          onDeclinePressed: (note) async {
                            await Future.delayed(
                              const Duration(milliseconds: 500),
                              () {},
                            );
                            print(note);
                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                  AppSpacer.p16(),
                  Expanded(
                    child: RequestButtonWidget(
                      height: screenWidth(context) * .1,
                      verticalPadding: 0,
                      color: ColorPalette.green,
                      textColor: ColorPalette.primary,
                      text: "Accept",
                      onPressed: () async {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminOrderDetailWidget extends StatelessWidget {
  const AdminOrderDetailWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.category,
    required this.ctx,
    required this.date,
  });
  final List<String> imageUrl;
  final String title;
  final String description;
  final String category;
  final String date;
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
                                alignment: .4,
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
                "Ordered on",
                style: TextWidget.textStyleCurrent.copyWith(
                  color: ColorPalette.greyText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              AppSpacer.p4(),
              TextWidget(
                dateTimeFormat(
                  date: date,
                  format: "dd.MM.yyyy",
                ),
                style: TextWidget.textStyleCurrent.copyWith(
                  color: ColorPalette.whiteColor,
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
