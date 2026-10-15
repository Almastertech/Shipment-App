import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../app_text.dart';
import 'app_bottom_sheet.dart';

class BottomSheetOption<T> {
  const BottomSheetOption({
    required this.label,
    required this.value,
    this.icon,
    this.destructive = false,
  });

  final String label;
  final T value;
  final IconData? icon;
  final bool destructive;
}

abstract class AppBottomSheetService {
  Future<T?> showCustom<T>({
    required WidgetBuilder builder,
    bool isScrollControlled,
  });

  Future<bool?> showConfirmation({
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool destructive,
  });

  Future<T?> showSelection<T>({
    required String title,
    required List<BottomSheetOption<T>> options,
  });

  Future<T?> showActionSheet<T>({
    required String title,
    required List<BottomSheetOption<T>> actions,
  });

  Future<void> showInfo({
    required String title,
    required String message,
    String? actionLabel,
  });
}

class BottomSheetService implements AppBottomSheetService {
  BottomSheetService({required GlobalKey<NavigatorState> navigatorKey})
      : _navigatorKey = navigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey;

  BuildContext? get _context => _navigatorKey.currentContext;

  @override
  Future<T?> showCustom<T>({
    required WidgetBuilder builder,
    bool isScrollControlled = false,
  }) {
    final context = _context;
    if (context == null) {
      return Future<T?>.value(null);
    }

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      builder: builder,
    );
  }

  @override
  Future<T?> showActionSheet<T>({
    required String title,
    required List<BottomSheetOption<T>> actions,
  }) {
    return showSelection<T>(title: title, options: actions);
  }

  @override
  Future<bool?> showConfirmation({
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool destructive = false,
  }) {
    final context = _context;
    if (context == null) {
      return Future<bool?>.value(false);
    }

    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final resolvedConfirmLabel = confirmLabel ?? l10n?.confirm ?? 'Confirm';
    final resolvedCancelLabel = cancelLabel ?? l10n?.cancel ?? 'Cancel';

    return AppBottomSheet.show<bool>(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppText(title, variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          AppText(message, variant: AppTextVariant.bodyMedium),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: destructive
                  ? ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError,
                    )
                  : null,
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(resolvedConfirmLabel),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(resolvedCancelLabel),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> showInfo({
    required String title,
    required String message,
    String? actionLabel,
  }) async {
    final context = _context;
    if (context == null) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    final resolvedActionLabel = actionLabel ?? l10n?.close ?? 'Close';

    await AppBottomSheet.show<void>(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppText(title, variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          AppText(message, variant: AppTextVariant.bodyMedium),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(resolvedActionLabel),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<T?> showSelection<T>({
    required String title,
    required List<BottomSheetOption<T>> options,
  }) {
    final context = _context;
    if (context == null) {
      return Future<T?>.value(null);
    }

    return AppBottomSheet.show<T>(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppText(title, variant: AppTextVariant.titleLarge),
          const SizedBox(height: 12),
          ...options.map((option) {
            final color = option.destructive
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onSurface;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => Navigator.of(context).pop(option.value),
              leading:
                  option.icon == null ? null : Icon(option.icon, color: color),
              title: Text(
                option.label,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: color),
              ),
            );
          }),
        ],
      ),
    );
  }
}
