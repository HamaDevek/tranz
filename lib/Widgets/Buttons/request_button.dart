import 'package:flutter/material.dart';

import '../../Theme/theme.dart';
import '../Other/app_spacer.dart';
import '../Text/text_widget.dart';

class RequestButtonWidget extends StatefulWidget {
  final Future Function() onPressed;
  final String text;
  final Color color;
  final Color? disabledColor;
  final bool disabled;
  final Color textColor;
  final double? width;
  final double height;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? fontSize;
  final double? borderRadius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final bool hasBoredser;

  const RequestButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = ColorPalette.yellow,
    this.textColor = ColorPalette.primary,
    this.width,
    this.height = 48,
    this.leadingIcon,
    this.trailingIcon,
    this.disabledColor,
    this.disabled = false,
    this.fontSize = 16,
    this.borderRadius = 20,
    this.hasBoredser = false,
    this.verticalPadding = 8,
    this.horizontalPadding = 16,
  }) : super(key: key);

  @override
  State<RequestButtonWidget> createState() => _RequestButtonWidgetState();
}

class _RequestButtonWidgetState extends State<RequestButtonWidget> {
  bool _isLoading = false;
  bool? _isDone;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius!),
      ),
      child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: widget.disabled
                ? widget.disabledColor ?? ColorPalette.primary
                : widget.color,
            backgroundColor: widget.disabled
                ? ColorPalette.greyText
                : _isDone == true
                    ? ColorPalette.green
                    : _isDone == false
                        ? null
                        : widget.color,
            textStyle: TextWidget.textStyleCurrent.copyWith(
              color: widget.textColor,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: widget.hasBoredser
                    ? ColorPalette.greyText
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding!,
                vertical: widget.verticalPadding!),
          ),
          /* highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),*/
          onPressed: !widget.disabled
              ? () async {
                  if (_isLoading) {
                    return;
                  }
                  _isLoading = true;
                  setState(() {});
                  final result = await widget.onPressed();
                  if (result is bool) {
                    _isDone = result;
                    setState(() {});
                    Future.delayed(const Duration(seconds: 2), () {
                      _isDone = null;
                      if (mounted) {
                        setState(() {});
                      }
                    });
                  }
                  _isLoading = false;
                  setState(() {});
                }
              : null,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            /* transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },*/
            child: _isLoading
                ? UnconstrainedBox(
                    child: SizedBox(
                      height: widget.height / 2,
                      width: widget.height / 2,
                      child: CircularProgressIndicator(
                        color: widget.textColor,
                        strokeWidth: 1,
                      ),
                    ),
                  )
                : _isDone == null
                    ? Center(
                        widthFactor: 1,
                        child: FittedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.leadingIcon != null) ...[
                                widget.leadingIcon!,
                                AppSpacer.p8()
                              ],
                              TextWidget(
                                widget.text,
                                style: TextWidget.textStyleCurrent.copyWith(
                                  fontSize: widget.fontSize,
                                  color: widget.textColor,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                              if (widget.trailingIcon != null) ...[
                                AppSpacer.p8(),
                                widget.trailingIcon!
                              ],
                            ],
                          ),
                        ),
                      )
                    : _isDone == true
                        ? const Icon(Icons.check,
                            color: ColorPalette.whiteColor)
                        : const Icon(Icons.warning_rounded,
                            color: ColorPalette.whiteColor),
          )),
    );
  }
}
