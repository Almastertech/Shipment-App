import 'package:flutter/material.dart';

class AppTapTarget {
  AppTapTarget._();

  /// Minimum accessible hit area for interactive controls.
  static const double minInteractiveSize = 48;

  /// Common compact icon-button size that still respects accessibility.
  static const double iconButton = minInteractiveSize;

  /// Standard action button height used by primary/secondary actions.
  static const double actionButtonHeight = 52;

  static const Size minButtonSize =
      Size(minInteractiveSize, actionButtonHeight);
}
