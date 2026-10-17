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
    final yellow = AppColors.primitives.accent01.shade300;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppImages.splash,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primary.shade900.withValues(alpha: .34),
                primary.shade900.withValues(alpha: .76),
              ],
            ),
          ),
        ),
        AppScaffold(
          safeArea: false,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                flex: 4,
                child: SafeArea(
                  bottom: false,
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.tokenL),
                      child: IconButton(
                        onPressed: () => context.go(AppRoutes.loginMethod),
                        icon: Icon(
                          Directionality.of(context) == TextDirection.rtl
                              ? Icons.arrow_forward_rounded
                              : Icons.arrow_back_rounded,
                        ),
                        color: Colors.white,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: .2),
                          fixedSize: const Size(40, 40),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: neutral.shade100,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(AppRadius.token2Xl),
                          ),
                        ),
                        child: SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              AppSpacing.tokenL,
                              AppSpacing.token5Xl,
                              AppSpacing.tokenL,
                              AppSpacing.tokenL,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppText(
                                  l10n.accountNotFoundTitle,
                                  variant: AppTextVariant.headlineMedium,
                                  textAlign: TextAlign.start,
                                  style:
                                      AppTypography.buyerMobile.h2.toTextStyle(
                                    color: neutral.shade900,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.tokenS),
                                AppText(
                                  l10n.accountNotFoundBody,
                                  variant: AppTextVariant.bodySmall,
                                  textAlign: TextAlign.start,
                                  style: AppTypography.buyerMobile.bodySmall
                                      .toTextStyle(color: neutral.shade700),
                                ),
                                const SizedBox(height: AppSpacing.token3Xl),
                                _AdviceRow(
                                  icon: Icons.mail_outline_rounded,
                                  label: l10n.accountNotFoundCheckEmail,
                                ),
                                const SizedBox(height: AppSpacing.tokenS),
                                _AdviceRow(
                                  icon: Icons.refresh_rounded,
                                  label: l10n.accountNotFoundTryOtherMethod,
                                  onTap: () =>
                                      context.go(AppRoutes.loginMethod),
                                ),
                                const Spacer(),
                                PrimaryButton(
                                  label: l10n.accountNotFoundTryAgain,
                                  onPressed: () =>
                                      context.go(AppRoutes.loginMethod),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    backgroundColor: primary.shade500,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.tokenFull,
                                      ),
                                    ),
                                    textStyle: AppTypography.buyerMobile.button
                                        .toTextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.tokenS),
                                PrimaryButton(
                                  label: l10n.accountNotFoundSupport,
                                  onPressed: () => _showSupport(context, l10n),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    backgroundColor: primary.shade500,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.tokenFull,
                                      ),
                                    ),
                                    textStyle: AppTypography.buyerMobile.button
                                        .toTextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: -36,
                      start: AppSpacing.tokenL,
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: yellow,
                          borderRadius:
                              BorderRadius.circular(AppRadius.token2Xl),
                        ),
                        padding: const EdgeInsets.all(AppSpacing.tokenL),
                        child: SvgPicture.asset(
                          AppImages.search,
                          colorFilter: const ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
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
      ],
    );
  }

  void _showSupport(BuildContext context, AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: AppText(l10n.loginMethodHelp),
        content: AppText(l10n.loginMethodHelpMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: AppText(l10n.close),
          ),
        ],
      ),
    );
  }
}

class _AdviceRow extends StatelessWidget {
  const _AdviceRow({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final neutral = AppColors.primitives.neutral;
    final child = Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenM),
      decoration: BoxDecoration(
        color: neutral.shade200,
        borderRadius: BorderRadius.circular(AppRadius.tokenXl),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18,
              color: AppColors.primitives.primary.shade500,
            ),
          ),
          const SizedBox(width: AppSpacing.tokenS),
          Expanded(
            child: AppText(
              label,
              variant: AppTextVariant.bodySmall,
              textAlign: TextAlign.start,
              style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                color: neutral.shade900,
              ),
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return child;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.tokenXl),
        child: child,
      ),
    );
  }
}
