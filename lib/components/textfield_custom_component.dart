import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/theme_service.dart';
import '../utils/extentions.dart';

class TextfieldCustomComponent extends StatelessWidget {
  const TextfieldCustomComponent(
      {Key? key,
      required this.hintText,
      this.inputFormatters,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.keyboardType,
      this.readOnly})
      : super(key: key);
  final hintText,
      inputFormatters,
      controller,
      prefixIcon,
      suffixIcon,
      keyboardType,
      readOnly,
      onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeService().isSavedDarkMode()
              ? Color(0xFF292D32)
              : Theme.of(context).accentColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onTap: onTap,
                readOnly: readOnly ?? false,
                controller: controller,
                maxLength: 255,
                inputFormatters: inputFormatters,
                style: TextStyle(
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Colors.white,
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 20),
                keyboardType: keyboardType ?? TextInputType.text,
                textInputAction: TextInputAction.done,
                autocorrect: false,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                  ),
                  border: InputBorder.none,
                  counterText: "",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
