import 'package:flutter/material.dart';

import 'app_text_field.dart';

class CustomTextFieldNormal extends StatelessWidget {
  const CustomTextFieldNormal({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.textInputAction,
    this.onSubmitted,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      hintText: hintText,
      prefixIcon: prefixIcon,
      enabled: enabled,
    );
  }
}
