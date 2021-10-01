import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/theme_service.dart';
import '../utils/extentions.dart';

class EmptyStateComponent extends StatelessWidget {
  EmptyStateComponent({Key? key, required this.icon, this.header, this.foorter})
      : super(key: key);
  final icon, header, foorter;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Icon(
                        icon,
                        size: 60,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(16),
                      child: Text(
                        header ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily:
                              'language.rtl'.tr.parseBool ? "Rabar" : "",
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: !ThemeService().isSavedDarkMode()
                              ? Color(0xFF1E272E)
                              : Colors.white,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        foorter ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily:
                              'language.rtl'.tr.parseBool ? "Rabar" : "",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: !ThemeService().isSavedDarkMode()
                              ? Color(0xFF1E272E)
                              : Colors.white,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
