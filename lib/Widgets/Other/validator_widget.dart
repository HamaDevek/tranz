import 'package:flutter/material.dart';
import 'package:tranzhouse/Theme/theme.dart';

import '../Text/text_widget.dart';
import '../TextField/textfield_widget.dart';
import 'app_spacer.dart';

class ValidatorWidget extends StatefulWidget {
  final String? Function() validator;
  final Widget Function(bool Function())? builder;
  final Widget? child;
  final EdgeInsetsGeometry? errorTextPadding;
  final TextFieldValidationController? validationController;

  const ValidatorWidget(
      {Key? key,
      required this.validator,
      this.child,
      this.builder,
      this.errorTextPadding,
      this.validationController})
      : super(key: key);

  @override
  State<ValidatorWidget> createState() => _ValidatorWidgetState();
}

class _ValidatorWidgetState extends State<ValidatorWidget> {
  late bool Function() callback;
  String? errorText;

  @override
  void initState() {
    super.initState();

    callback = () {
      setState(() {});
      errorText = widget.validator.call();
      return errorText == null;
    };
    if (widget.validationController != null) {
      widget.validationController?.addCallback(callback);
    } else {
      TextFieldValidationController.instance.addCallback(callback);
    }
  }

  @override
  void dispose() {
    super.dispose();
    TextFieldValidationController.instance.removeCallback(callback);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.builder != null) widget.builder!(callback),
          if (widget.child != null) widget.child!,
          if (errorText != null && errorText!.isNotEmpty) ...[
            AppSpacer.p8(),
            /*  Icon(
              Icons.error,
              color: Colors.red,
              size: 16,
            ),*/
            Padding(
              padding: widget.errorTextPadding != null
                  ? widget.errorTextPadding!
                  : const EdgeInsets.symmetric(horizontal: 16),
              child: TextWidget(
                errorText!,
                style: TextWidget.textStyleCurrent.copyWith(
                  color: ColorPalette.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
