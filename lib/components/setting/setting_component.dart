import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../services/theme_service.dart';
import '../../utils/extentions.dart';

class SettingComponent extends StatelessWidget {
  const SettingComponent(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPress,
      this.isNumber})
      : super(key: key);
  final icon, text, onPress, isNumber;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPress,
        child: Container(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 'language.rtl'.tr.parseBool ? 0 : 16,
                    right: 'language.rtl'.tr.parseBool ? 16 : 0),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ThemeService().isSavedDarkMode()
                      ? Color(0xFF292D32)
                      : Colors.white,
                ),
                child: icon,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    child: Text(
                      text,
                      overflow: TextOverflow.fade,
                      textAlign: 'language.rtl'.tr.parseBool
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: !ThemeService().isSavedDarkMode()
                            ? Color(0xFF1E272E)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
