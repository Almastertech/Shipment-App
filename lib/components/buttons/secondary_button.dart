import 'package:flutter/material.dart';

import '../../core/resources/app_spacing.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconOnTrailing = false,
    this.fullWidth = true,
    this.semanticLabel,
    this.style,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool iconOnTrailing;
  final bool fullWidth;
  final String? semanticLabel;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null && !iconOnTrailing) ...<Widget>[
          icon!,
          const SizedBox(width: AppSpacing.xs),
        ],
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        if (icon != null && iconOnTrailing) ...<Widget>[
          const SizedBox(width: AppSpacing.xs),
          icon!,
        ],
      ],
    );

    Widget button = OutlinedButton(
      onPressed: onPressed,
      style: style,
      child: content,
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
