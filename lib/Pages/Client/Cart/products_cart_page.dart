import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tranzhouse/Getx/Controllers/client_controller.dart';
import 'package:tranzhouse/Getx/Controllers/user_controller.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';

import '../../../Models/product_model.dart';
import '../../../Utility/constants.dart';
import '../../../Widgets/Buttons/button_widget.dart';
import '../../../Widgets/Buttons/order_now_button.dart';
import '../../../Widgets/Modal/confirmation_modal.dart';
import '../../../Widgets/Text/text_widget.dart';
import '../../Auth/login_page.dart';

class ProductsCartPage extends StatefulWidget {
  const ProductsCartPage({super.key});
  static const routeName = '/products-cart-page';

  @override
  State<ProductsCartPage> createState() => _ProductsCartPageState();
}

class _ProductsCartPageState extends State<ProductsCartPage> {
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    // generateList();

    // ClientController.to.getLocalCartProducts();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ClientController.to.getLocalCartItems(cartType: CartType.product);
    });
    // ClientController.to.getLocalCartProducts();

    super.dispose();
  }

  int getTotalPrice() {
    int totalPrice = 0;
    for (var item in ClientController.to.cartProducts) {
      item.copyWith(
        quantity: item.quantity,
      );
      totalPrice += item.price! * item.quantity;
      // totalPrice += item.price! * item.quantity;
    }
    return totalPrice;
  }

  void _removeItem(int index, ProductModel item) {
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
                  cartType: CartType.product,
                  title: getText(item.title ?? LanguagesModel()),
                  imageUrl: item.images?.first ?? "",
                  quantity: item.quantity,
                  price: item.price!,
                  onQuantityChanged: (newQuantity) {},
                ),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const AppBarWidget(
          pageTitle: "My Products Cart",
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacer.p20(),
                    AnimatedList(
                      key: animatedListKey,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      initialItemCount: ClientController.to.cartProducts.length,
                      itemBuilder: (context, index, animation) {
                        final item = ClientController.to.cartProducts[index];
                        // print("ITEM: ${item.toJson()}");
                        return SizeTransition(
                          sizeFactor: animation,
                          child: CartWidget(
                            cartType: CartType.product,
                            title: getText(item.title ?? LanguagesModel()),
                            imageUrl: item.images?.first ?? "",
                            quantity: item.quantity,
                            price: item.price!,
                            onQuantityChanged: (newQuantity) {
                              item.quantity = newQuantity.value;
                              if (item.quantity == 0) {
                                ClientController.to.removeItemFromCart(index,
                                    cartType: CartType.product);
                                _removeItem(index, item);
                              } else {
                                ClientController.to.updateItemInCart(index,
                                    cartType: CartType.product, item: item);
                              }

                              getTotalPrice();
                              setState(() {});
                            },
                          ).directionalPadding(bottom: 16),
                        );
                      },
                    ),
                    if (ClientController.to.cartProducts.isEmpty)
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
            ),
            UserController.to.isUserLoggedin()
                ? ClientController.to.cartProducts.isNotEmpty
                    ? OrderNowButtonWidgetWithTotalPrice(
                        orderNowPressed: () async {
                          final value = await ConfirmationDialogWidget.show(
                            context,
                            onConfirmed: () async {
                              Get.back(result: true);
                            },
                            bodyText:
                                "Are you sure you want to order this product?",
                          );
                          // print(value);
                          if (value == true) {
                            final res = await ClientController.to.orderProduct(
                              pruduct: ClientController.to.cartProducts
                                  .map((element) {
                                return {
                                  "product": element.id,
                                  "quantity": element.quantity,
                                };
                              }).toList(),
                            );

                            if (res.isSuccess) {
                              ClientController.to
                                  .clearCart(cartType: CartType.product);
                              animatedListKey.currentState!.removeAllItems(
                                (context, animation) => const SizedBox(),
                                duration: const Duration(milliseconds: 300),
                              );
                            }
                          }
                        },
                        totalPrice: getTotalPrice(),
                      )
                    : const SizedBox()
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
          ],
        ),
      );
    });
  }
}

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
    required this.cartType,
    this.title,
    this.imageUrl,
    this.quantity = 1,
    this.price = 0,
    required this.onQuantityChanged,
  });
  final CartType cartType;
  final String? title;
  final String? imageUrl;
  final int quantity;
  final int price;
  final Function(ValueNotifier<int> newQuantity) onQuantityChanged;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late ValueNotifier<int> currentQuantity;

  @override
  void initState() {
    super.initState();
    currentQuantity = ValueNotifier<int>(widget.quantity);
  }

  void _increment() {
    currentQuantity.value++;
    widget.onQuantityChanged(currentQuantity);
  }

  void _decrement() {
    if (currentQuantity.value > 0) {
      currentQuantity.value--;
      widget.onQuantityChanged(currentQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: screenWidth(context) * .5,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorPalette.primaryDark,
        borderRadius: BorderRadius.circular(12),
        boxShadow: boxShadows,
      ),
      child: Row(
        children: [
          Expanded(
            child: ImageWidget(
              borderRadius: 0,
              width: double.infinity,
              imageUrl: widget.imageUrl ?? "https://picsum.photos/400/200",
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: ColorPalette.primaryDark,
              ),
              child: ValueListenableBuilder(
                  valueListenable: currentQuantity,
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          widget.title ?? "",
                          style: TextWidget.textStyleCurrent.copyWith(
                            fontSize: 20,
                            color: ColorPalette.yellow,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                        AppSpacer.p2(),
                        TextWidget(
                          widget.cartType == CartType.service
                              ? "Service"
                              : "Product",
                          style: TextWidget.textStyleCurrent.copyWith(
                            fontSize: 16,
                            color: ColorPalette.greyText,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                        AppSpacer.p8(),
                        TextWidget(
                          NumberFormat.currency(
                            customPattern: "#,### IQD",
                            decimalDigits: 0,
                          ).format(
                            widget.price * currentQuantity.value,
                          ),
                          style: TextWidget.textStyleCurrent.copyWith(
                            fontSize: 18,
                            color: ColorPalette.whiteColor,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                        if (widget.cartType == CartType.product) ...[
                          AppSpacer.p8(),
                          Row(
                            children: [
                              InkWell(
                                onTap: _decrement,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: ColorPalette.greyText,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: ColorPalette.greyText,
                                    size: 15,
                                  ),
                                ),
                              ),
                              AppSpacer.p16(),
                              TextWidget(
                                currentQuantity.value.toString(),
                                style: TextWidget.textStyleCurrent.copyWith(
                                  fontSize: 18,
                                  color: ColorPalette.whiteColor,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                              AppSpacer.p16(),
                              InkWell(
                                onTap: _increment,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: ColorPalette.greyText,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: ColorPalette.greyText,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ).paddingAll(16);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

enum CartType {
  product,
  service,
}
