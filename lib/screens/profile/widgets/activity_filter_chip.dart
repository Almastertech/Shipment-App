import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_typography.dart';

class ActivityFilterChip extends StatelessWidget {
  const ActivityFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final borderColor = selected
        ? Colors.transparent
        : colors.neutral.shade300;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Material(
        color: selected ? colors.accent01.shade300 : Colors.white,
        shape: StadiumBorder(side: BorderSide(color: borderColor)),
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: SizedBox(
            height: selected ? 36 : 38,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: AppText(
                  label,
                  variant: AppTextVariant.labelMedium,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: AppTypography.buyerMobile.label.toTextStyle(
                    color: selected
                        ? colors.neutral.shade900
                        : colors.neutral.shade900,
                  ).copyWith(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
