import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import '../../../Getx/Controllers/client_controller.dart';
import '../../../Getx/Controllers/user_controller.dart';
import '../../../Models/services_model.dart';
import '../../../Widgets/Buttons/button_widget.dart';
import '../../../Widgets/Buttons/order_now_button.dart';
import '../../../Widgets/Modal/confirmation_modal.dart';
import '../../../Widgets/Text/text_widget.dart';
import '../../Auth/login_page.dart';
import 'products_cart_page.dart';

class ServicesCartPage extends StatefulWidget {
  const ServicesCartPage({super.key});
  static const routeName = '/service-cart-page';

  @override
  State<ServicesCartPage> createState() => _ServicesCartPageState();
}

class _ServicesCartPageState extends State<ServicesCartPage> {
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    // generateList();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ClientController.to.getLocalCartItems(cartType: CartType.service);
    });
    super.dispose();
  }

  int getTotalPrice() {
    int totalPrice = 0;
    for (var item in ClientController.to.cartServices) {
      item.copyWith(
        quantity: item.quantity,
      );
      totalPrice += item.price ?? 0 * item.quantity;
      // totalPrice += item.price! * item.quantity;
    }
    return totalPrice;
  }

  void _removeItem(int index, Service item) {
    animatedListKey.currentState!.removeItem(
      index,
      (context, animation) {
        return ScaleTransition(
          scale: animation,
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizeTransition(
              sizeFactor: animation,
              child: FadeTransition(
                opacity: animation,
                child: CartWidget(
                  cartType: CartType.service,
                  title: getText(
                      item.title ?? LanguagesModel(en: "", ar: "", ku: "")),
                  quantity: item.quantity,
                  price: item.price ?? 0,
                  onQuantityChanged: (newQuantity) {},
                ),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: const AppBarWidget(
            pageTitle: "Services Cart",
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacer.p20(),
                AnimatedList(
                  key: animatedListKey,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  initialItemCount: ClientController.to.cartServices.length,
                  itemBuilder: (context, index, animation) {
                    final item = ClientController.to.cartServices[index];
                    return SizeTransition(
                      sizeFactor: animation,
                      child: CartWidget(
                        cartType: CartType.service,
                        title: getText(item.title ??
                            LanguagesModel(en: "", ar: "", ku: "")),
                        imageUrl: item.images?.first ?? "",
                        quantity: item.quantity,
                        price: item.price ?? 0,
                        onRemoveService: () {
                          ClientController.to.removeItemFromCart(index,
                              cartType: CartType.service);
                          _removeItem(index, item);
                          getTotalPrice();
                          setState(() {});
                        },
                      ).directionalPadding(bottom: 16),
                    );
                  },
                ),
                if (ClientController.to.cartServices.isEmpty)
                  AspectRatio(
                    aspectRatio: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.shopping_cart,
                          color: ColorPalette.greyText,
                          size: 40,
                        ),
                        AppSpacer.p8(),
                        TextWidget(
                          "Your Cart is Empty",
                          style: TextWidget.textStyleCurrent.copyWith(
                            fontSize: 20,
                            color: ColorPalette.greyText,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (ClientController.to.cartServices.isNotEmpty) ...[
                UserController.to.isUserLoggedin()
                    ? OrderNowButtonWidgetWithTotalPrice(
                        orderNowPressed: () async {
                          final value = await ConfirmationDialogWidget.show(
                            context,
                            onConfirmed: () async {
                              Get.back(result: true);
                            },
                            bodyText:
                                "Are you sure you want to order this service?",
                          );
                          // print(value);
                          if (value == true) {
                            final res = await ClientController.to.orderService(
                              service: ClientController.to.cartServices
                                  .map((element) {
                                return {
                                  "service": element.id,
                                };
                              }).toList(),
                            );

                            if (res.isSuccess) {
                              ClientController.to
                                  .clearCart(cartType: CartType.service);
                              animatedListKey.currentState!.removeAllItems(
                                (context, animation) => const SizedBox(),
                                duration: const Duration(milliseconds: 300),
                              );
                            }
                          }
                        },
                        totalPrice: getTotalPrice(),
                      )
                    : ButtonWidget(
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
              ]
            ],
          ));
    });
  }
}
