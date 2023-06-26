
import 'package:flutter/material.dart';

import '../../Theme/theme.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 16 / 9,
      child: Center(
        child: CircularProgressIndicator(
          color: ColorPalette.yellow,
          strokeWidth: 2,
        ),
      ),
    );
  }
}