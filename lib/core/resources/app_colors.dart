import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  /// Primitive ramps and semantic aliases from the product design system.
  ///
  /// These tokens are additive; the legacy light/dark palettes below remain
  /// available while screens are migrated to the new design system.
  static const AppColorPrimitives primitives = AppColorPrimitives(
    primary: AppColorRamp(
      shade100: Color(0xFFF3F5FB),
      shade200: Color(0xFFDEE5F5),
      shade300: Color(0xFFB6C7E9),
      shade400: Color(0xFF7896D6),
      shade500: Color(0xFF2F5EC0),
      shade600: Color(0xFF2850A3),
      shade700: Color(0xFF214286),
      shade800: Color(0xFF182F60),
      shade900: Color(0xFF0D1A36),
    ),
    neutral: AppColorRamp(
      shade100: Color(0xFFF9FAFA),
      shade200: Color(0xFFE9E9EA),
      shade300: Color(0xFFB1B2B7),
      shade400: Color(0xFF585A64),
      shade500: Color(0xFF202330),
      shade600: Color(0xFF1B1E29),
      shade700: Color(0xFF161922),
      shade800: Color(0xFF101219),
      shade900: Color(0xFF090A0D),
    ),
    accent01: AppColorRamp(
      shade100: Color(0xFFFEFFFA),
      shade200: Color(0xFFFBFEF1),
      shade300: Color(0xFFF7FDE0),
      shade400: Color(0xFFF0FBC6),
      shade500: Color(0xFFE8F9A7),
      shade600: Color(0xFFA2AE75),
      shade700: Color(0xFF68704B),
      shade800: Color(0xFF3A3E2A),
      shade900: Color(0xFF1C1E14),
    ),
    accent02: AppColorRamp(
      shade100: Color(0xFFFCFCFB),
      shade200: Color(0xFFF6F7F3),
      shade300: Color(0xFFEBEDE6),
      shade400: Color(0xFFD9DDD0),
      shade500: Color(0xFFC5CBB7),
      shade600: Color(0xFF8A8E80),
      shade700: Color(0xFF595B52),
      shade800: Color(0xFF31332E),
      shade900: Color(0xFF181816),
    ),
    failure: AppColorRamp(
      shade100: Color(0xFFFCF4F4),
      shade200: Color(0xFFF8E1E1),
      shade300: Color(0xFFEFBEBE),
      shade400: Color(0xFFE28587),
      shade500: Color(0xFFD24446),
      shade600: Color(0xFFB33A3C),
      shade700: Color(0xFF933031),
      shade800: Color(0xFF692223),
      shade900: Color(0xFF3B1314),
    ),
    success: AppColorRamp(
      shade100: Color(0xFFF1F9F0),
      shade200: Color(0xFFD3EDD2),
      shade300: Color(0xFFB4E0B4),
      shade400: Color(0xFF96D595),
      shade500: Color(0xFF78C877),
      shade600: Color(0xFF52B850),
      shade700: Color(0xFF388737),
      shade800: Color(0xFF2C682A),
      shade900: Color(0xFF1F4A1E),
    ),
  );

  static final AppSemanticColorTokens semantic = AppSemanticColorTokens(
    background: AppSemanticBackgroundColors(
      primary: primitives.neutral.shade100,
      secondary: primitives.neutral.shade200,
      tertiary: primitives.neutral.shade300,
      inverse: primitives.neutral.shade500,
      disabled: primitives.neutral.shade200,
    ),
    surface: AppSemanticSurfaceColors(
      primary: primitives.neutral.shade100,
      secondary: primitives.neutral.shade200,
      tertiary: primitives.neutral.shade300,
      inverse: primitives.neutral.shade500,
    ),
    text: AppSemanticTextColors(
      primary: primitives.neutral.shade500,
      secondary: primitives.neutral.shade400,
      tertiary: primitives.neutral.shade400,
      inverse: primitives.neutral.shade100,
      disabled: primitives.neutral.shade300,
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
      success: primitives.success.shade500,
      successBackground: primitives.success.shade100,
      failure: primitives.failure.shade500,
      failureBackground: primitives.failure.shade100,
      warning: primitives.accent01.shade800,
      warningBackground: primitives.accent01.shade100,
      info: primitives.primary.shade500,
      infoBackground: primitives.primary.shade100,
    ),
  );

  /// Compatibility aliases that exist separately from the Token/Color paths.
  static final AppStandaloneColorAliases aliases = AppStandaloneColorAliases(
    failure: primitives.failure.shade500,
    success: primitives.success.shade500,
  );

  static const AppColorPalette light = AppColorPalette(
    text: AppTextColors(
      heading: Color(0xFF272A2A),
      body: Color(0xFF5A6161),
      caption: Color(0xFF878C8C),
      primary: Color(0xFF98A222),
      onAction: Color(0xFF0047BB),
      action: Color(0xFF0047BB),
      actionHover: Color(0xFF2E68C9),
      actionPressed: Color(0xFF003996),
      onActionHover: Color(0xFF2E68C9),
      onActionPressed: Color(0xFF003996),
      disabled: Color(0xFFB5B8B8),
      success: Color(0xFF0C9D61),
      warning: Color(0xFFFE9B0E),
      danger: Color(0xFFEC2D30),
      onActionLight: Color(0xFFFCFCFC),
      actionFitness: Color(0xFFFF5733),
      deliveryAction: Color(0xFF4A7C59),
      deliveryActionHover: Color(0xFF5B996E),
    ),
    surface: AppSurfaceColors(
      bg: Color(0xFFFCFCFC),
      primary: Color(0xFFF6F6F6),
      action: Color(0xFFBECB2A),
      actionHover: Color(0xFFCBD555),
      actionPressed: Color(0xFF98A222),
      actionSecondary: Color(0xFF0047BB),
      actionSecondaryPressed: Color(0xFF003996),
      actionSecondaryHover: Color(0xFF2E68C9),
      actionDisabled: Color(0xFFD3D5D5),
      actionSecondaryCard: Color(0xFFE4EEFF),
      actionSecondaryHighlighted: Color(0xFFCDDDF8),
      actionHighlighted: Color(0xFFD8E07F),
      actionCard: Color(0xFFF2F5D4),
      decorative01: Color(0xFFB0E8DB),
      decorative01Highlighted: Color(0xFF92CBBE),
      decorative01Card: Color(0xFFE7F8F4),
      decorative02: Color(0xFFD3A5E5),
      decorative02Highlighted: Color(0xFFB588C6),
      decorative02Card: Color(0xFFEDDBF5),
      decorative03: Color(0xFFF07CA3),
      decorative03Highlighted: Color(0xFFE62465),
      decorative03Card: Color(0xFFFAD3E0),
      success: Color(0xFF47B881),
      successHighlighted: Color(0xFFF5FBF8),
      warning: Color(0xFFFFAD0D),
      warningHighlighted: Color(0xFFFFFAEF),
      danger: Color(0xFFC01114),
      dangerHighlighted: Color(0xFFFFF2F3),
      dangerPressed: Color(0xFFEB6F70),
      dangerHover: Color(0xFFEC2D30),
      disabled: Color(0xFFF6F6F6),
      transparent: Colors.transparent,
      natural200: Color(0xFFF2F3F3),
      inputFlatListPrimary: Color(0xFFFBFBFB),
      neutral900: Color(0xFF191818),
      actionFitness: Color(0xFFFF5733),
      deliveryAction: Color(0xFF4A7C59),
      deliveryActionHover: Color(0xFF5B996E),
    ),
    icon: AppIconColors(
      primary: Color(0xFF272A2A),
      secondary: Color(0xFF878C8C),
      action: Color(0xFFFCFCFC),
      action2: Color(0xFF0047BB),
      disabled: Color(0xFFB5B8B8),
      onAction: Color(0xFFBECB2A),
      onActionSecondary: Color(0xFF0047BB),
      success: Color(0xFF47B881),
      warning: Color(0xFFFFAD0D),
      danger: Color(0xFFEC2D30),
      decorative02: Color(0xFFD3A5E5),
      decorative02Pressed: Color(0xFF794F89),
      decorative01Pressed: Color(0xFF559183),
      actionFitness: Color(0xFFFF5733),
      actionPressed: Color(0xFF727A19),
      black: Color(0xFF000000),
      deliveryAction: Color(0xFF4A7C59),
      deliveryActionHover: Color(0xFF5B996E),
    ),
    border: AppBorderColors(
      action: Color(0xFFBECB2A),
      actionSecondary: Color(0xFF0047BB),
      actionHighlighted: Color(0xFFCDDDF8),
      disabled: Color(0xFFB5B8B8),
      actionOutline: Color(0xFFD3D5D5),
      primary: Color(0xFFFCFCFC),
      success: Color(0xFFC0E5D1),
      warning: Color(0xFFFFEAB3),
      danger: Color(0xFFEC2D30),
      dangerHighlighted: Color(0xFFFFCCD2),
      yellow: Color(0xFFCFCF15),
      actionFitness: Color(0xFFFF5733),
    ),
    seed: Color(0xFFBECB2A),
  );

  static const AppColorPalette dark = AppColorPalette(
    text: AppTextColors(
      heading: Color(0xFFFCFCFC),
      body: Color(0xFFD3D5D5),
      caption: Color(0xFFB5B8B8),
      primary: Color(0xFFCBD555),
      onAction: Color(0xFF0047BB),
      action: Color(0xFFBECB2A),
      actionHover: Color(0xFF2E68C9),
      actionPressed: Color(0xFF003996),
      onActionHover: Color(0xFF2E68C9),
      onActionPressed: Color(0xFF003996),
      disabled: Color(0xFF878C8C),
      success: Color(0xFF97D4B4),
      warning: Color(0xFFFFDD82),
      danger: Color(0xFFEC2D30),
      onActionLight: Color(0xFFFCFCFC),
      actionFitness: Color(0xFFFF5733),
      deliveryAction: Color(0xFF4A7C59),
      deliveryActionHover: Color(0xFF5B996E),
    ),
    surface: AppSurfaceColors(
      bg: Color(0xFF191818),
      primary: Color(0xFF272A2A),
      action: Color(0xFFBECB2A),
      actionHover: Color(0xFFCBD555),
      actionPressed: Color(0xFF98A222),
      actionSecondary: Color(0xFF0047BB),
      actionSecondaryPressed: Color(0xFF003996),
      actionSecondaryHover: Color(0xFF2E68C9),
      actionDisabled: Color(0xFF454A4A),
      actionSecondaryCard: Color(0xFF001C4B),
      actionSecondaryHighlighted: Color(0xFF002B70),
      actionHighlighted: Color(0xFF4C5111),
      actionCard: Color(0xFF727A19),
      decorative01: Color(0xFFB0E8DB),
      decorative01Highlighted: Color(0xFF92CBBE),
      decorative01Card: Color(0xFF559183),
      decorative02: Color(0xFFD3A5E5),
      decorative02Highlighted: Color(0xFFE5C9EF),
      decorative02Card: Color(0xFF6A417A),
      decorative03: Color(0xFFF07CA3),
      decorative03Highlighted: Color(0xFFF7BDD1),
      decorative03Card: Color(0xFFB81D51),
      success: Color(0xFF0C9D61),
      successHighlighted: Color(0xFF043722),
      warning: Color(0xFFFE9B0E),
      warningHighlighted: Color(0xFFFFAD0D),
      danger: Color(0xFFEC2D30),
      dangerHighlighted: Color(0xFF6F0B0D),
      dangerPressed: Color(0xFFFFF2F3),
      dangerHover: Color(0xFFEC2D30),
      disabled: Color(0xFF272A2A),
      transparent: Colors.transparent,
      natural200: Color(0xFFF2F3F3),
      inputFlatListPrimary: Color(0xFFFBFBFB),
      neutral900: Color(0xFF191818),
      actionFitness: Color(0xFFFF5733),
      deliveryAction: Color(0xFF4A7C59),
      deliveryActionHover: Color(0xFF5B996E),
    ),
    icon: AppIconColors(
      primary: Color(0xFFFCFCFC),
      secondary: Color(0xFFD3D5D5),
      action: Color(0xFFFCFCFC),
      action2: Color(0xFFBECB2A),
      disabled: Color(0xFFB5B8B8),
      onAction: Color(0xFFBECB2A),
      onActionSecondary: Color(0xFF0047BB),
      success: Color(0xFF47B881),
      warning: Color(0xFFFFAD0D),
      danger: Color(0xFFEC2D30),
      decorative02: Color(0xFFD3A5E5),
      decorative02Pressed: Color(0xFFE5C9EF),
      decorative01Pressed: Color(0xFFB0E8DB),
      actionFitness: Color(0xFFFF5733),
      actionPressed: Color(0xFFD8E07F),
      black: Color(0xFF000000),
      deliveryAction: Color(0xFF4A7C59),
      deliveryActionHover: Color(0xFF5B996E),
    ),
    border: AppBorderColors(
      action: Color(0xFFBECB2A),
      actionSecondary: Color(0xFF2E68C9),
      actionHighlighted: Color(0xFF0047BB),
      disabled: Color(0xFF272A2A),
      actionOutline: Color(0xFF454A4A),
      primary: Color(0xFFD3D5D5),
      success: Color(0xFF043722),
      warning: Color(0xFFFE9B0E),
      danger: Color(0xFFEC2D30),
      dangerHighlighted: Color(0xFF6F0B0D),
      yellow: Color(0xFFCFCF15),
      actionFitness: Color(0xFFFF5733),
    ),
    seed: Color(0xFFBECB2A),
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
  });

  final AppColorRamp primary;
  final AppColorRamp neutral;
  final AppColorRamp accent01;
  final AppColorRamp accent02;
  final AppColorRamp failure;
  final AppColorRamp success;
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
