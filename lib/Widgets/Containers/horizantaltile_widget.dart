import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Theme/theme.dart';
import '../../Utility/utility.dart';
import '../Other/app_spacer.dart';
import '../Text/text_widget.dart';

enum OrderStatus {
  pending,
  accepted,
  rejected,
}

class HorizantalTileWidget extends StatelessWidget {
  const HorizantalTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.status,
    required this.onTap,
    this.cardColor = ColorPalette.whiteColor,
  });
  final String title;
  final String subtitle;
  final String date;
  final OrderStatus status;
  final Function() onTap;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(18),
      color: cardColor,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/lines.horizantal.png",
          ),
          ListTile(
            onTap: onTap,
            tileColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.circle_fill,
                  size: 8,
                  color: _getOrderStatus(),
                ),
                AppSpacer.p4(),
                TextWidget(
                  title,
                  style: TextWidget.textStyleCurrent.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.primary,
                  ),
                ),
              ],
            ),
            subtitle: TextWidget(
              subtitle,
              style: TextWidget.textStyleCurrent.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: ColorPalette.primaryLight,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "Ordered on",
                  style: TextWidget.textStyleCurrent.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: ColorPalette.primaryLight,
                  ),
                ),
                TextWidget(
                  dateTimeFormat(
                    date: date,
                    format: "dd.MM.yyyy hh:mm a",
                  ),
                  style: TextWidget.textStyleCurrent.copyWith(
                    fontSize: 12,
                    color: ColorPalette.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getOrderStatus() {
    switch (status) {
      case OrderStatus.pending:
        return ColorPalette.yellow;
      case OrderStatus.accepted:
        return ColorPalette.green;
      case OrderStatus.rejected:
        return ColorPalette.red;
      default:
        return ColorPalette.primary;
    }
  }
}
