import 'package:flutter/material.dart';

import '../../core/resources/app_icon_size.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_tap_target.dart';

enum StatusBannerType {
  success,
  warning,
  error,
  info,
}

class StatusBanner extends StatelessWidget {
  const StatusBanner({
    super.key,
    required this.message,
    this.title,
    this.type = StatusBannerType.info,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.dismissTooltip,
    this.maxMessageLines = 3,
  });

  final String message;
  final String? title;
  final StatusBannerType type;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onDismiss;
  final String? dismissTooltip;
  final int maxMessageLines;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, icon) = _resolveStyle(context, type);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: foreground, size: AppIconSize.xs),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (title != null)
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: foreground,
                          fontWeight: FontWeight.w700,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (title != null) const SizedBox(height: AppSpacing.xxs),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: foreground,
                      ),
                  maxLines: maxMessageLines,
                  overflow: TextOverflow.ellipsis,
                ),
                if (actionLabel != null && onAction != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.xs),
                  TextButton(
                    onPressed: onAction,
                    style: TextButton.styleFrom(
                      foregroundColor: foreground,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.p8,
                        vertical: AppSpacing.p4,
                      ),
                      minimumSize: const Size(
                        AppTapTarget.minInteractiveSize,
                        AppTapTarget.minInteractiveSize,
                      ),
                    ),
                    child: Text(
                      actionLabel!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onDismiss != null)
            IconButton(
              tooltip: dismissTooltip,
              onPressed: onDismiss,
              icon: Icon(
                Icons.close_rounded,
                color: foreground,
                size: AppIconSize.xs,
              ),
            ),
        ],
      ),
    );
  }

  (Color, Color, IconData) _resolveStyle(
    BuildContext context,
    StatusBannerType type,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return switch (type) {
      StatusBannerType.success => (
          scheme.primaryContainer,
          scheme.onPrimaryContainer,
          Icons.check_circle_outline_rounded,
        ),
      StatusBannerType.warning => (
          scheme.tertiaryContainer,
          scheme.onTertiaryContainer,
          Icons.warning_amber_rounded,
        ),
      StatusBannerType.error => (
          scheme.errorContainer,
          scheme.onErrorContainer,
          Icons.error_outline_rounded,
        ),
      StatusBannerType.info => (
          scheme.secondaryContainer,
          scheme.onSecondaryContainer,
          Icons.info_outline_rounded,
        ),
    };
  }
}
