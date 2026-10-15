import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class DemandProgress extends StatelessWidget {
  const DemandProgress({
    super.key,
    required this.steps,
    this.activeStepIndex = 0,
  }) : assert(activeStepIndex >= 0);

  final List<String> steps;
  final int activeStepIndex;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(steps.length, (index) {
        final isCurrent = index == activeStepIndex;
        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: index == 0 ? 0 : AppSpacing.tokenXs,
              end: index == steps.length - 1 ? 0 : AppSpacing.tokenXs,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: AppSpacing.tokenXs,
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? colors.primary.shade500
                        : colors.neutral.shade200,
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  steps[index],
                  variant: AppTextVariant.labelSmall,
                  textAlign: TextAlign.center,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: isCurrent
                        ? colors.primary.shade500
                        : colors.neutral.shade300,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
