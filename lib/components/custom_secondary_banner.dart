import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_text.dart';
import 'buttons/primary_button.dart';

/// Compact protection information banner shown near the end of the home feed.
class CustomSecondaryBanner extends StatelessWidget {
  const CustomSecondaryBanner({
    super.key,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = math
            .max(82.0, constraints.maxWidth * .21)
            .clamp(82.0, 104.0)
            .toDouble();

        return ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.token2Xl),
          child: SizedBox(
            height: height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors: <Color>[
                    colors.primary.shade600,
                    colors.primary.shade700
                  ],
                ),
              ),
              child: Stack(
                children: <Widget>[
                  PositionedDirectional(
                    end: -38,
                    top: -54,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: colors.primary.shade500.withValues(alpha: .45),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.tokenM,
                      vertical: AppSpacing.tokenS,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              AppText(
                                title,
                                variant: AppTextVariant.titleSmall,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.buyerMobile.label
                                    .toTextStyle(color: Colors.white),
                              ),
                              AppText(
                                description,
                                variant: AppTextVariant.bodySmall,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.buyerMobile.caption
                                    .toTextStyle(
                                  color: Colors.white.withValues(alpha: .78),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.tokenS),
                        PrimaryButton(
                          label: actionLabel,
                          onPressed: onAction,
                          fullWidth: false,
                          iconOnTrailing: true,
                          icon: Icon(
                            Icons.chevron_right_rounded,
                            size: 18,
                            color: colors.neutral.shade900,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.accent01.shade300,
                            foregroundColor: colors.neutral.shade900,
                            minimumSize: const Size(0, 36),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.tokenS,
                            ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            elevation: 0,
                            shape: const StadiumBorder(),
                            textStyle: AppTypography.buyerMobile.labelSmall
                                .toTextStyle(color: colors.neutral.shade900),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
