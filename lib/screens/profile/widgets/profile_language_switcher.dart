import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../localization/controllers/localization_controller.dart';

class ProfileLanguageSwitcher extends StatelessWidget {
  const ProfileLanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationController = context.watch<LocalizationController>();
    final currentLanguageCode = localizationController.locale.languageCode;
    final isArabic = currentLanguageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.primitives;

    return Container(
      height: 32,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: colors.neutral.shade200,
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _LanguageSegment(
            label: l10n.profileLanguageArabic,
            isSelected: isArabic,
            onTap: () {
              HapticFeedback.selectionClick();
              localizationController.setLanguage('ar');
            },
          ),
          const SizedBox(width: 2),
          _LanguageSegment(
            label: l10n.profileLanguageEnglish,
            isSelected: !isArabic,
            onTap: () {
              HapticFeedback.selectionClick();
              localizationController.setLanguage('en');
            },
          ),
        ],
      ),
    );
  }
}

class _LanguageSegment extends StatelessWidget {
  const _LanguageSegment({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.tokenS + 2,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: isSelected ? colors.primary.shade500 : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.tokenFull),
            boxShadow: isSelected
                ? <BoxShadow>[
                    BoxShadow(
                      color: colors.primary.shade500.withValues(alpha: 0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: AppText(
            label,
            variant: AppTextVariant.bodySmall,
            style: AppTypography.buyerMobile.bodySmall
                .toTextStyle(
                  color: isSelected ? Colors.white : colors.neutral.shade700,
                )
                .copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  fontSize: 12,
                ),
          ),
        ),
      ),
    );
  }
}
