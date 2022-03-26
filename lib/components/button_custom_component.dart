import 'package:flutter/material.dart';

class ButtonCustomComponent extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final GestureTapCallback? onPress;
  final double? height;

  const ButtonCustomComponent({
    Key? key,
    required this.child,
    required this.onPress,
    this.height,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: color ?? Theme.of(context).primaryColor,
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: height ?? 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
