import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
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
      backgroundColor: neutral.shade100,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.tokenM,
        AppSpacing.tokenM,
        AppSpacing.tokenM,
        AppSpacing.tokenL,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.tokenM,
            AppSpacing.tokenS,
            AppSpacing.tokenM,
            AppSpacing.tokenM,
          ),
          child: PrimaryButton(
            label: l10n.loginMethodContinue,
            onPressed: _selectedMethod == null
                ? null
                : () => context.go(
                      AppRoutes.login,
                      extra: _selectedMethod!.name,
                    ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _selectedMethod == null ? primary.shade300 : primary.shade500,
              foregroundColor: neutral.shade100,
              disabledBackgroundColor: primary.shade300,
              disabledForegroundColor: neutral.shade100,
              minimumSize: const Size.fromHeight(52),
              padding: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.token2Xl),
              ),
              textStyle: AppTypography.buyerMobile.button.toTextStyle(
                color: neutral.shade100,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _TopBar(
              helpLabel: l10n.loginMethodHelp,
              onBack: () => context.go(AppRoutes.onboarding),
              onHelp: () => _showHelp(context, l10n),
            ),
            const SizedBox(height: AppSpacing.tokenL),
            AppText(
              l10n.loginMethodTitle,
              variant: AppTextVariant.headlineMedium,
              style: AppTypography.buyerMobile.h2.toTextStyle(
                color: primary.shade500,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: AppSpacing.tokenXs),
            AppText(
              l10n.loginMethodSubtitle,
              variant: AppTextVariant.bodySmall,
              style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                color: neutral.shade400,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: AppSpacing.tokenXl),
            _LoginMethodTile(
              icon: Icons.phone_iphone_rounded,
              title: l10n.loginMethodPhone,
              subtitle: l10n.loginMethodPhoneDescription,
              selected: _selectedMethod == _LoginMethod.phone,
              onTap: () => setState(() => _selectedMethod = _LoginMethod.phone),
            ),
            const SizedBox(height: AppSpacing.tokenS),
            _LoginMethodTile(
              icon: Icons.mail_outline_rounded,
              title: l10n.loginMethodEmail,
              subtitle: l10n.loginMethodEmailDescription,
              selected: _selectedMethod == _LoginMethod.email,
              onTap: () => setState(() => _selectedMethod = _LoginMethod.email),
            ),
          ],
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
        title: AppText(
          l10n.loginMethodHelp,
          variant: AppTextVariant.titleLarge,
        ),
        content: AppText(
          l10n.loginMethodHelpMessage,
          variant: AppTextVariant.bodyMedium,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AppText(
              l10n.close,
              variant: AppTextVariant.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.helpLabel,
    required this.onBack,
    required this.onHelp,
  });

  final String helpLabel;
  final VoidCallback onBack;
  final VoidCallback onHelp;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final neutral = AppColors.primitives.neutral;
    return Row(
      textDirection: Directionality.of(context),
      children: <Widget>[
        IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: onBack,
          style: IconButton.styleFrom(
            backgroundColor: neutral.shade200,
            foregroundColor: primary.shade500,
            fixedSize: const Size(40, 40),
          ),
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        const Spacer(),
        TextButton(
          onPressed: onHelp,
          style: TextButton.styleFrom(
            foregroundColor: primary.shade500,
            textStyle: AppTypography.buyerMobile.label.toTextStyle(
              color: primary.shade500,
            ),
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: AppText(
            helpLabel,
            variant: AppTextVariant.labelMedium,
            style: AppTypography.buyerMobile.label.toTextStyle(
              color: primary.shade500,
            ),
          ),
        ),
      ],
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
    final textDirection = Directionality.of(context);

    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      label: '$title. $subtitle',
      child: Material(
        color: neutral.shade200,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: selected ? primary.shade500 : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppRadius.tokenXl),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.tokenXl),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.tokenM),
            child: Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: selected ? primary.shade500 : neutral.shade100,
                    borderRadius: BorderRadius.circular(AppRadius.tokenXl),
                  ),
                  child: Icon(
                    icon,
                    color: selected ? neutral.shade100 : primary.shade500,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.tokenM),
                Expanded(
                  child: Directionality(
                    textDirection: textDirection,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppText(
                          title,
                          variant: AppTextVariant.titleMedium,
                          style: AppTypography.buyerMobile.h5.toTextStyle(
                            color: primary.shade500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        AppText(
                          subtitle,
                          variant: AppTextVariant.bodySmall,
                          style:
                              AppTypography.buyerMobile.bodySmall.toTextStyle(
                            color: neutral.shade400,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.tokenS),
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
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? primary.shade500 : neutral.shade300,
          width: 1,
        ),
      ),
      child: selected
          ? Container(
              width: 8,
              height: 8,
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
