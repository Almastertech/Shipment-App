import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
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

    return Container(
      padding: const EdgeInsets.all(AppSpacing.tokenM),
      decoration: BoxDecoration(
        color: colors.neutral.shade200,
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppText(
            title,
            variant: AppTextVariant.titleLarge,
            textAlign: TextAlign.start,
            style: AppTypography.buyerMobile.h4.toTextStyle(
              color: colors.primary.shade500,
            ),
          ),
          const SizedBox(height: AppSpacing.tokenM),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(steps.length, (index) {
              final isComplete = index < activeStepIndex;
              final isCurrent = index == activeStepIndex;

              return Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 32,
                      child: Row(
                        children: <Widget>[
                          _TimelineNode(
                            isComplete: isComplete,
                            isCurrent: isCurrent,
                          ),
                          if (index < steps.length - 1)
                            Expanded(
                              child: Container(
                                height: 3,
                                color: index < activeStepIndex
                                    ? colors.primary.shade500
                                    : colors.primary.shade300,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenS),
                    AppText(
                      steps[index],
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                        color: isCurrent
                            ? colors.primary.shade500
                            : colors.neutral.shade400,
                      ),
                    ),
                    if (dates[index].isNotEmpty) ...<Widget>[
                      const SizedBox(height: AppSpacing.tokenXs),
                      AppText(
                        dates[index],
                        variant: AppTextVariant.labelSmall,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                          color: colors.neutral.shade400,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),
          ),
        ],
      ),
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
    final fill = isComplete
        ? colors.primary.shade500
        : isCurrent
            ? colors.primary.shade500
            : colors.primary.shade300;

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCurrent ? colors.neutral.shade200 : fill,
        shape: BoxShape.circle,
        border: isCurrent
            ? Border.all(color: colors.primary.shade500, width: 2)
            : null,
      ),
      child: isComplete
          ? Icon(Icons.check_rounded, size: 18, color: colors.neutral.shade100)
          : isCurrent
              ? Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: colors.primary.shade500,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: colors.neutral.shade100, width: 2),
                  ),
                )
              : null,
    );
  }
}
