import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tranzhouse/Utility/utility.dart';
import '../../../Theme/theme.dart';
import '../../../Widgets/Other/app_spacer.dart';
import '../../../Widgets/Text/text_widget.dart';

class NavigationBarButton extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
/*  final String image;*/
  final String icon;
  final String selectedIcon;
  final bool hasSelected;
  const NavigationBarButton(
      {Key? key,
      required this.onTap,
      required this.name,
      /*required this.image,*/ required this.hasSelected,
      required this.icon,
      required this.selectedIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            alignment: AlignmentDirectional.centerStart,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            height: 4,
            width: hasSelected ? screenWidth(context) * .2 : 0,
            decoration: const BoxDecoration(
              color: ColorPalette.yellow,
              // borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: hasSelected
                      ? SvgPicture.asset(
                          key: const ValueKey('selected'),
                          selectedIcon,
                          height: 18,
                          width: 18,
                        )
                      : SvgPicture.asset(
                          key: const ValueKey('unselected'),
                          icon,
                          height: 18,
                          width: 18,
                        ),
                ),
                if (hasSelected) AppSpacer.p8(),
                AnimatedCrossFade(
                  alignment: AlignmentDirectional.centerStart,
                  crossFadeState: hasSelected
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 150),
                  reverseDuration: const Duration(milliseconds: 150),
                  firstChild: FittedBox(
                    child: TextWidget(
                      name,
                      style: TextWidget.textStyleCurrent.copyWith(
                        fontSize: 14,
                        color: hasSelected
                            ? ColorPalette.yellow
                            : ColorPalette.whiteColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  secondChild: const SizedBox(
                    height: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
