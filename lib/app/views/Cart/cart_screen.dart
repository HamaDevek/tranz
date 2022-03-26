import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../app/controllers/cart_controller.dart';
import '../../../components/empty_state_component.dart';
import '../../../components/cart/cart_item_component.dart';
import '../../../components/cart/cart_total_contract_component.dart';
import '../../../components/no_glow_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController _cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    _cartController.getCartInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => _cartController.cart.isEmpty
                  ? EmptyStateComponent(
                      icon: Iconsax.bag_2,
                      header: 'cart.empty.head'.tr,
                      foorter: 'cart.empty.footer'.tr,
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: NoGlowComponent(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Obx(() => ListView.builder(
                                    itemBuilder: (_, index) {
                                      return CartItemComponent(
                                        item: _cartController.cart[index],
                                      );
                                    },
                                    itemCount: _cartController.cart.length,
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 210,
                        ),
                      ],
                    ),
            ),
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.4),
                    spreadRadius: 6,
                    blurRadius: 7,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              'language.rtl'.tr.parseBool
                                  ? Iconsax.arrow_right_3
                                  : Iconsax.arrow_left_2,
                            )),
                        Expanded(
                          child: Text(
                            'cart'.tr,
                            textAlign: 'language.rtl'.tr.parseBool
                                ? TextAlign.left
                                : TextAlign.right,
                            style: TextStyle(
                              fontFamily:
                                  'language.rtl'.tr.parseBool ? "Rabar" : "",
                              fontSize: 24,
                              color: !ThemeService().isSavedDarkMode()
                                  ? const Color(0xFF1E272E)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => _cartController.cart.isEmpty
                  ? Container()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [CartTotalComponent()],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
