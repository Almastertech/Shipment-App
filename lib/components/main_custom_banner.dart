import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_text.dart';

class MainCustomBanner extends StatelessWidget {
  const MainCustomBanner({
    super.key,
    required this.onExplore,
    this.greeting = 'مرحباً بك في حصين 👋',
    this.title = 'مشترياتك محمية مع حصين',
    this.description =
        'عند الشراء من متجر شريك، تظهر شحنتك هنا تلقائيًا. محمية من لحظة الطلب حتى باب بيتك.',
    this.buttonLabel = 'استكشف المتاجر الشريكة',
  });

  final VoidCallback onExplore;
  final String greeting;
  final String title;
  final String description;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary.shade500;
    final textColor = AppColors.semantic.text.primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = (width * 0.55).clamp(215.0, 250.0).toDouble();
        final contentWidth = width * 0.64;
        final contentHeight = height - (AppSpacing.tokenL * 2);

        return ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.token2Xl),
          child: SizedBox(
            height: height,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                PositionedDirectional(
                  end: -width * 0.55,
                  top: -width * 0.25,
                  width: width * 1.55,
                  height: width * 1.55 / (1360 / 768),
                  child: Image.asset(
                    AppImages.bannerBackground,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.centerEnd,
                      end: AlignmentDirectional.centerStart,
                      colors: <Color>[
                        Colors.white.withValues(alpha: 0.02),
                        Colors.white.withValues(alpha: 0.16),
                        Colors.white.withValues(alpha: 0.62),
                      ],
                      stops: const <double>[0, 0.48, 1],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.tokenL),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: SizedBox(
                      width: contentWidth,
                      height: contentHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppText(
                            greeting,
                            variant: AppTextVariant.bodySmall,
                            textAlign: TextAlign.start,
                            style: AppTypography.buyerMobile.caption
                                .toTextStyle(color: primary),
                          ),
                          const SizedBox(height: AppSpacing.tokenXs),
                          AppText(
                            title,
                            variant: AppTextVariant.titleLarge,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.buyerMobile.h4
                                .toTextStyle(color: primary),
                          ),
                          const SizedBox(height: AppSpacing.tokenXs),
                          AppText(
                            description,
                            variant: AppTextVariant.bodySmall,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.buyerMobile.bodySmall
                                .toTextStyle(color: textColor),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: onExplore,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.tokenM,
                                vertical: AppSpacing.tokenS,
                              ),
                              minimumSize: const Size(0, 42),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadius.tokenFull,
                                ),
                              ),
                            ),
                            child: AppText(
                              buttonLabel,
                              variant: AppTextVariant.labelLarge,
                              style: AppTypography.buyerMobile.button
                                  .toTextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
