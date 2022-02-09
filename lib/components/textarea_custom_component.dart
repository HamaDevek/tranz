import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/theme_service.dart';
import '../utils/extentions.dart';

class TextareaCustomComponent extends StatelessWidget {
  const TextareaCustomComponent(
      {Key? key, required this.hintText, this.controller})
      : super(key: key);
  final hintText, controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeService().isSavedDarkMode()
              ? Color(0xFF292D32)
              : Theme.of(context).accentColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              maxLength: 2000,
              style: TextStyle(
                  color: !ThemeService().isSavedDarkMode()
                      ? Color(0xFF1E272E)
                      : Colors.white,
                  fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                  fontSize: 20),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              autofocus: false,
              maxLines: null,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                ),
                border: InputBorder.none,
                counterText: "",
                contentPadding: EdgeInsets.all(16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
