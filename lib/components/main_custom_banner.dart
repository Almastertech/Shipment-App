import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import '../l10n/app_localizations.dart';
import 'app_text.dart';
import 'buttons/primary_button.dart';

/// Compact branded banner that introduces Haseen's partner store network.
class MainCustomBanner extends StatelessWidget {
  const MainCustomBanner({super.key, required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.primitives;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height =
            (constraints.maxWidth * .64).clamp(158.0, 190.0).toDouble();

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
                    colors.primary.shade500,
                    colors.primary.shade700,
                  ],
                ),
              ),
              child: Stack(
                children: <Widget>[
                  PositionedDirectional(
                    end: -34,
                    top: -56,
                    child: Container(
                      width: 126,
                      height: 126,
                      decoration: BoxDecoration(
                        color: colors.primary.shade400.withValues(alpha: .34),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.tokenM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: colors.accent01.shade300,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.tokenM,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                AppImages.shieldCheck,
                                width: 17,
                                height: 17,
                                colorFilter: ColorFilter.mode(
                                  colors.neutral.shade900,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.tokenS),
                            Expanded(
                              child: AppText(
                                l10n.mainBannerTitle,
                                variant: AppTextVariant.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.buyerMobile.label
                                    .toTextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.tokenXs),
                        AppText(
                          l10n.mainBannerDescription,
                          variant: AppTextVariant.bodySmall,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.caption.toTextStyle(
                            color: Colors.white.withValues(alpha: .78),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: <Widget>[
                            AppText(
                              l10n.mainBannerPartnerCount,
                              variant: AppTextVariant.labelSmall,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.buyerMobile.caption
                                  .toTextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            const _PartnerStoreMarks(),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.tokenXs),
                        PrimaryButton(
                          label: l10n.mainBannerAction,
                          onPressed: onExplore,
                          iconOnTrailing: true,
                          icon: Icon(
                            Directionality.of(context) == TextDirection.rtl
                                ? Icons.chevron_left_rounded
                                : Icons.chevron_right_rounded,
                            size: 18,
                            color: colors.neutral.shade900,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.accent01.shade300,
                            foregroundColor: colors.neutral.shade900,
                            minimumSize: const Size(0, 32),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.tokenM,
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

class _PartnerStoreMarks extends StatelessWidget {
  const _PartnerStoreMarks();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return SizedBox(
      width: 55,
      height: 23,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          for (var index = 0; index < 3; index++)
            PositionedDirectional(
              start: index * 15.0,
              top: 0,
              child: Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  color: <Color>[
                    colors.neutral.shade100,
                    colors.accent01.shade300,
                    colors.neutral.shade300,
                  ][index],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                padding: const EdgeInsets.all(AppSpacing.token3Xs),
                child: SvgPicture.asset(
                  AppImages.shop,
                  colorFilter: ColorFilter.mode(
                    colors.primary.shade600,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
