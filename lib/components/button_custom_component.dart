import 'package:flutter/material.dart';

class ButtonCustomComponent extends StatelessWidget {
  final child;
  final color;
  final onPress;
  final height;
  const ButtonCustomComponent({
    Key? key,
    required Widget? this.child,
    required GestureTapCallback? this.onPress,
    double? this.height,
    Color? this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: color == null ? Theme.of(context).primaryColor : color,
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
