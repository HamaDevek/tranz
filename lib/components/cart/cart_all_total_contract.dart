import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/controllers/cart_controller.dart';
import '../../components/button_custom_component.dart';
import '../../services/theme_service.dart';
import '../../utils/extentions.dart';

class CartAllTotalComponent extends StatefulWidget {
  final GestureTapCallback? onPress;

  const CartAllTotalComponent({Key? key, required this.onPress})
      : super(key: key);

  @override
  _CartAllTotalComponentState createState() => _CartAllTotalComponentState();
}

class _CartAllTotalComponentState extends State<CartAllTotalComponent> {
  final CartController _cartController = Get.put(CartController());

  _CartAllTotalComponentState();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
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
                        fontSize: 16,
                        color: !ThemeService().isSavedDarkMode()
                            ? const Color(0xFF1E272E)
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _cartController.total.value.toInt().parseToCurrency,
                      textAlign: !'language.rtl'.tr.parseBool
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        fontFamily:
                            'language.rtl'.tr.parseBool ? "Rabar" : "",
                        fontSize: 16,
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
                      'transportation.fee'.tr,
                      textAlign: 'language.rtl'.tr.parseBool
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        fontFamily:
                            'language.rtl'.tr.parseBool ? "Rabar" : "",
                        fontSize: 16,
                        color: !ThemeService().isSavedDarkMode()
                            ? const Color(0xFF1E272E)
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _cartController.fee.value.toInt().parseToCurrency,
                      textAlign: !'language.rtl'.tr.parseBool
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        fontFamily:
                            'language.rtl'.tr.parseBool ? "Rabar" : "",
                        fontSize: 16,
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
                        fontSize: 24,
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
                        (_cartController.total.value.toInt() +
                                _cartController.fee.value.toInt())
                            .parseToCurrency,
                        textAlign: !'language.rtl'.tr.parseBool
                            ? TextAlign.right
                            : TextAlign.left,
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
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ButtonCustomComponent(
              onPress: widget.onPress,
              child: Obx(() => Text(
                    _cartController.isLoading.value
                        ? 'sending'.tr
                        : 'cart.buy'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color(0xFF1E272E),
                      fontFamily: 'language.rtl'.tr.parseBool ? 'Rabar' : '',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
