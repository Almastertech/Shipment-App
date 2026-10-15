import 'package:flutter/material.dart';

import '../core/resources/app_icon_size.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../l10n/app_localizations.dart';
import 'app_text.dart';
import 'buttons/custom_button.dart';
import 'buttons/secondary_button.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.title,
    this.description,
    this.icon = Icons.inbox_outlined,
    this.illustration,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.maxContentWidth = 520,
  });

  final String? title;
  final String? description;
  final IconData icon;
  final Widget? illustration;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final resolvedTitle = title ?? l10n?.noItemsTitle ?? 'No items available';
    final hasPrimary = primaryActionLabel != null && onPrimaryAction != null;
    final hasSecondary =
        secondaryActionLabel != null && onSecondaryAction != null;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.p24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                illustration ??
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(AppRadius.r16),
                      ),
                      child: Icon(
                        icon,
                        size: AppIconSize.iconL,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                const SizedBox(height: AppSpacing.p12),
                AppText(
                  resolvedTitle,
                  variant: AppTextVariant.titleMedium,
                  textAlign: TextAlign.center,
                ),
                if (description != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.p8),
                  AppText(
                    description!,
                    variant: AppTextVariant.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
                if (hasPrimary) ...<Widget>[
                  const SizedBox(height: AppSpacing.p16),
                  CustomButton(
                    label: primaryActionLabel!,
                    onPressed: onPrimaryAction!,
                  ),
                ],
                if (hasSecondary) ...<Widget>[
                  const SizedBox(height: AppSpacing.p8),
                  SecondaryButton(
                    label: secondaryActionLabel!,
                    onPressed: onSecondaryAction,
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
