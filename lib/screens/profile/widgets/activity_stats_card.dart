import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ActivityStat {
  const ActivityStat({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;
}

class ActivityStatsCard extends StatelessWidget {
  static const double height = 90;

  const ActivityStatsCard({
    super.key,
    required this.stats,
  }) : assert(stats.length == 3);

  final List<ActivityStat> stats;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final radius = BorderRadius.circular(AppRadius.token2Xl);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: ColoredBox(
          color: colors.primary.shade700,
          child: SizedBox(
            height: height,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                PositionedDirectional(
                  top: -100,
                  end: -80,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primary.shade500.withValues(alpha: .45),
                    ),
                  ),
                ),
                Row(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    for (var index = 0; index < stats.length; index++) ...<Widget>[
                      Expanded(child: _ActivityStatContent(stat: stats[index])),
                      if (index < stats.length - 1)
                        Container(
                          height: 44,
                          width: 1,
                          color: colors.neutral.shade100.withValues(
                            alpha: .14,
                          ),
                        ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityStatContent extends StatelessWidget {
  const _ActivityStatContent({required this.stat});

  final ActivityStat stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          stat.label,
          variant: AppTextVariant.bodySmall,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.bodySmall.toTextStyle(
            color: Colors.white.withValues(alpha: .75),
          ),
        ),
        const SizedBox(height: AppSpacing.token2Xs),
        AppText(
          stat.value,
          variant: AppTextVariant.titleLarge,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.h5.toTextStyle(
            color: stat.valueColor ?? Colors.white,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
