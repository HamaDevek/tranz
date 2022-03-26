import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeService().isSavedDarkMode()
              ? const Color(0xFF292D32)
              : Theme.of(context).colorScheme.secondary,
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
                        ? const Color(0xFF1E272E)
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
