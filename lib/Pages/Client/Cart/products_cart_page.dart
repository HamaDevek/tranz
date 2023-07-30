import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';

import '../../../Models/product_model.dart';
import '../../../Utility/constants.dart';
import '../../../Widgets/Buttons/order_now_button.dart';
import '../../../Widgets/Text/text_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static const routeName = '/cart-page';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    generateList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int getTotalPrice() {
    int totalPrice = 0;
    for (var item in counterList) {
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
                  quantity: item.quantity,
                  price: item.price!,
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
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "My Cart",
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
                    initialItemCount: counterList.length,
                    itemBuilder: (context, index, animation) {
                      final item = counterList[index];
                      return SizeTransition(
                        sizeFactor: animation,
                        child: CartWidget(
                          quantity: item.quantity,
                          price: item.price!,
                          onQuantityChanged: (newQuantity) {
                            item.quantity = newQuantity.value;
                            if (item.quantity == 0) {
                              counterList.removeAt(index);
                              _removeItem(index, item);
                            }

                            getTotalPrice();
                            setState(() {});
                          },
                        ).directionalPadding(bottom: 16),
                      );
                    },
                  ),
                  if (counterList.isEmpty)
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
          if (counterList.isNotEmpty)
            OrderNowButtonWidgetWithTotalPrice(
              orderNowPressed: () {},
              totalPrice: getTotalPrice(),
            ),
        ],
      ),
    );
  }
}

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
    required this.quantity,
    this.price = 0,
    required this.onQuantityChanged,
  });
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
          const Expanded(
            child: ImageWidget(
              borderRadius: 0,
              width: double.infinity,
              imageUrl: "https://picsum.photos/400/200",
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
                          "Title Name",
                          style: TextWidget.textStyleCurrent.copyWith(
                            fontSize: 20,
                            color: ColorPalette.yellow,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                        AppSpacer.p2(),
                        TextWidget(
                          "Product",
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
