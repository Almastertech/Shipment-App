import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Typography primitives and platform roles from the product design system.
class AppTypography {
  static const String fontFamily = 'IBM Plex Sans Arabic';

  static const AppTypographyPrimitives primitives = AppTypographyPrimitives(
    fontFamily: fontFamily,
    regular: FontWeight.w400,
    medium: FontWeight.w500,
    semiBold: FontWeight.w600,
    bold: FontWeight.w700,
    sizes: <double>[12, 14, 16, 18, 20, 24, 28, 32, 36, 40, 56],
    lineHeights: <double>[16, 20, 24, 28, 36, 40, 44, 48, 56, 72],
    letterSpacing: 0,
  );

  /// Typography for the Flutter buyer app.
  static const AppTypographyProfile buyerMobile = AppTypographyProfile(
    display: AppTypographyStyle(36, 48, FontWeight.w700),
    h1: AppTypographyStyle(32, 44, FontWeight.w700),
    h2: AppTypographyStyle(28, 40, FontWeight.w600),
    h3: AppTypographyStyle(24, 36, FontWeight.w600),
    h4: AppTypographyStyle(20, 28, FontWeight.w600),
    h5: AppTypographyStyle(18, 28, FontWeight.w500),
    h6: AppTypographyStyle(16, 24, FontWeight.w500),
    bodyLarge: AppTypographyStyle(18, 28, FontWeight.w400),
    bodyMedium: AppTypographyStyle(16, 24, FontWeight.w400),
    bodySmall: AppTypographyStyle(14, 20, FontWeight.w400),
    caption: AppTypographyStyle(12, 16, FontWeight.w400),
    label: AppTypographyStyle(14, 20, FontWeight.w500),
    button: AppTypographyStyle(16, 24, FontWeight.w600),
  );

  /// Shared desktop website typography.
  static const AppTypographyProfile websiteDesktop = AppTypographyProfile(
    display: AppTypographyStyle(56, 72, FontWeight.w700),
    h1: AppTypographyStyle(40, 56, FontWeight.w700),
    h2: AppTypographyStyle(32, 44, FontWeight.w600),
    h3: AppTypographyStyle(28, 40, FontWeight.w600),
    h4: AppTypographyStyle(24, 36, FontWeight.w600),
    h5: AppTypographyStyle(20, 28, FontWeight.w500),
    h6: AppTypographyStyle(18, 28, FontWeight.w500),
    bodyLarge: AppTypographyStyle(18, 28, FontWeight.w400),
    bodyMedium: AppTypographyStyle(16, 24, FontWeight.w400),
    bodySmall: AppTypographyStyle(14, 20, FontWeight.w400),
    caption: AppTypographyStyle(12, 16, FontWeight.w400),
    label: AppTypographyStyle(14, 20, FontWeight.w500),
    button: AppTypographyStyle(16, 24, FontWeight.w600),
  );

  /// Responsive website typography. Roles not overridden by the design inherit
  /// the website desktop sizes, weights, family, and tracking.
  static const AppTypographyProfile websiteMobile = AppTypographyProfile(
    display: AppTypographyStyle(40, 56, FontWeight.w700),
    h1: AppTypographyStyle(32, 44, FontWeight.w700),
    h2: AppTypographyStyle(28, 40, FontWeight.w600),
    h3: AppTypographyStyle(24, 36, FontWeight.w600),
    h4: AppTypographyStyle(20, 28, FontWeight.w600),
    h5: AppTypographyStyle(18, 28, FontWeight.w500),
    h6: AppTypographyStyle(16, 24, FontWeight.w500),
    bodyLarge: AppTypographyStyle(18, 28, FontWeight.w400),
    bodyMedium: AppTypographyStyle(16, 24, FontWeight.w400),
    bodySmall: AppTypographyStyle(14, 20, FontWeight.w400),
    caption: AppTypographyStyle(12, 16, FontWeight.w400),
    label: AppTypographyStyle(14, 20, FontWeight.w500),
    button: AppTypographyStyle(16, 24, FontWeight.w600),
  );

  /// Dense typography for the admin dashboard.
  static const AppTypographyProfile adminDashboard = AppTypographyProfile(
    display: AppTypographyStyle(32, 44, FontWeight.w700),
    h1: AppTypographyStyle(28, 40, FontWeight.w700),
    h2: AppTypographyStyle(24, 36, FontWeight.w600),
    h3: AppTypographyStyle(20, 28, FontWeight.w600),
    h4: AppTypographyStyle(18, 28, FontWeight.w600),
    h5: AppTypographyStyle(16, 24, FontWeight.w500),
    h6: AppTypographyStyle(14, 20, FontWeight.w500),
    bodyLarge: AppTypographyStyle(16, 24, FontWeight.w400),
    bodyMedium: AppTypographyStyle(14, 20, FontWeight.w400),
    bodySmall: AppTypographyStyle(12, 16, FontWeight.w400),
    caption: AppTypographyStyle(12, 16, FontWeight.w400),
    label: AppTypographyStyle(12, 16, FontWeight.w500),
    button: AppTypographyStyle(14, 20, FontWeight.w600),
  );

  /// Existing Flutter widgets consume the buyer mobile roles by default.
  static TextTheme textTheme(
    AppColorPalette palette, {
    AppTypographyProfile profile = buyerMobile,
  }) {
    return profile.toTextTheme(palette);
  }
}

@immutable
class AppTypographyPrimitives {
  const AppTypographyPrimitives({
    required this.fontFamily,
    required this.regular,
    required this.medium,
    required this.semiBold,
    required this.bold,
    required this.sizes,
    required this.lineHeights,
    required this.letterSpacing,
  });

  final String fontFamily;
  final FontWeight regular;
  final FontWeight medium;
  final FontWeight semiBold;
  final FontWeight bold;
  final List<double> sizes;
  final List<double> lineHeights;
  final double letterSpacing;
}

/// A role's font metrics. `lineHeight` is converted to Flutter's multiplier.
@immutable
class AppTypographyStyle {
  const AppTypographyStyle(this.fontSize, this.lineHeight, this.fontWeight);

  final double fontSize;
  final double lineHeight;
  final FontWeight fontWeight;

  TextStyle toTextStyle({Color? color}) {
    return TextStyle(
      fontFamily: AppTypography.fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: lineHeight / fontSize,
      letterSpacing: AppTypography.primitives.letterSpacing,
      color: color,
    );
  }
}

/// The 13 roles shared by each platform typography profile.
@immutable
class AppTypographyProfile {
  const AppTypographyProfile({
    required this.display,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.caption,
    required this.label,
    required this.button,
  });

  final AppTypographyStyle display;
  final AppTypographyStyle h1;
  final AppTypographyStyle h2;
  final AppTypographyStyle h3;
  final AppTypographyStyle h4;
  final AppTypographyStyle h5;
  final AppTypographyStyle h6;
  final AppTypographyStyle bodyLarge;
  final AppTypographyStyle bodyMedium;
  final AppTypographyStyle bodySmall;
  final AppTypographyStyle caption;
  final AppTypographyStyle label;
  final AppTypographyStyle button;

  TextTheme toTextTheme(AppColorPalette palette) {
    return TextTheme(
      displayLarge: display.toTextStyle(color: palette.text.heading),
      headlineLarge: h1.toTextStyle(color: palette.text.heading),
      headlineMedium: h2.toTextStyle(color: palette.text.heading),
      headlineSmall: h3.toTextStyle(color: palette.text.heading),
      titleLarge: h4.toTextStyle(color: palette.text.heading),
      titleMedium: h5.toTextStyle(color: palette.text.heading),
      titleSmall: h6.toTextStyle(color: palette.text.heading),
      bodyLarge: bodyLarge.toTextStyle(color: palette.text.body),
      bodyMedium: bodyMedium.toTextStyle(color: palette.text.body),
      bodySmall: bodySmall.toTextStyle(color: palette.text.body),
      labelLarge: button.toTextStyle(color: palette.text.onActionLight),
      labelMedium: label.toTextStyle(color: palette.text.heading),
      labelSmall: caption.toTextStyle(color: palette.text.caption),
    );
  }
}
