import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_typography.dart';

class SeeAllShipmentsLink extends StatelessWidget {
  const SeeAllShipmentsLink(
      {super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary.shade500;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: primary,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: AppText(
        label,
        variant: AppTextVariant.labelMedium,
        style: AppTypography.buyerMobile.label.toTextStyle(
          color: primary,
        ),
      ),
    );
  }
}
