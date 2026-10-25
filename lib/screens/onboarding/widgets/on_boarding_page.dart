import 'package:flutter/material.dart';
import 'package:shipments/components/app_scaffold.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/components/buttons/primary_button.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/onboarding/data/on_boarding_data.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.page,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  final OnboardingPageData page;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final actionColor = AppColors.primitives.primary.shade500;
    final foregroundColor = AppColors.primitives.neutral.shade100;
    final headingColor = AppColors.primitives.neutral.shade900;
    final subtitleColor = AppColors.primitives.neutral.shade600;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final titleCopy = switch (page.title) {
      OnboardingTitle.protection => (
          l10n.onboardingProtectionLead,
          l10n.onboardingProtectionHighlight,
          l10n.onboardingProtectionTail,
        ),
      OnboardingTitle.tracking => (
          l10n.onboardingTrackingLead,
          l10n.onboardingTrackingHighlight,
          l10n.onboardingTrackingTail,
        ),
      OnboardingTitle.claim => (
          '',
          l10n.onboardingClaimTitle,
          '',
        ),
    };
    final subtitle = switch (page.title) {
      OnboardingTitle.protection => l10n.onboardingProtectionSubtitle,
      OnboardingTitle.tracking => l10n.onboardingTrackingSubtitle,
      OnboardingTitle.claim => l10n.onboardingClaimSubtitle,
    };

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        AppScaffold(
          backgroundColor: AppColors.primitives.neutral.shade100,
          safeArea: true,
          padding: EdgeInsets.zero,
          dismissKeyboardOnTap: false,
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenL,
              AppSpacing.tokenS,
              AppSpacing.tokenL,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: AppSpacing.token2Xl),
                const _OnboardingDiamonds(),
                const SizedBox(height: AppSpacing.tokenS),
                AppText.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(text: titleCopy.$1),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: titleCopy.$2,
                        style: TextStyle(color: actionColor),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(text: titleCopy.$3),
                    ],
                  ),
                  variant: AppTextVariant.headlineLarge,
                  style: AppTypography.buyerMobile.display.toTextStyle(
                    color: headingColor,
                  ),
                  textAlign: TextAlign.start,
                  textDirection: Directionality.of(context),
                  maxLines: isRtl ? 2 : 3,
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  subtitle,
                  variant: AppTextVariant.bodyMedium,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: subtitleColor,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          AppSpacing.tokenXs,
                          AppSpacing.tokenS,
                          AppSpacing.tokenXs,
                          AppSpacing.tokenM,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.primitives.primary.shade100,
                            borderRadius:
                                BorderRadius.circular(AppRadius.token2Xl),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.tokenS),
                            child: Image.asset(
                              AppImages.image(page.imagePath),
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                PrimaryButton(
                  label:
                      isLastPage ? l10n.onboardingStart : l10n.onboardingNext,
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: actionColor,
                    foregroundColor: foregroundColor,
                    minimumSize: const Size.fromHeight(52),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                    ),
                    textStyle: AppTypography.buyerMobile.button.toTextStyle(
                      color: foregroundColor,
                    ),
                  ),
                ),
                if (!isLastPage) ...<Widget>[
                  const SizedBox(height: AppSpacing.tokenXs),
                  TextButton(
                    onPressed: onSkip,
                    style: TextButton.styleFrom(
                      foregroundColor: actionColor,
                      minimumSize: const Size.fromHeight(40),
                      padding: EdgeInsets.zero,
                      textStyle: AppTypography.buyerMobile.label.toTextStyle(
                        color: actionColor,
                      ),
                    ),
                    child: AppText(
                      l10n.onboardingSkip,
                      variant: AppTextVariant.labelLarge,
                      style: AppTypography.buyerMobile.label.toTextStyle(
                        color: actionColor,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.tokenXs),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingDiamonds extends StatelessWidget {
  const _OnboardingDiamonds();

  @override
  Widget build(BuildContext context) {
    final colors = <Color>[
      AppColors.primitives.accent01.shade300,
      AppColors.primitives.primary.shade200,
      AppColors.primitives.accent01.shade300,
      AppColors.primitives.neutral.shade300,
      AppColors.primitives.primary.shade300,
      AppColors.primitives.accent01.shade300,
      AppColors.primitives.neutral.shade400,
    ];
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final color in colors)
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 5),
              child: Transform.rotate(
                angle: .785,
                child: Container(width: 8, height: 8, color: color),
              ),
            ),
        ],
      ),
    );
  }
}
