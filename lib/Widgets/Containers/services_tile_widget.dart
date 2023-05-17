import 'package:flutter/material.dart';
import '../../Theme/theme.dart';
import '../../Utility/utility.dart';
import '../Other/image_widget.dart';
import '../Text/text_widget.dart';

class ServicesTileWidget extends StatelessWidget {
  const ServicesTileWidget({
    super.key,
    this.imageUrl,
    this.title,
    this.description,
    required this.onTap,
    this.isGrid = false,
  });
  final String? imageUrl;
  final String? title;
  final String? description;
  final Function() onTap;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: screenWidth(context),
        height: screenWidth(context) * .35,
        child: Stack(
          children: [
            ImageWidget(
              borderRadius: 16,
              imageUrl: "$imageUrl",
              width: screenWidth(context),
            ),
            Container(
              width: isGrid ? screenWidth(context) * .48 : screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment:
                    isGrid ? MainAxisAlignment.start : MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    "$title",
                    style: TextWidget.textStyleCurrent.copyWith(
                      color: ColorPalette.yellow,
                    ),
                  ),
                  SizedBox(
                    width: isGrid ? null : screenWidth(context) * .7,
                    child: TextWidget(
                      "$description",
                      style: TextWidget.textStyleCurrent.copyWith(
                        color: ColorPalette.whiteColor,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
