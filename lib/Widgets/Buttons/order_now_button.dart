import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Theme/theme.dart';
import '../../Utility/utility.dart';
import '../Other/app_spacer.dart';
import '../Text/text_widget.dart';

class OrderNowButtonWidget extends StatelessWidget {
  const OrderNowButtonWidget({
    super.key,
    required this.orderNowPressed,
    required this.onLikeChanged,
    // this.isLiked = false,
    required this.isLiked,
  });
  final VoidCallback orderNowPressed;
  // final bool isLiked;
  final Future Function(bool value) onLikeChanged;
  final ValueNotifier<bool> isLiked;

  @override
  Widget build(BuildContext context) {
    // ValueNotifier<bool> isLikedValue = ValueNotifier<bool>(false);
    return UnconstrainedBox(
      child: Container(
        width: screenWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          color: ColorPalette.primaryDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: isLiked,
                  builder: (context, value, child) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: ColorPalette.whiteColor,
                        foregroundColor: ColorPalette.primary,
                        shape: const CircleBorder(),
                        minimumSize: const Size(35, 35),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () async {
                        isLiked.value = !isLiked.value;
                        await onLikeChanged(isLiked.value);
                      },
                      child: Icon(
                        isLiked.value
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: ColorPalette.primary,
                        size: 20,
                      ),
                    );
                  },
                ),
                AppSpacer.p16(),
                Expanded(
                  child: GestureDetector(
                    onTap: orderNowPressed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: ColorPalette.primary,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: ColorPalette.greyText,
                          width: .5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/cart.svg",
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(
                              ColorPalette.yellow,
                              BlendMode.srcIn,
                            ),
                          ),
                          const TextWidget(
                            "Order Now",
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom +
                      MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
