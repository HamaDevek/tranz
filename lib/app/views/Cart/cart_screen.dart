import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trancehouse/components/cart/cart_empty_state_component.dart';
import 'package:trancehouse/components/cart/cart_total_contract.dart';
import 'package:trancehouse/services/theme_service.dart';
import 'package:trancehouse/utils/extentions.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isEm = !false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            isEm
                ? CartEmptyStateComponent()
                : Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        height: 210,
                      ),
                    ],
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
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              'cart'.tr,
                              textAlign: 'language.rtl'.tr.parseBool
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style: TextStyle(
                                fontFamily:
                                    'language.rtl'.tr.parseBool ? "Rabar" : "",
                                fontSize: 24,
                                color: !ThemeService().isSavedDarkMode()
                                    ? Color(0xFF1E272E)
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              'language.rtl'.tr.parseBool
                                  ? Iconsax.arrow_left_2
                                  : Iconsax.arrow_right_3,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            isEm
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [CartTotalComponent()],
                  ),
          ],
        ),
      ),
    );
  }
}
