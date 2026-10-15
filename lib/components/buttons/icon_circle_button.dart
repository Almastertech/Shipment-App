import 'package:flutter/material.dart';

import '../../core/resources/app_radius.dart';
import '../../core/resources/app_tap_target.dart';

class IconCircleButton extends StatelessWidget {
  const IconCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.semanticLabel,
    this.size = AppTapTarget.iconButton,
    this.backgroundColor,
    this.foregroundColor,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? semanticLabel;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final buttonSize = size < AppTapTarget.minInteractiveSize
        ? AppTapTarget.minInteractiveSize
        : size;
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: IconButton(
        tooltip: tooltip ?? semanticLabel,
        onPressed: onPressed,
        icon: Icon(icon),
        style: IconButton.styleFrom(
          backgroundColor:
              backgroundColor ?? colorScheme.primary.withValues(alpha: .12),
          foregroundColor: foregroundColor ?? colorScheme.primary,
          minimumSize: Size.square(buttonSize),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.circle),
          ),
        ),
      ),
    );
  }
}
