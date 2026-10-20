import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_typography.dart';

class RequestDetailsSectionTitle extends StatelessWidget {
  const RequestDetailsSectionTitle(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) => AppText(title,
      variant: AppTextVariant.titleMedium,
      textAlign: TextAlign.start,
      style: AppTypography.buyerMobile.h6
          .toTextStyle(color: AppColors.primitives.neutral.shade900));
}
