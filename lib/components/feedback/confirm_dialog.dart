import 'package:flutter/material.dart';

import '../../core/resources/app_spacing.dart';
import '../../l10n/app_localizations.dart';

class ConfirmDialog {
  ConfirmDialog._();

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool isDanger = false,
  }) async {
    final l10n = AppLocalizations.of(context);
    final resolvedConfirmLabel = confirmLabel ?? l10n?.confirm ?? 'Confirm';
    final resolvedCancelLabel = cancelLabel ?? l10n?.cancel ?? 'Cancel';

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actionsPadding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.md,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(resolvedCancelLabel),
            ),
            FilledButton(
              style: isDanger
                  ? FilledButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError,
                    )
                  : null,
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(resolvedConfirmLabel),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}
