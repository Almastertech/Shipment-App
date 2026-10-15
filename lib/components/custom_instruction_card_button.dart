import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_text.dart';

class CustomInstructionCardButton extends StatelessWidget {
  const CustomInstructionCardButton({
    super.key,
    required this.onTap,
    this.title = 'تُحمى شحنتك تلقائيًا',
    this.description = 'تظهر هنا مع حالتها لحظة بلحظة.',
    this.stepLabel = 'الخطوة الثانية',
  });

  final VoidCallback? onTap;
  final String title;
  final String description;
  final String stepLabel;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final cardRadius = BorderRadius.circular(AppRadius.xl);

    return Semantics(
      button: onTap != null,
      label: '$title. $description. $stepLabel',
      child: Material(
        color: AppColors.semantic.background.secondary,
        borderRadius: cardRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: cardRadius,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.tokenM,
              vertical: AppSpacing.tokenS,
            ),
            child: SizedBox(
              height: 72,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 46,
                    height: 48,
                    decoration: BoxDecoration(
                      color: primary.shade500,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppImages.phoneIcon,
                      width: 22,
                      height: 22,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.tokenM),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppText(
                          title,
                          variant: AppTextVariant.titleSmall,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.h6
                              .toTextStyle(color: primary.shade500),
                        ),
                        const SizedBox(height: AppSpacing.tokenXs),
                        AppText(
                          description,
                          variant: AppTextVariant.bodySmall,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTypography.buyerMobile.bodySmall.toTextStyle(
                            color: AppColors.semantic.text.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.tokenM),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: primary.shade100,
                      borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.tokenS,
                        vertical: AppSpacing.tokenXs,
                      ),
                      child: AppText(
                        stepLabel,
                        variant: AppTextVariant.labelSmall,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.caption
                            .toTextStyle(color: primary.shade500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
