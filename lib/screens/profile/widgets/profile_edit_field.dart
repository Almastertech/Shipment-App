import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../components/inputs/app_text_field.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ProfileEditField extends StatelessWidget {
  const ProfileEditField({
    super.key,
    required this.label,
    required this.controller,
    required this.textDirection,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final TextDirection textDirection;
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.tokenS),
          child: AppText(
            label,
            variant: AppTextVariant.labelMedium,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: AppTypography.buyerMobile.label.toTextStyle(
              color: AppColors.primitives.neutral.shade900,
            ),
          ),
        ),
        AppTextField(
          controller: controller,
          readOnly: readOnly,
          onChanged: onChanged,
          hintText: hintText,
          keyboardType: keyboardType,
          textDirection: textDirection,
          textAlign: TextAlign.right,
          style: AppTypography.buyerMobile.bodyMedium
              .toTextStyle(
                color: AppColors.primitives.neutral.shade900,
              )
              .copyWith(fontWeight: FontWeight.w500),
          validator: validator,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
