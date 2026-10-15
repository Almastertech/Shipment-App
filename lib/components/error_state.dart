import 'package:flutter/material.dart';
import '../core/resources/app_icon_size.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../l10n/app_localizations.dart';
import 'app_text.dart';
import 'buttons/custom_button.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    this.title,
    required this.message,
    this.icon = Icons.error_outline,
    this.onRetry,
    this.retryLabel,
    this.maxContentWidth = 520,
  });

  final String? title;
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;
  final String? retryLabel;
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.p24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .error
                        .withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(AppRadius.r16),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.error,
                    size: AppIconSize.iconL,
                  ),
                ),
                if (title != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.p12),
                  AppText(
                    title!,
                    variant: AppTextVariant.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: AppSpacing.p12),
                AppText(
                  message,
                  variant: AppTextVariant.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                if (onRetry != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.p16),
                  CustomButton(
                    label: retryLabel ?? l10n?.retry ?? 'Retry',
                    onPressed: onRetry!,
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
