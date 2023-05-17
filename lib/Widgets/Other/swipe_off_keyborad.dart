import 'package:flutter/material.dart';

class SwipeOffKeyborad extends StatelessWidget {
  const SwipeOffKeyborad({
    super.key,
    required this.child,
    this.heightOfWidgetsAboveKeyboard,
    required this.ctx,
  });
  final Widget child;
  final BuildContext ctx;
  final dynamic heightOfWidgetsAboveKeyboard;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (PointerMoveEvent pointer) {
        disKeyboard(pointer, ctx, heightOfWidgetsAboveKeyboard ?? 0);
      },
      child: child,
    );
  }

  void disKeyboard(PointerMoveEvent pointer, BuildContext context,
      dynamic heightOfWidgetsAboveKeyboard) {
    double insets =
        MediaQuery.of(context).viewInsets.bottom + heightOfWidgetsAboveKeyboard;
    double screenHeight = MediaQuery.of(context).size.height;
    double position = pointer.position.dy;
    double keyboardHeight = screenHeight - insets;
    if (position > keyboardHeight && insets > 0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
