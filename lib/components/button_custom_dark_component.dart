import 'package:flutter/material.dart';
import '../services/theme_service.dart';

class ButtonCustomDarkComponent extends StatelessWidget {
  final String? text;
  final bool? isSelected;
  final GestureTapCallback? onPress;
  final String? fontFamily;
  const ButtonCustomDarkComponent({
    Key? key,
    required this.text,
    required this.onPress,
    this.isSelected = false,
    this.fontFamily,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPress,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isSelected ?? false
                ? Border.all(
                    color: Theme.of(context).primaryColor,
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$text',
                  style: TextStyle(
                    color: !ThemeService().isSavedDarkMode()
                        ? const Color(0xFF1E272E)
                        : Colors.white,
                    fontFamily: fontFamily,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
