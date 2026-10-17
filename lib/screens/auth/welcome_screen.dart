import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../core/session/session_manager.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primary = AppColors.primitives.primary;
    final yellow = AppColors.primitives.accent01;
    final neutral = AppColors.primitives.neutral;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(AppImages.splash, fit: BoxFit.cover),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primary.shade900.withValues(alpha: .58),
                primary.shade900,
              ],
            ),
          ),
        ),
        AppScaffold(
          safeArea: false,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(AppSpacing.tokenL),
          body: Column(
            children: [
              const SizedBox(height: AppSpacing.token10Xl),
              AppText(
                l10n.welcomeTitle,
                variant: AppTextVariant.headlineMedium,
                textAlign: TextAlign.center,
                style: AppTypography.buyerMobile.h2.toTextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.tokenM),
              AppText(
                l10n.welcomeDescription,
                variant: AppTextVariant.bodyMedium,
                textAlign: TextAlign.center,
                style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                  color: neutral.shade200,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(AppSpacing.tokenM),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(AppRadius.token2Xl),
                  border: Border.all(color: Colors.white.withValues(alpha: .2)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.tokenL),
                      child: Image.asset(
                        AppImages.onboardingProtection,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.tokenM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            l10n.welcomeProductTitle,
                            variant: AppTextVariant.titleSmall,
                            style: AppTypography.buyerMobile.label.toTextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.tokenS),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: yellow.shade100,
                              borderRadius: BorderRadius.circular(
                                AppRadius.tokenFull,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.tokenS,
                                vertical: AppSpacing.token2Xs,
                              ),
                              child: AppText(
                                l10n.welcomeProtectionActive,
                                variant: AppTextVariant.labelSmall,
                                style:
                                    AppTypography.buyerMobile.label.toTextStyle(
                                  color: primary.shade800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.token2Xl),
              PrimaryButton(
                label: l10n.welcomeContinue,
                onPressed: () async {
                  await getIt<SessionManager>().startGuestSession();
                  if (context.mounted) context.go(AppRoutes.home);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  backgroundColor: yellow.shade300,
                  foregroundColor: primary.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                  ),
                  textStyle: AppTypography.buyerMobile.button.toTextStyle(
                    color: primary.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
