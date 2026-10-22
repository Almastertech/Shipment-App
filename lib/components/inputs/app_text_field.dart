import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.autovalidateMode,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.maxLength,
    this.maxLengthEnforcement,
    this.autofocus = false,
    this.onTapOutside,
    this.clearFocusOnTapOutside = true,
    this.textDirection,
    this.textAlign,
    this.style,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool autofocus;
  final TapRegionCallback? onTapOutside;
  final bool clearFocusOnTapOutside;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      textCapitalization: textCapitalization,
      autofillHints: autofillHints,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      textDirection: textDirection,
      textAlign: textAlign ?? TextAlign.start,
      style: style,
      onTapOutside: onTapOutside ??
          (clearFocusOnTapOutside
              ? (_) => FocusManager.instance.primaryFocus?.unfocus()
              : null),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
