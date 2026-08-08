import 'package:flutter/material.dart';

import 'spacing_widgets.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.keyBoardType,
    this.validator,
    this.hintText,
    this.textFieldTitle,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.radius,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.fillColor,
    this.borderColor,
    this.cursorColor,
    this.textStyle,
    this.hintTextStyle,
    this.suffixIconWidget,
    this.minLine = 1,
    this.labelStyle,
    this.label,
  });

  final String? textFieldTitle;
  final TextEditingController? controller;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? prefixIcon;
  final String? suffixIcon;
  final Widget? suffixIconWidget;
  final bool isPassword;
  final double? radius;
  final int? maxLines;
  final int? minLine;
  final void Function(String)? onFieldSubmitted;
  final Color? fillColor;
  final Color? borderColor;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelStyle;
  final String? label;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = !widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.textFieldTitle != null)
          Row(
            children: [
              Text(
                widget.textFieldTitle!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        if (widget.textFieldTitle != null) const HeightSpace(height: 3),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyBoardType,
          validator: widget.validator,
          maxLines: widget.maxLines,
          minLines: widget.minLine,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: widget.isPassword && !isPasswordVisible,
          obscuringCharacter: '●',

          // Remove the hardcoded Color(0xff94A3B8). If null, it uses textSelectionTheme
          cursorColor: widget.cursorColor,
          cursorWidth: 2,
          cursorErrorColor: Colors.red,
          style:
              widget.textStyle ??
              const TextStyle(color: Colors.white, fontSize: 16),

          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 14.0),
            hintText: widget.hintText ?? '',
            hintStyle: widget.hintTextStyle ?? const TextStyle(fontSize: 14.0),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 18.0,
            ),
            filled: true,
            // Remove Colors.white fallback. If null, uses the theme's fillColor
            fillColor: widget.fillColor,
            prefixIcon: widget.prefixIcon,
            suffixIcon:
                widget.suffixIconWidget ??
                (widget.isPassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      )
                    : widget.suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(widget.suffixIcon!),
                      )
                    : null),

            // Note: If you want rounded borders per-widget, keep these.
            // Otherwise, remove them entirely to let the theme handle borders.
            enabledBorder: widget.borderColor != null || widget.radius != null
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius ?? 20),
                    borderSide: BorderSide(
                      color: widget.borderColor ?? const Color(0xff2A2D3A),
                      width: 1,
                    ),
                  )
                : null, // Passing null forces it to use DarkTheme

            focusedBorder: widget.borderColor != null || widget.radius != null
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius ?? 20),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
