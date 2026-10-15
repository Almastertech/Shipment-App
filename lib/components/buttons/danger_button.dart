import 'package:flutter/material.dart';

import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';

class DangerButton extends StatelessWidget {
  const DangerButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool fullWidth;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onError,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            icon!,
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ],
      ),
    );

    if (semanticLabel != null && semanticLabel!.trim().isNotEmpty) {
      button = Semantics(
        button: true,
        label: semanticLabel,
        child: button,
      );
    }

    if (!fullWidth) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}
