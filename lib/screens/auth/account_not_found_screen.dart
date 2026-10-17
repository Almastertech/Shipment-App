import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../../l10n/app_localizations.dart';

class AccountNotFoundScreen extends StatelessWidget {
  const AccountNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primary = AppColors.primitives.primary;
    final neutral = AppColors.primitives.neutral;
    final yellow = AppColors.primitives.accent01;
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
                primary.shade900.withValues(alpha: .35),
                primary.shade900,
              ],
            ),
          ),
        ),
        AppScaffold(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          body: Column(
            children: [
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: neutral.shade100,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.token2Xl),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.tokenL,
                  AppSpacing.token5Xl,
                  AppSpacing.tokenL,
                  AppSpacing.tokenL,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: yellow.shade300,
                          borderRadius: BorderRadius.circular(AppRadius.tokenL),
                        ),
                        padding: const EdgeInsets.all(AppSpacing.tokenM),
                        child: SvgPicture.asset(
                          AppImages.search,
                          colorFilter: ColorFilter.mode(
                            primary.shade900,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    AppText(
                      l10n.accountNotFoundTitle,
                      variant: AppTextVariant.headlineSmall,
                      textAlign: TextAlign.center,
                      style: AppTypography.buyerMobile.h2.toTextStyle(
                        color: primary.shade900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenS),
                    AppText(
                      l10n.accountNotFoundBody,
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.center,
                      style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                        color: neutral.shade600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    _ContactOption(
                      icon: Icons.phone_iphone_rounded,
                      label: l10n.accountNotFoundPhone,
                      onTap: () => context.go(
                        AppRoutes.login,
                        extra: 'phone',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenS),
                    _ContactOption(
                      icon: Icons.mail_outline_rounded,
                      label: l10n.accountNotFoundEmail,
                      onTap: () => context.go(
                        AppRoutes.login,
                        extra: 'email',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    PrimaryButton(
                      label: l10n.accountNotFoundTryAgain,
                      onPressed: () => context.go(AppRoutes.loginMethod),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        backgroundColor: primary.shade500,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.token2Xl),
                        ),
                        textStyle: AppTypography.buyerMobile.button.toTextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactOption extends StatelessWidget {
  const _ContactOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final neutral = AppColors.primitives.neutral;
    return Material(
      color: neutral.shade200,
      borderRadius: BorderRadius.circular(AppRadius.tokenXl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.tokenXl),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.tokenM),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.primitives.primary.shade500,
              ),
              const SizedBox(width: AppSpacing.tokenM),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.bodyMedium,
                  style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                    color: neutral.shade800,
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: neutral.shade600),
            ],
          ),
        ),
      ),
    );
  }
}
