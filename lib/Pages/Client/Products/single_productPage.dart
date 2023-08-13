import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Getx/Controllers/user_controller.dart';
import 'package:tranzhouse/Models/product_model.dart';
import 'package:tranzhouse/Pages/Auth/login_page.dart';
import 'package:tranzhouse/Pages/Client/Cart/products_cart_page.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Containers/Image_gallery_widget.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';
import '../../../Getx/Controllers/client_controller.dart';
import '../../../Models/services_model.dart';
import '../../../Theme/theme.dart';
import '../../../Widgets/Buttons/button_widget.dart';
import '../../../Widgets/Buttons/order_now_button.dart';
import '../../../Widgets/Modal/confirmation_modal.dart';
import '../../../Widgets/Text/text_widget.dart';

class SingleProductPage extends StatefulWidget {
  const SingleProductPage({super.key});
  static const String routeName = "/single-product";

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  ProductModel? product;

  @override
  void initState() {
    super.initState();
    product = Get.arguments as ProductModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        pageTitle: getText(product?.title ?? LanguagesModel(en: "",
                  ar: "",
                  ku: "")),
        actions: [
          Obx(() {
            if (ClientController.to.isProductInCart(product!.id!)) {
              return TextWidget(
                "In Cart",
                style: TextWidget.textStyleCurrent.copyWith(
                  color: ColorPalette.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ).directionalPadding(end: 4);
            }
            return const SizedBox();
          }),
          Obx(() {
            return TextButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorPalette.whiteColor,
                foregroundColor: ColorPalette.primary,
                shape: const CircleBorder(),
                minimumSize: const Size(35, 35),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: ClientController.to.isProductInCart(product!.id!)
                  ? () {
                      print(product?.toJson());
                    }
                  : () {
                      if (product?.id != null) {
                        print(product?.toJson());
                        // copy product into another object with changes in main product when changes made in copied one

                        ProductModel productModel = ProductModel(
                          id: product?.id,
                          language: product?.language,
                          status: product?.status,
                          title: product?.title,
                          price: product?.price,
                          category: product?.category,
                          description: product?.description,
                          images: product?.images,
                          links: product?.links,
                          v: product?.v,
                          quantity: product?.quantity ?? 1,
                        );
                        ClientController.to.addItemToCart(productModel,
                            cartType: CartType.product);
                        // Get.toNamed(ProductsCartPage.routeName);

                        _showSnackBar();
                        // ClientController.to.getLocalCartProducts();
                      }
                    },
              child: ClientController.to.isProductInCart(product!.id!)
                  ? const Icon(
                      CupertinoIcons.check_mark,
                      size: 15,
                      color: ColorPalette.primary,
                    )
                  : SvgPicture.asset("assets/icons/cart.svg"),
            );
          }),
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
              imagesUrl: product?.images != null
                  ? product!.images!.where((element) {
                      return element.urlType == 'image';
                    }).toList()
                  : [],
              category:
                  getTitlesProduct(product?.category ?? ProductCategory()),
              price: product?.price??0,
              title: getText(
                product?.title ?? LanguagesModel(en: "",
                  ar: "",
                  ku: ""),
              ),
              description: getText(
                product?.description ?? LanguagesModel(en: "",
                  ar: "",
                  ku: ""),
              ),
            ),
            AppSpacer.p32(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Column(
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
                    bodyText: "Are you sure you want to order this product?",
                  );
                  // print(value);
                  if (value == true) {
                    await ClientController.to.orderProduct(
                      pruduct: [
                        {
                          "product": product?.id,
                          "quantity": product?.quantity,
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
                text: " Login to order",
                onPressed: () {
                  Get.toNamed(LoginPage.routeName, arguments: true);
                },
              ).paddingSymmetric(horizontal: 16, vertical: 32),
          ],
        );
      }),
    );
  }

  void _showSnackBar() {
    Get.rawSnackbar(
      messageText: TextWidget("Product added to cart",
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
          Get.toNamed(ProductsCartPage.routeName);
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
