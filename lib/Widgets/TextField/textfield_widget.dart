import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Theme/theme.dart';
import '../Other/app_spacer.dart';
import '../Text/text_widget.dart';

class TextFieldWidget extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? headerText;
  final TextStyle? headerTextStyle;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String? prefixText;
  final String? hintText;
  final double? borderRadius;
  final TextInputType? keyboardType;
  final TextDirection? headerDirectionality;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextFieldValidationController? validationController;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? contentPadding;
  final bool hasBoredser;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintTextColor;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final FocusNode? parameterFocusNode;

  const TextFieldWidget({
    Key? key,
    this.validator,
    this.controller,
    this.headerText,
    this.headerTextStyle,
    this.inputFormatters,
    this.prefix,
    this.prefixText,
    this.hintText,
    this.suffix,
    this.borderRadius = 16,
    this.keyboardType,
    this.onChanged,
    this.headerDirectionality,
    this.validationController,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.constraints,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.hasBoredser = true,
    this.maxLength,
    this.fillColor,
    this.prefixIcon,
    this.onTap,
    this.onEditingComplete,
    this.parameterFocusNode,
    this.maxLines = 1,
    this.hintTextColor,
    this.minLines,
    this.borderColor,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool Function() callback;
  String? errorText;
  late TextEditingController controller;
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    callback = () {
      setState(() {});
      errorText = widget.validator?.call(controller.value.text);
      if (errorText != null && errorText!.isNotEmpty) {
        focusNode.requestFocus();
      }
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
    widget.validationController?.removeCallback(callback);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headerText != null) ...[
          Align(
            alignment:
                (widget.headerDirectionality ?? Directionality.of(context)) ==
                        TextDirection.rtl
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            child: TextWidget(
              widget.headerText!,
              style: widget.headerTextStyle ??
                  TextWidget.textStyleCurrent.copyWith(
                    color: ColorPalette.primary,
                    fontSize: 14,
                  ),
            ),
          ),
          AppSpacer.p8(),
        ],
        TextField(
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText,
          controller: controller,
          focusNode: widget.parameterFocusNode ?? focusNode,
          style: TextWidget.textStyleCurrent.copyWith(
            fontWeight: FontWeight.w400,
          ),
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          maxLength: widget.maxLength,
          onTap: widget.onTap,
          onEditingComplete: widget.onEditingComplete,
          decoration: InputDecoration(
            counterText: "",
            prefix: widget.prefix,
            prefixText: widget.prefixText,
            filled: true,
            fillColor: widget.fillColor ?? Colors.transparent,
            //prefixIcon: widget.prefix,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            constraints: widget.constraints,
            prefixStyle: TextWidget.textStyleCurrent.copyWith(),
            errorText: errorText,

            hintText: widget.hintText?.tr,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffix,

            hintStyle: TextWidget.textStyleCurrent.copyWith(
              color: widget.hintTextColor ?? ColorPalette.greyText,
              fontWeight: widget.hintTextColor != null
                  ? FontWeight.w400
                  : FontWeight.w500,
              fontSize: 14,
            ),
            contentPadding: widget.contentPadding,
            errorStyle: TextWidget.textStyleCurrent.copyWith(
              color: ColorPalette.red,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.hasBoredser
                      ? ColorPalette.red
                      : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.hasBoredser
                      ? widget.borderColor ?? ColorPalette.whiteColor
                      : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.hasBoredser
                      ? ColorPalette.yellow
                      : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.hasBoredser
                      ? widget.borderColor ?? ColorPalette.whiteColor
                      : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.hasBoredser
                      ? ColorPalette.red
                      : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
          ),
        ),
      ],
    );
  }
}

class TextFieldValidationController {
  static TextFieldValidationController instance =
      TextFieldValidationController();
  final List<bool Function()> _callbacks = [];

  addCallback(bool Function() callback) {
    _callbacks.add(callback);
  }

  removeCallback(VoidCallback callback) {
    _callbacks.remove(callback);
  }

  bool validate() {
    for (var callback in _callbacks) {
      final isValidated = callback();
      if (isValidated == false) {
        return false;
      }
    }
    return true;
  }
}
