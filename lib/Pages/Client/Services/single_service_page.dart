import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Client/Cart/products_cart_page.dart';
import 'package:tranzhouse/Pages/Client/Cart/services_cart_page.dart';
import 'package:tranzhouse/Widgets/Buttons/button_widget.dart';
import 'package:tranzhouse/Widgets/Containers/Image_gallery_widget.dart';
import 'package:tranzhouse/Widgets/Modal/confirmation_modal.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import '../../../Getx/Controllers/client_controller.dart';
import '../../../Getx/Controllers/user_controller.dart';
import '../../../Models/services_model.dart';
import '../../../Theme/theme.dart';
import '../../../Utility/utility.dart';
import '../../../Widgets/Buttons/order_now_button.dart';
import '../../../Widgets/Text/text_widget.dart';
import '../../Auth/login_page.dart';

class SingleServicePage extends StatefulWidget {
  const SingleServicePage({super.key});
  static const String routeName = "/single-service";

  @override
  State<SingleServicePage> createState() => _SingleServicePageState();
}

class _SingleServicePageState extends State<SingleServicePage> {
  Service service = Service();
  @override
  void initState() {
    super.initState();
    service = Get.arguments as Service;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBarWidget(
          pageTitle: "Service Details",
          actions: [
            if (ClientController.to.isServicenCart(service.id!))
              TextWidget(
                "In Cart",
                style: TextWidget.textStyleCurrent.copyWith(
                  color: ColorPalette.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ).directionalPadding(end: 4),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorPalette.whiteColor,
                foregroundColor: ColorPalette.primary,
                shape: const CircleBorder(),
                minimumSize: const Size(35, 35),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: ClientController.to.isServicenCart(service.id!)
                  ? () {}
                  : () {
                      if (service.id != null) {
                        print(service.toJson());

                        Service copiedService = Service(
                          id: service.id,
                          title: service.title,
                          description: service.description,
                          images: service.images,
                          language: service.language,
                          contactEmail: service.contactEmail,
                          articles: service.articles,
                          category: service.category,
                          parent: service.parent,
                          status: service.status,
                          v: service.v,
                          price: service.price,
                          quantity: service.quantity,
                          updatedAt: service.updatedAt,
                        );
                        ClientController.to.addItemToCart(
                          copiedService,
                          cartType: CartType.service,
                        );
                        _showSnackBar();
                      }
                    },
              child: ClientController.to.isServicenCart(service.id!)
                  ? const Icon(
                      CupertinoIcons.check_mark,
                      size: 15,
                      color: ColorPalette.primary,
                    )
                  : SvgPicture.asset("assets/icons/cart.svg"),
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
              ImageGalleryWidgetState(
                imagesUrl: service.images ?? [],
                title: getText(
                    service.title ?? LanguagesModel(en: "", ar: "", ku: "")),
                description: getText(service.description ??
                    LanguagesModel(en: "", ar: "", ku: "")),
                // date: DateTime.parse(DateTime.now()
                //     .subtract(const Duration(days: 1))
                //     .toString()),
                price: service.price,
              ),
              // AppSpacer.p20(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: AspectRatio(
              //     aspectRatio: 16 / 8,
              //     child: Container(
              //       color: ColorPalette.greyText,
              //       child: const Center(
              //         child: TextWidget(
              //           "Video",
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              AppSpacer.p32(),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (UserController.to.isUserLoggedin())
              OrderNowButtonWidget(
                // isLiked: ValueNotifier<bool>(_isLiked),
                orderNowPressed: () async {
                  final value = await ConfirmationDialogWidget.show(
                    context,
                    onConfirmed: () async {
                      Get.back(result: true);
                    },
                    bodyText: "Are you sure you want to order this service?",
                  );
                  // print(value);
                  if (value == true) {
                    await ClientController.to.orderService(
                      service: [
                        {
                          "service": service.id,
                        }
                      ],
                    );
                  }
                },
              )
            else
              ButtonWidget(
                leading: const Icon(
                  CupertinoIcons.person_solid,
                  // color: ColorPalette.whiteColor,
                ),
                width: double.maxFinite,
                text: "Login to order",
                onPressed: () {
                  Get.toNamed(LoginPage.routeName, arguments: true);
                },
              ).paddingSymmetric(horizontal: 16, vertical: 32),
          ],
        ),
      );
    });
  }

  void _showSnackBar() {
    Get.rawSnackbar(
      messageText: TextWidget("Service added to cart",
          style: TextWidget.textStyleCurrent.copyWith(
            color: ColorPalette.primary,
            fontSize: 14,
          )),
      mainButton: ButtonWidget(
        backgroundColor: Colors.grey.shade300,
        textColor: ColorPalette.primary,
        fontSize: 12,
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        text: "View Cart",
        onPressed: () {
          Get.closeCurrentSnackbar();
          Get.toNamed(ServicesCartPage.routeName);
        },
      ).directionalPadding(end: 8),
      duration: const Duration(seconds: 20),
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: ColorPalette.whiteColor,
    );
  }
}
