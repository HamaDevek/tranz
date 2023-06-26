import 'package:flutter/material.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdminNotificationsPAge extends StatefulWidget {
  const AdminNotificationsPAge({super.key});
  static const String routeName = "/admin-notifications";

  @override
  State<AdminNotificationsPAge> createState() => _AdminNotificationsPAgeState();
}

class _AdminNotificationsPAgeState extends State<AdminNotificationsPAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Notifications",
      ),
      body: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            AppSpacer.p20(),
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) => AppSpacer.p16(),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ImageWidget(
                    imageUrl: "https://picsum.photos/200/300",
                    height: 50,
                    width: 50,
                    isCircle: true,
                    border: Border.all(
                      color: ColorPalette.whiteColor,
                      width: 2,
                    ),
                  ),
                  title: TextWidget(
                    "Notification Title",
                    style: TextWidget.textStyleCurrent.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.whiteColor,
                    ),
                  ),
                  subtitle: TextWidget(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit. ",
                    style: TextWidget.textStyleCurrent.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.whiteColor,
                    ),
                    maxLines: 2,
                  ),
                  trailing: TextWidget(
                    timeago.format(
                      DateTime.parse(
                        DateTime.now().toString(),
                      ),
                    ),
                    style: TextWidget.textStyleCurrent.copyWith(
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
