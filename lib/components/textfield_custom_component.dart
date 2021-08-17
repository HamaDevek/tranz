import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trancehouse/services/theme_service.dart';

class TextfieldCustomComponent extends StatelessWidget {
  const TextfieldCustomComponent(
      {Key? key, required this.hintText, this.inputFormatters, this.controller})
      : super(key: key);
  final hintText, inputFormatters, controller;

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
                controller: controller,
                maxLength: 255,
                inputFormatters: inputFormatters,
                style: TextStyle(
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Colors.white,
                    fontSize: 20),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autocorrect: false,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 20),
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
