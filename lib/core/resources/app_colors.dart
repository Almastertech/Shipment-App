import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  /// Primitive ramps and semantic aliases from the product design system.
  ///
  /// Primitive ramps and semantic aliases follow the current product palette.
  /// The light/dark palettes retain their older API for existing screens.
  static const AppColorPrimitives primitives = AppColorPrimitives(
    // Brand purple
    primary: AppColorRamp(
      shade100: Color(0xFFF5F3FE),
      shade200: Color(0xFFE9E6FD),
      shade300: Color(0xFFCEC6FA),
      shade400: Color(0xFFA596F6),
      shade500: Color(0xFF6E56F0),
      shade600: Color(0xFF614CD9),
      shade700: Color(0xFF5340BE),
      shade800: Color(0xFF4332A0),
      shade900: Color(0xFF332482),
    ),
    // Neutral grayscale
    neutral: AppColorRamp(
      shade100: Color(0xFFF7F7F9),
      shade200: Color(0xFFEEEEF3),
      shade300: Color(0xFFE2E2EA),
      shade400: Color(0xFFCDCED8),
      shade500: Color(0xFFA7A7B5),
      shade600: Color(0xFF6D6D7C),
      shade700: Color(0xFF4E4E5C),
      shade800: Color(0xFF2B2B35),
      shade900: Color(0xFF16161A),
    ),
    // Accent yellow
    accent01: AppColorRamp(
      shade100: Color(0xFFFFF8E0),
      shade200: Color(0xFFFFEDAD),
      shade300: Color(0xFFFFD34D),
      shade400: Color(0xFFFFC21A),
      shade500: Color(0xFFF2AE00),
      shade600: Color(0xFFCC9200),
      shade700: Color(0xFFA07300),
      shade800: Color(0xFF725200),
      shade900: Color(0xFF453100),
    ),
    // Accent sky blue
    accent02: AppColorRamp(
      shade100: Color(0xFFECF8FB),
      shade200: Color(0xFFD4EFF7),
      shade300: Color(0xFF9EDCEC),
      shade400: Color(0xFF6ECAE3),
      shade500: Color(0xFF3DB8DA),
      shade600: Color(0xFF35A4C3),
      shade700: Color(0xFF2C8DA9),
      shade800: Color(0xFF23748B),
      shade900: Color(0xFF195A6E),
    ),
    failure: AppColorRamp(
      shade100: Color(0xFFFCF4F4),
      shade200: Color(0xFFF7DCDC),
      shade300: Color(0xFFEFB4B5),
      shade400: Color(0xFFE27F81),
      shade500: Color(0xFFD24446),
      shade600: Color(0xFFB93A3C),
      shade700: Color(0xFF9A2F31),
      shade800: Color(0xFF732325),
      shade900: Color(0xFF4D1819),
    ),
    success: AppColorRamp(
      shade100: Color(0xFFF1F9F0),
      shade200: Color(0xFFD9F0D8),
      shade300: Color(0xFFB0E0AE),
      shade400: Color(0xFF82CC80),
      shade500: Color(0xFF52B850),
      shade600: Color(0xFF43A041),
      shade700: Color(0xFF347D33),
      shade800: Color(0xFF265C25),
      shade900: Color(0xFF183A17),
    ),
    warning: AppColorRamp(
      shade100: Color(0xFFFFF4E5),
      shade200: Color(0xFFFFE2BD),
      shade300: Color(0xFFFFC88A),
      shade400: Color(0xFFFFAA52),
      shade500: Color(0xFFF58A1F),
      shade600: Color(0xFFD86F10),
      shade700: Color(0xFFAE550C),
      shade800: Color(0xFF823F0A),
      shade900: Color(0xFF572A07),
    ),
    mint: AppColorRamp(
      shade100: Color(0xFFECFAF2),
      shade200: Color(0xFFD5F4E3),
      shade300: Color(0xFF9FE5BE),
      shade400: Color(0xFF6FD89E),
      shade500: Color(0xFF3FCB7E),
      shade600: Color(0xFF37B470),
      shade700: Color(0xFF2E9B5F),
      shade800: Color(0xFF247E4D),
      shade900: Color(0xFF19613A),
    ),
  );

  static final AppSemanticColorTokens semantic = AppSemanticColorTokens(
    background: AppSemanticBackgroundColors(
      primary: primitives.neutral.shade100,
      secondary: primitives.neutral.shade200,
      tertiary: primitives.neutral.shade300,
      inverse: primitives.neutral.shade900,
      disabled: primitives.neutral.shade200,
    ),
    surface: AppSemanticSurfaceColors(
      primary: const Color(0xFFFFFFFF),
      secondary: primitives.neutral.shade200,
      tertiary: primitives.neutral.shade300,
      inverse: primitives.neutral.shade900,
    ),
    text: AppSemanticTextColors(
      primary: primitives.neutral.shade900,
      secondary: primitives.neutral.shade700,
      tertiary: primitives.neutral.shade600,
      inverse: const Color(0xFFFFFFFF),
      disabled: primitives.neutral.shade500,
      link: primitives.primary.shade500,
    ),
    border: AppSemanticBorderColors(
      primary: primitives.neutral.shade300,
      secondary: primitives.neutral.shade200,
      strong: primitives.neutral.shade400,
      disabled: primitives.neutral.shade200,
    ),
    action: AppSemanticActionColors(
      primary: primitives.primary.shade500,
      primaryHover: primitives.primary.shade600,
      primaryPressed: primitives.primary.shade700,
      primaryDisabled: primitives.neutral.shade200,
      secondary: primitives.accent01.shade500,
      secondaryHover: primitives.accent01.shade600,
      secondaryPressed: primitives.accent01.shade700,
      secondaryDisabled: primitives.neutral.shade200,
    ),
    status: AppSemanticStatusColors(
      success: primitives.success.shade600,
      successBackground: primitives.success.shade100,
      failure: primitives.failure.shade500,
      failureBackground: primitives.failure.shade100,
      warning: primitives.warning.shade500,
      warningBackground: primitives.warning.shade100,
      info: primitives.primary.shade500,
      infoBackground: primitives.primary.shade100,
    ),
  );

  /// Compatibility aliases that exist separately from the Token/Color paths.
  static final AppStandaloneColorAliases aliases = AppStandaloneColorAliases(
    failure: primitives.failure.shade500,
    success: primitives.success.shade600,
  );

  static const AppColorPalette light = AppColorPalette(
    text: AppTextColors(
      heading: Color(0xFF16161A),
      body: Color(0xFF4E4E5C),
      caption: Color(0xFF6D6D7C),
      primary: Color(0xFF6E56F0),
      onAction: Color(0xFF332482),
      action: Color(0xFF6E56F0),
      actionHover: Color(0xFF614CD9),
      actionPressed: Color(0xFF5340BE),
      onActionHover: Color(0xFF332482),
      onActionPressed: Color(0xFF332482),
      disabled: Color(0xFFA7A7B5),
      success: Color(0xFF43A041),
      warning: Color(0xFFF58A1F),
      danger: Color(0xFFD24446),
      onActionLight: Color(0xFFFFFFFF),
      actionFitness: Color(0xFF3DB8DA),
      deliveryAction: Color(0xFF2E9B5F),
      deliveryActionHover: Color(0xFF37B470),
    ),
    surface: AppSurfaceColors(
      bg: Color(0xFFF7F7F9),
      primary: Color(0xFFFFFFFF),
      action: Color(0xFF6E56F0),
      actionHover: Color(0xFF614CD9),
      actionPressed: Color(0xFF5340BE),
      actionSecondary: Color(0xFFF2AE00),
      actionSecondaryPressed: Color(0xFFA07300),
      actionSecondaryHover: Color(0xFFCC9200),
      actionDisabled: Color(0xFFEEEEF3),
      actionSecondaryCard: Color(0xFFFFF8E0),
      actionSecondaryHighlighted: Color(0xFFFFEDAD),
      actionHighlighted: Color(0xFFCEC6FA),
      actionCard: Color(0xFFF5F3FE),
      decorative01: Color(0xFF3DB8DA),
      decorative01Highlighted: Color(0xFF35A4C3),
      decorative01Card: Color(0xFFECF8FB),
      decorative02: Color(0xFF3FCB7E),
      decorative02Highlighted: Color(0xFF37B470),
      decorative02Card: Color(0xFFECFAF2),
      decorative03: Color(0xFFE27F81),
      decorative03Highlighted: Color(0xFFD24446),
      decorative03Card: Color(0xFFF7DCDC),
      success: Color(0xFF52B850),
      successHighlighted: Color(0xFFF1F9F0),
      warning: Color(0xFFF58A1F),
      warningHighlighted: Color(0xFFFFF4E5),
      danger: Color(0xFFD24446),
      dangerHighlighted: Color(0xFFF7DCDC),
      dangerPressed: Color(0xFF9A2F31),
      dangerHover: Color(0xFFB93A3C),
      disabled: Color(0xFFEEEEF3),
      transparent: Colors.transparent,
      natural200: Color(0xFFEEEEF3),
      inputFlatListPrimary: Color(0xFFFFFFFF),
      neutral900: Color(0xFF16161A),
      actionFitness: Color(0xFF3DB8DA),
      deliveryAction: Color(0xFF2E9B5F),
      deliveryActionHover: Color(0xFF37B470),
    ),
    icon: AppIconColors(
      primary: Color(0xFF16161A),
      secondary: Color(0xFF6D6D7C),
      action: Color(0xFFFFFFFF),
      action2: Color(0xFF6E56F0),
      disabled: Color(0xFFA7A7B5),
      onAction: Color(0xFFFFFFFF),
      onActionSecondary: Color(0xFF453100),
      success: Color(0xFF43A041),
      warning: Color(0xFFF58A1F),
      danger: Color(0xFFD24446),
      decorative02: Color(0xFF3FCB7E),
      decorative02Pressed: Color(0xFF247E4D),
      decorative01Pressed: Color(0xFF23748B),
      actionFitness: Color(0xFF3DB8DA),
      actionPressed: Color(0xFF5340BE),
      black: Color(0xFF16161A),
      deliveryAction: Color(0xFF2E9B5F),
      deliveryActionHover: Color(0xFF37B470),
    ),
    border: AppBorderColors(
      action: Color(0xFF6E56F0),
      actionSecondary: Color(0xFFF2AE00),
      actionHighlighted: Color(0xFFCEC6FA),
      disabled: Color(0xFFEEEEF3),
      actionOutline: Color(0xFFE2E2EA),
      primary: Color(0xFFFFFFFF),
      success: Color(0xFFB0E0AE),
      warning: Color(0xFFFFC88A),
      danger: Color(0xFFD24446),
      dangerHighlighted: Color(0xFFEFB4B5),
      yellow: Color(0xFFFFD34D),
      actionFitness: Color(0xFF3DB8DA),
    ),
    seed: Color(0xFF6E56F0),
  );

  static const AppColorPalette dark = AppColorPalette(
    text: AppTextColors(
      heading: Color(0xFFF7F7F9),
      body: Color(0xFFE2E2EA),
      caption: Color(0xFFCDCED8),
      primary: Color(0xFFA596F6),
      onAction: Color(0xFF332482),
      action: Color(0xFF6E56F0),
      actionHover: Color(0xFF614CD9),
      actionPressed: Color(0xFF5340BE),
      onActionHover: Color(0xFF332482),
      onActionPressed: Color(0xFF332482),
      disabled: Color(0xFF6D6D7C),
      success: Color(0xFF82CC80),
      warning: Color(0xFFFFAA52),
      danger: Color(0xFFD24446),
      onActionLight: Color(0xFFFFFFFF),
      actionFitness: Color(0xFF3DB8DA),
      deliveryAction: Color(0xFF3FCB7E),
      deliveryActionHover: Color(0xFF6FD89E),
    ),
    surface: AppSurfaceColors(
      bg: Color(0xFF16161A),
      primary: Color(0xFF2B2B35),
      action: Color(0xFF6E56F0),
      actionHover: Color(0xFF614CD9),
      actionPressed: Color(0xFF5340BE),
      actionSecondary: Color(0xFFF2AE00),
      actionSecondaryPressed: Color(0xFFA07300),
      actionSecondaryHover: Color(0xFFCC9200),
      actionDisabled: Color(0xFF4E4E5C),
      actionSecondaryCard: Color(0xFF453100),
      actionSecondaryHighlighted: Color(0xFF725200),
      actionHighlighted: Color(0xFF4332A0),
      actionCard: Color(0xFF332482),
      decorative01: Color(0xFF3DB8DA),
      decorative01Highlighted: Color(0xFF35A4C3),
      decorative01Card: Color(0xFF195A6E),
      decorative02: Color(0xFF3FCB7E),
      decorative02Highlighted: Color(0xFF37B470),
      decorative02Card: Color(0xFF19613A),
      decorative03: Color(0xFFE27F81),
      decorative03Highlighted: Color(0xFFD24446),
      decorative03Card: Color(0xFF4D1819),
      success: Color(0xFF43A041),
      successHighlighted: Color(0xFF183A17),
      warning: Color(0xFFF58A1F),
      warningHighlighted: Color(0xFF572A07),
      danger: Color(0xFFD24446),
      dangerHighlighted: Color(0xFF4D1819),
      dangerPressed: Color(0xFFF7DCDC),
      dangerHover: Color(0xFFE27F81),
      disabled: Color(0xFF2B2B35),
      transparent: Colors.transparent,
      natural200: Color(0xFF4E4E5C),
      inputFlatListPrimary: Color(0xFF2B2B35),
      neutral900: Color(0xFF16161A),
      actionFitness: Color(0xFF3DB8DA),
      deliveryAction: Color(0xFF2E9B5F),
      deliveryActionHover: Color(0xFF37B470),
    ),
    icon: AppIconColors(
      primary: Color(0xFFF7F7F9),
      secondary: Color(0xFFCDCED8),
      action: Color(0xFFFFFFFF),
      action2: Color(0xFFA596F6),
      disabled: Color(0xFF6D6D7C),
      onAction: Color(0xFFFFFFFF),
      onActionSecondary: Color(0xFF453100),
      success: Color(0xFF82CC80),
      warning: Color(0xFFFFAA52),
      danger: Color(0xFFD24446),
      decorative02: Color(0xFF3FCB7E),
      decorative02Pressed: Color(0xFF9FE5BE),
      decorative01Pressed: Color(0xFF9EDCEC),
      actionFitness: Color(0xFF3DB8DA),
      actionPressed: Color(0xFFCEC6FA),
      black: Color(0xFF16161A),
      deliveryAction: Color(0xFF3FCB7E),
      deliveryActionHover: Color(0xFF6FD89E),
    ),
    border: AppBorderColors(
      action: Color(0xFF6E56F0),
      actionSecondary: Color(0xFFF2AE00),
      actionHighlighted: Color(0xFF5340BE),
      disabled: Color(0xFF2B2B35),
      actionOutline: Color(0xFF4E4E5C),
      primary: Color(0xFFCDCED8),
      success: Color(0xFF183A17),
      warning: Color(0xFFF58A1F),
      danger: Color(0xFFD24446),
      dangerHighlighted: Color(0xFF4D1819),
      yellow: Color(0xFFF2AE00),
      actionFitness: Color(0xFF3DB8DA),
    ),
    seed: Color(0xFF6E56F0),
  );

  static AppColorPalette of(BuildContext context) {
    return byBrightness(Theme.of(context).brightness);
  }

  static Brightness? _brightnessOverride;

  static AppColorPalette get theme {
    return byBrightness(
      _brightnessOverride ?? PlatformDispatcher.instance.platformBrightness,
    );
  }

  static void setBrightnessOverride(Brightness? brightness) {
    _brightnessOverride = brightness;
  }

  static AppColorPalette byBrightness(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }
}

@immutable
class AppColorPrimitives {
  const AppColorPrimitives({
    required this.primary,
    required this.neutral,
    required this.accent01,
    required this.accent02,
    required this.failure,
    required this.success,
    required this.warning,
    required this.mint,
  });

  final AppColorRamp primary;
  final AppColorRamp neutral;
  final AppColorRamp accent01;
  final AppColorRamp accent02;
  final AppColorRamp failure;
  final AppColorRamp success;
  final AppColorRamp warning;
  final AppColorRamp mint;
}

@immutable
class AppColorRamp {
  const AppColorRamp({
    required this.shade100,
    required this.shade200,
    required this.shade300,
    required this.shade400,
    required this.shade500,
    required this.shade600,
    required this.shade700,
    required this.shade800,
    required this.shade900,
  });

  final Color shade100;
  final Color shade200;
  final Color shade300;
  final Color shade400;
  final Color shade500;
  final Color shade600;
  final Color shade700;
  final Color shade800;
  final Color shade900;
}

@immutable
class AppSemanticColorTokens {
  const AppSemanticColorTokens({
    required this.background,
    required this.surface,
    required this.text,
    required this.border,
    required this.action,
    required this.status,
  });

  final AppSemanticBackgroundColors background;
  final AppSemanticSurfaceColors surface;
  final AppSemanticTextColors text;
  final AppSemanticBorderColors border;
  final AppSemanticActionColors action;
  final AppSemanticStatusColors status;
}

@immutable
class AppSemanticBackgroundColors {
  const AppSemanticBackgroundColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.inverse,
    required this.disabled,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color inverse;
  final Color disabled;
}

@immutable
class AppSemanticSurfaceColors {
  const AppSemanticSurfaceColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.inverse,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color inverse;
}

@immutable
class AppSemanticTextColors {
  const AppSemanticTextColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.inverse,
    required this.disabled,
    required this.link,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color inverse;
  final Color disabled;
  final Color link;
}

@immutable
class AppSemanticBorderColors {
  const AppSemanticBorderColors({
    required this.primary,
    required this.secondary,
    required this.strong,
    required this.disabled,
  });

  final Color primary;
  final Color secondary;
  final Color strong;
  final Color disabled;
}

@immutable
class AppSemanticActionColors {
  const AppSemanticActionColors({
    required this.primary,
    required this.primaryHover,
    required this.primaryPressed,
    required this.primaryDisabled,
    required this.secondary,
    required this.secondaryHover,
    required this.secondaryPressed,
    required this.secondaryDisabled,
  });

  final Color primary;
  final Color primaryHover;
  final Color primaryPressed;
  final Color primaryDisabled;
  final Color secondary;
  final Color secondaryHover;
  final Color secondaryPressed;
  final Color secondaryDisabled;
}

@immutable
class AppSemanticStatusColors {
  const AppSemanticStatusColors({
    required this.success,
    required this.successBackground,
    required this.failure,
    required this.failureBackground,
    required this.warning,
    required this.warningBackground,
    required this.info,
    required this.infoBackground,
  });

  final Color success;
  final Color successBackground;
  final Color failure;
  final Color failureBackground;
  final Color warning;
  final Color warningBackground;
  final Color info;
  final Color infoBackground;
}

@immutable
class AppStandaloneColorAliases {
  const AppStandaloneColorAliases({
    required this.failure,
    required this.success,
  });

  final Color failure;
  final Color success;
}

extension AppColorsBuildContextX on BuildContext {
  AppColorPalette get appColors => AppColors.of(this);
}

@immutable
class AppColorPalette {
  const AppColorPalette({
    required this.text,
    required this.surface,
    required this.icon,
    required this.border,
    required this.seed,
  });

  final AppTextColors text;
  final AppSurfaceColors surface;
  final AppIconColors icon;
  final AppBorderColors border;
  final Color seed;
}

@immutable
class AppTextColors {
  const AppTextColors({
    required this.heading,
    required this.body,
    required this.caption,
    required this.primary,
    required this.onAction,
    required this.action,
    required this.actionHover,
    required this.actionPressed,
    required this.onActionHover,
    required this.onActionPressed,
    required this.disabled,
    required this.success,
    required this.warning,
    required this.danger,
    required this.onActionLight,
    required this.actionFitness,
    required this.deliveryAction,
    required this.deliveryActionHover,
  });

  final Color heading;
  final Color body;
  final Color caption;
  final Color primary;
  final Color onAction;
  final Color action;
  final Color actionHover;
  final Color actionPressed;
  final Color onActionHover;
  final Color onActionPressed;
  final Color disabled;
  final Color success;
  final Color warning;
  final Color danger;
  final Color onActionLight;
  final Color actionFitness;
  final Color deliveryAction;
  final Color deliveryActionHover;
}

@immutable
class AppSurfaceColors {
  const AppSurfaceColors({
    required this.bg,
    required this.primary,
    required this.action,
    required this.actionHover,
    required this.actionPressed,
    required this.actionSecondary,
    required this.actionSecondaryPressed,
    required this.actionSecondaryHover,
    required this.actionDisabled,
    required this.actionSecondaryCard,
    required this.actionSecondaryHighlighted,
    required this.actionHighlighted,
    required this.actionCard,
    required this.decorative01,
    required this.decorative01Highlighted,
    required this.decorative01Card,
    required this.decorative02,
    required this.decorative02Highlighted,
    required this.decorative02Card,
    required this.decorative03,
    required this.decorative03Highlighted,
    required this.decorative03Card,
    required this.success,
    required this.successHighlighted,
    required this.warning,
    required this.warningHighlighted,
    required this.danger,
    required this.dangerHighlighted,
    required this.dangerPressed,
    required this.dangerHover,
    required this.disabled,
    required this.transparent,
    required this.natural200,
    required this.inputFlatListPrimary,
    required this.neutral900,
    required this.actionFitness,
    required this.deliveryAction,
    required this.deliveryActionHover,
  });

  final Color bg;
  final Color primary;
  final Color action;
  final Color actionHover;
  final Color actionPressed;
  final Color actionSecondary;
  final Color actionSecondaryPressed;
  final Color actionSecondaryHover;
  final Color actionDisabled;
  final Color actionSecondaryCard;
  final Color actionSecondaryHighlighted;
  final Color actionHighlighted;
  final Color actionCard;
  final Color decorative01;
  final Color decorative01Highlighted;
  final Color decorative01Card;
  final Color decorative02;
  final Color decorative02Highlighted;
  final Color decorative02Card;
  final Color decorative03;
  final Color decorative03Highlighted;
  final Color decorative03Card;
  final Color success;
  final Color successHighlighted;
  final Color warning;
  final Color warningHighlighted;
  final Color danger;
  final Color dangerHighlighted;
  final Color dangerPressed;
  final Color dangerHover;
  final Color disabled;
  final Color transparent;
  final Color natural200;
  final Color inputFlatListPrimary;
  final Color neutral900;
  final Color actionFitness;
  final Color deliveryAction;
  final Color deliveryActionHover;
}

@immutable
class AppIconColors {
  const AppIconColors({
    required this.primary,
    required this.secondary,
    required this.action,
    required this.action2,
    required this.disabled,
    required this.onAction,
    required this.onActionSecondary,
    required this.success,
    required this.warning,
    required this.danger,
    required this.decorative02,
    required this.decorative02Pressed,
    required this.decorative01Pressed,
    required this.actionFitness,
    required this.actionPressed,
    required this.black,
    required this.deliveryAction,
    required this.deliveryActionHover,
  });

  final Color primary;
  final Color secondary;
  final Color action;
  final Color action2;
  final Color disabled;
  final Color onAction;
  final Color onActionSecondary;
  final Color success;
  final Color warning;
  final Color danger;
  final Color decorative02;
  final Color decorative02Pressed;
  final Color decorative01Pressed;
  final Color actionFitness;
  final Color actionPressed;
  final Color black;
  final Color deliveryAction;
  final Color deliveryActionHover;
}

@immutable
class AppBorderColors {
  const AppBorderColors({
    required this.action,
    required this.actionSecondary,
    required this.actionHighlighted,
    required this.disabled,
    required this.actionOutline,
    required this.primary,
    required this.success,
    required this.warning,
    required this.danger,
    required this.dangerHighlighted,
    required this.yellow,
    required this.actionFitness,
  });

  final Color action;
  final Color actionSecondary;
  final Color actionHighlighted;
  final Color disabled;
  final Color actionOutline;
  final Color primary;
  final Color success;
  final Color warning;
  final Color danger;
  final Color dangerHighlighted;
  final Color yellow;
  final Color actionFitness;
}
