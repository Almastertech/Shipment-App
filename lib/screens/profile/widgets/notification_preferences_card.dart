import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class NotificationPreference {
  const NotificationPreference({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;
}

class NotificationPreferencesCard extends StatelessWidget {
  const NotificationPreferencesCard({
    super.key,
    required this.preferences,
  });

  final List<NotificationPreference> preferences;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final radius = BorderRadius.circular(AppRadius.token2Xl);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.semantic.surface.primary,
        borderRadius: radius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: SizedBox(
          height: 312,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenXl,
              AppSpacing.tokenXl,
              AppSpacing.tokenXl,
              AppSpacing.tokenL,
            ),
            child: Column(
              children: <Widget>[
                for (var index = 0; index < preferences.length; index++)
                  ...<Widget>[
                    Expanded(
                      child: _NotificationPreferenceRow(
                        preference: preferences[index],
                      ),
                    ),
                    if (index < preferences.length - 1)
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFEEEEF3),
                      ),
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationPreferenceRow extends StatelessWidget {
  const _NotificationPreferenceRow({required this.preference});

  final NotificationPreference preference;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.tokenM,
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          _PreferenceSwitch(
            value: preference.value,
            label: preference.title,
            onChanged: preference.onChanged,
          ),
          const SizedBox(width: AppSpacing.tokenS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppText(
                  preference.title,
                  variant: AppTextVariant.bodyMedium,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                    color: AppColors.primitives.neutral.shade900,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                AppText(
                  preference.description,
                  variant: AppTextVariant.bodySmall,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: AppColors.primitives.neutral.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferenceSwitch extends StatelessWidget {
  const _PreferenceSwitch({
    required this.value,
    required this.label,
    required this.onChanged,
  });

  final bool value;
  final String label;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      toggled: value,
      button: true,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: 52,
          height: 32,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: value
                ? AppColors.primitives.primary.shade500
                : AppColors.primitives.neutral.shade300,
            borderRadius: BorderRadius.circular(AppRadius.tokenFull),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            alignment: value ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
