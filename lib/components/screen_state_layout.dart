import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'empty_state.dart';
import 'error_state.dart';
import 'error_ui_model.dart';
import 'loading_spinner.dart';

class ScreenStateLayout extends StatelessWidget {
  const ScreenStateLayout({
    super.key,
    required this.child,
    this.isLoading = false,
    this.isEmpty = false,
    this.errorMessage,
    this.errorUiModel,
    this.onRetry,
    this.loadingLabel,
    this.emptyTitle,
    this.emptyDescription,
    this.emptyIcon,
    this.emptyIllustration,
    this.emptyPrimaryActionLabel,
    this.onEmptyPrimaryAction,
    this.emptySecondaryActionLabel,
    this.onEmptySecondaryAction,
    this.retryLabel,
  });

  final Widget child;
  final bool isLoading;
  final bool isEmpty;
  final String? errorMessage;
  final ErrorUiModel? errorUiModel;
  final VoidCallback? onRetry;
  final String? loadingLabel;
  final String? emptyTitle;
  final String? emptyDescription;
  final IconData? emptyIcon;
  final Widget? emptyIllustration;
  final String? emptyPrimaryActionLabel;
  final VoidCallback? onEmptyPrimaryAction;
  final String? emptySecondaryActionLabel;
  final VoidCallback? onEmptySecondaryAction;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (isLoading) {
      return LoadingSpinner(label: loadingLabel);
    }

    if (errorUiModel != null) {
      return ErrorState(
        title: errorUiModel!.title,
        message: errorUiModel!.message,
        icon: errorUiModel!.icon,
        onRetry: onRetry,
        retryLabel:
            retryLabel ?? errorUiModel!.actionLabel ?? l10n?.retry ?? 'Retry',
      );
    }

    if (errorMessage != null) {
      return ErrorState(
        message: errorMessage!,
        onRetry: onRetry,
        retryLabel: retryLabel ?? l10n?.retry ?? 'Retry',
      );
    }

    if (isEmpty) {
      return EmptyState(
        title: emptyTitle ?? l10n?.noItemsTitle ?? 'No results found',
        description: emptyDescription ?? l10n?.noItemsDescription,
        icon: emptyIcon ?? Icons.inbox_outlined,
        illustration: emptyIllustration,
        primaryActionLabel: emptyPrimaryActionLabel,
        onPrimaryAction: onEmptyPrimaryAction,
        secondaryActionLabel: emptySecondaryActionLabel,
        onSecondaryAction: onEmptySecondaryAction,
      );
    }

    return child;
  }
}
