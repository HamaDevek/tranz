import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/controllers/cart_controller.dart';
import '../../components/button_custom_component.dart';
import '../../services/theme_service.dart';
import '../../utils/extentions.dart';

class CartTotalComponent extends StatefulWidget {
  const CartTotalComponent({Key? key}) : super(key: key);

  @override
  _CartTotalComponentState createState() => _CartTotalComponentState();
}

class _CartTotalComponentState extends State<CartTotalComponent> {
  final CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
            spreadRadius: 6,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width - 32,
            color: ThemeService().isSavedDarkMode()
                ? const Color(0xFF222F3E)
                : Theme.of(context).colorScheme.secondary,
            margin: const EdgeInsets.only(bottom: 8),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'total'.tr,
                      textAlign: 'language.rtl'.tr.parseBool
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        fontFamily:
                            'language.rtl'.tr.parseBool ? "Rabar" : "",
                        fontSize: 20,
                        color: !ThemeService().isSavedDarkMode()
                            ? const Color(0xFF1E272E)
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      child: Text(
                        '${_cartController.total.value.toInt().parseToCurrency} ' +
                            'IQD'.tr,
                        textAlign: !'language.rtl'.tr.parseBool
                            ? TextAlign.right
                            : TextAlign.left,
                        style: TextStyle(
                          fontFamily:
                              'language.rtl'.tr.parseBool ? "Rabar" : "",
                          fontSize: 20,
                          color: !ThemeService().isSavedDarkMode()
                              ? const Color(0xFF1E272E)
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ButtonCustomComponent(
              onPress: () {
                Get.toNamed('/finish-cart');
              },
              child: Text(
                'finish.transaction'.tr,
                style: TextStyle(
                  fontSize: 20,
                  color: const Color(0xFF1E272E),
                  fontFamily: 'language.rtl'.tr.parseBool ? 'Rabar' : '',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
