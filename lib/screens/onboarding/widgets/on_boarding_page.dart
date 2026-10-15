
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
  const OnboardingPage({super.key, 
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
    final headingColor = AppColors.primitives.neutral.shade500;
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
    };

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          AppImages.image(page.imagePath),
          fit: BoxFit.cover,
          excludeFromSemantics: true,
        ),
        AppScaffold(
          backgroundColor: Colors.transparent,
          safeArea: true,
          padding: EdgeInsets.zero,
          dismissKeyboardOnTap: false,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.tokenL,
              AppSpacing.tokenM,
              AppSpacing.tokenL,
              AppSpacing.tokenS,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: AppSpacing.tokenXs + AppSpacing.token6Xl,
                ),
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
                  textAlign: TextAlign.end,
                  textDirection: Directionality.of(context),
                  maxLines: 3,
                ),
                const Spacer(),
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
                      minimumSize: const Size.fromHeight(44),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

