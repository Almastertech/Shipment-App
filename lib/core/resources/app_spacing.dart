import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  // Shared design-system scale (Primitive/Spacing -> Token/Spacing).
  // The XS value is the documented 4px micro-spacing exception; the rest of
  // the scale continues in 8px increments.
  static const double tokenNone = 0;
  static const double tokenXs = 4;
  static const double tokenS = 8;
  static const double tokenM = 16;
  static const double tokenL = 24;
  static const double tokenXl = 32;
  static const double token2Xl = 40;
  static const double token3Xl = 48;
  static const double token4Xl = 56;
  static const double token5Xl = 64;
  static const double token6Xl = 72;
  static const double token7Xl = 80;
  static const double token8Xl = 88;
  static const double token9Xl = 96;
  static const double token10Xl = 104;
  static const double token11Xl = 112;
  static const double token12Xl = 120;

  // Platform layout aliases from the design reference. These reuse the shared
  // scale instead of introducing platform-specific spacing values.
  static const double buyerMobileHorizontalPadding = tokenL;
  static const double buyerMobileContentGap = tokenM;
  static const double buyerMobileSectionGap = token3Xl;
  static const double buyerMobileColumnGap = tokenM;

  static const double websiteDesktopHorizontalPadding = token3Xl;
  static const double websiteDesktopSectionGap = token9Xl;
  static const double websiteDesktopColumnGap = tokenL;
  static const double websiteDesktopGridGutter = tokenL;

  static const double websiteMobileHorizontalPadding = tokenL;
  static const double websiteMobileSectionGap = token4Xl;
  static const double websiteMobileColumnGap = tokenM;
  static const double websiteMobileGridGutter = tokenM;

  static const double adminDashboardContentPadding = tokenL;
  static const double adminDashboardSectionGap = tokenXl;
  static const double adminDashboardColumnGap = tokenM;
  static const double adminDashboardGridGutter = tokenM;

  // Existing app aliases retained to avoid changing current layouts at once.
  static const double xxs = 4;
  static const double xs = 8;
  static const double s = 10;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl2 = 28;
  static const double xxl = 32;

  // Legacy aliases for smooth migration from ValuesManager.
  static const double p4 = xxs;
  static const double p8 = xs;
  static const double p10 = s;
  static const double p12 = sm;
  static const double p16 = md;
  static const double p20 = lg;
  static const double p24 = xl;
  static const double p28 = xxl2;
  static const double p32 = xxl;

  static const EdgeInsets screen = EdgeInsets.all(md);
  static const EdgeInsets card = EdgeInsets.all(md);
  static const EdgeInsets cardLarge = EdgeInsets.all(xl);
}
