import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ShipmentTimelineCard extends StatelessWidget {
  const ShipmentTimelineCard({
    super.key,
    required this.title,
    required this.steps,
    required this.dates,
    required this.activeStepIndex,
  })  : assert(steps.length > 1),
        assert(steps.length == dates.length),
        assert(activeStepIndex >= 0 && activeStepIndex < steps.length);

  final String title;
  final List<String> steps;
  final List<String> dates;
  final int activeStepIndex;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppText(
          title,
          variant: AppTextVariant.titleLarge,
          textAlign: TextAlign.start,
          style: AppTypography.buyerMobile.h4.toTextStyle(
            color: colors.neutral.shade900,
          ),
        ),
        const SizedBox(height: AppSpacing.tokenM),
        for (var index = 0; index < steps.length; index++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 32,
                child: Column(
                  children: <Widget>[
                    _TimelineNode(
                      isComplete: index < activeStepIndex,
                      isCurrent: index == activeStepIndex,
                    ),
                    if (index < steps.length - 1)
                      Container(
                        width: 2,
                        height: 34,
                        color: index < activeStepIndex
                            ? colors.primary.shade500
                            : colors.neutral.shade300,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.tokenM),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.tokenL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppText(
                        steps[index],
                        variant: AppTextVariant.titleSmall,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.label.toTextStyle(
                          color: index == activeStepIndex
                              ? colors.neutral.shade900
                              : index < activeStepIndex
                                  ? colors.neutral.shade800
                                  : colors.neutral.shade500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.token2Xs),
                      AppText(
                        dates[index],
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                          color: index == activeStepIndex
                              ? colors.primary.shade500
                              : colors.neutral.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _TimelineNode extends StatelessWidget {
  const _TimelineNode({required this.isComplete, required this.isCurrent});

  final bool isComplete;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final fill = isCurrent
        ? colors.accent01.shade300
        : isComplete
            ? colors.primary.shade500
            : colors.neutral.shade200;

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: isCurrent
            ? Border.all(color: colors.primary.shade500, width: 2)
            : null,
      ),
      child: isComplete
          ? Icon(Icons.check_rounded, size: 18, color: colors.neutral.shade100)
          : isCurrent
              ? Icon(
                  Icons.inventory_2_outlined,
                  size: 17,
                  color: colors.neutral.shade900,
                )
              : null,
    );
  }
}
