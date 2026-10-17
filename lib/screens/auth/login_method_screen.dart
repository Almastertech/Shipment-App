import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/layout/auth_hero.dart';
import '../../components/layout/auth_screen_shell.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';

class LoginMethodScreen extends StatefulWidget {
  const LoginMethodScreen({super.key});

  @override
  State<LoginMethodScreen> createState() => _LoginMethodScreenState();
}

class _LoginMethodScreenState extends State<LoginMethodScreen> {
  _LoginMethod? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primary = AppColors.primitives.primary;
    final neutral = AppColors.primitives.neutral;

    return AppScaffold(
      safeArea: false,
      padding: EdgeInsets.zero,
      backgroundColor: neutral.shade100,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.tokenL,
            AppSpacing.tokenS,
            AppSpacing.tokenL,
            AppSpacing.tokenS,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                label: l10n.loginMethodContinue,
                onPressed: _selectedMethod == null
                    ? null
                    : () => context.go(
                          AppRoutes.login,
                          extra: _selectedMethod!.name,
                        ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedMethod == null
                      ? neutral.shade300
                      : primary.shade500,
                  foregroundColor: _selectedMethod == null
                      ? neutral.shade600
                      : neutral.shade100,
                  disabledBackgroundColor: neutral.shade300,
                  disabledForegroundColor: neutral.shade600,
                  minimumSize: const Size.fromHeight(52),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                  ),
                  textStyle: AppTypography.buyerMobile.button.toTextStyle(
                    color: _selectedMethod == null
                        ? neutral.shade600
                        : neutral.shade100,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.tokenS),
              AppText(
                l10n.authPrivacyNotice,
                variant: AppTextVariant.labelSmall,
                textAlign: TextAlign.center,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: neutral.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
      body: AuthScreenShell(
        hero: AuthHero(
          helpLabel: l10n.loginMethodHelp,
          title: l10n.loginMethodTitle,
          subtitle: l10n.loginMethodSubtitle,
          onBack: () => context.go(AppRoutes.onboarding),
          onHelp: () => _showHelp(context, l10n),
        ),
        content: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.tokenL,
            AppSpacing.token2Xl,
            AppSpacing.tokenL,
            AppSpacing.tokenL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText(
                l10n.loginMethodChooseTitle,
                variant: AppTextVariant.titleMedium,
                textAlign: TextAlign.right,
                style: AppTypography.buyerMobile.h5.toTextStyle(
                  color: neutral.shade700,
                ),
              ),
              const SizedBox(height: AppSpacing.token2Xs),
              _LoginMethodTile(
                icon: Icons.phone_in_talk_outlined,
                title: l10n.loginMethodPhone,
                subtitle: l10n.loginMethodPhoneDescription,
                selected: _selectedMethod == _LoginMethod.phone,
                onTap: () =>
                    setState(() => _selectedMethod = _LoginMethod.phone),
              ),
              const SizedBox(height: AppSpacing.tokenS),
              _LoginMethodTile(
                icon: Icons.mail_outline_rounded,
                title: l10n.loginMethodEmail,
                subtitle: l10n.loginMethodEmailDescription,
                selected: _selectedMethod == _LoginMethod.email,
                onTap: () =>
                    setState(() => _selectedMethod = _LoginMethod.email),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelp(BuildContext context, AppLocalizations l10n) {
    final neutral = AppColors.primitives.neutral;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: neutral.shade100,
        title:
            AppText(l10n.loginMethodHelp, variant: AppTextVariant.titleLarge),
        content: AppText(
          l10n.loginMethodHelpMessage,
          variant: AppTextVariant.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AppText(l10n.close, variant: AppTextVariant.labelLarge),
          ),
        ],
      ),
    );
  }
}

class _LoginMethodTile extends StatelessWidget {
  const _LoginMethodTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final neutral = AppColors.primitives.neutral;
    final direction = Directionality.of(context);
    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      label: '$title. $subtitle',
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: selected ? primary.shade500 : neutral.shade300,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.tokenM,
              vertical: AppSpacing.tokenS,
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: neutral.shade200,
                    borderRadius: BorderRadius.circular(AppRadius.tokenL),
                  ),
                  child: Icon(icon, color: neutral.shade800, size: 24),
                ),
                const SizedBox(width: AppSpacing.tokenM),
                Expanded(
                  child: Directionality(
                    textDirection: direction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          title,
                          variant: AppTextVariant.titleSmall,
                          style: AppTypography.buyerMobile.h5.toTextStyle(
                            color: neutral.shade900,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.token2Xs),
                        AppText(
                          subtitle,
                          variant: AppTextVariant.bodySmall,
                          style:
                              AppTypography.buyerMobile.bodySmall.toTextStyle(
                            color: neutral.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.tokenM),
                _SelectionIndicator(selected: selected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final neutral = AppColors.primitives.neutral;
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? primary.shade500 : neutral.shade400,
          width: 1.5,
        ),
      ),
      child: selected
          ? Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: primary.shade500,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}

enum _LoginMethod { phone, email }
