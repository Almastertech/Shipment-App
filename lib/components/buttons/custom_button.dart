import 'package:flutter/material.dart';

import 'primary_button.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final Widget? icon;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      semanticLabel: semanticLabel,
    );
  }
}
