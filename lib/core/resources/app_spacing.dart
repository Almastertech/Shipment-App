import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  // Primitive spacing scale from the design system.
  static const double tokenNone = 0;
  static const double token3Xs = 2;
  static const double token2Xs = 4;
  static const double tokenXs = 6;
  static const double tokenS = 8;
  static const double tokenM = 12;
  static const double tokenL = 16;
  static const double tokenXl = 20;
  static const double token2Xl = 24;
  static const double token3Xl = 32;
  static const double token3_5Xl = 36;
  static const double token4Xl = 40;
  static const double token4_5Xl = 44;
  static const double token5Xl = 48;
  static const double token5_5Xl = 52;
  static const double token6Xl = 56;
  static const double token7Xl = 64;
  static const double token8Xl = 80;
  static const double token9Xl = 96;
  static const double token10Xl = 120;
  static const double token10_5Xl = 140;
  static const double token11Xl = 160;

  // Platform layout tokens. Values follow the App, Web, and Dashboard columns
  // in the spacing reference.
  static const double appPageMargin = tokenL;
  static const double appSectionGap = token3Xl;
  static const double appGutter = tokenL;
  static const double appSidebarWidth = tokenNone;
  static const double appGapTight = tokenS;
  static const double appGapDefault = tokenM;
  static const double appGapRelaxed = tokenL;
  static const double appGapLoose = token2Xl;
  static const double appCardPadding = tokenL;
  static const double appControlPadding = tokenXl;

  static const double websiteDesktopPageMargin = token7Xl;
  static const double websiteDesktopSectionGap = token9Xl;
  static const double websiteDesktopGutter = token2Xl;
  static const double websiteDesktopGapTight = tokenS;
  static const double websiteDesktopGapDefault = tokenXl;
  static const double websiteDesktopGapRelaxed = token2Xl;
  static const double websiteDesktopGapLoose = token4Xl;
  static const double websiteDesktopCardPadding = token3Xl;
  static const double websiteDesktopControlPadding = token2Xl;

  static const double websiteMobilePageMargin = tokenXl;
  static const double websiteMobileSectionGap = token5Xl;
  static const double websiteMobileGutter = tokenL;
  static const double websiteMobileGapTight = tokenS;
  static const double websiteMobileGapDefault = tokenM;
  static const double websiteMobileGapRelaxed = tokenXl;
  static const double websiteMobileGapLoose = token2Xl;
  static const double websiteMobileCardPadding = token2Xl;
  static const double websiteMobileControlPadding = tokenXl;

  static const double adminDashboardPageMargin = token2Xl;
  static const double adminDashboardSectionGap = token3Xl;
  static const double adminDashboardGutter = token2Xl;
  static const double adminDashboardGapTight = token2Xs;
  static const double adminDashboardGapDefault = tokenS;
  static const double adminDashboardGapRelaxed = tokenM;
  static const double adminDashboardGapLoose = tokenL;
  static const double adminDashboardCardPadding = tokenL;
  static const double adminDashboardControlPadding = tokenL;
  static const double adminDashboardSidebarWidth = 256;

  // Existing platform aliases retained for current call sites.
  static const double buyerMobileHorizontalPadding = appPageMargin;
  static const double buyerMobileContentGap = appGapDefault;
  static const double buyerMobileSectionGap = appSectionGap;
  static const double buyerMobileColumnGap = appGutter;

  static const double websiteDesktopHorizontalPadding =
      websiteDesktopPageMargin;
  static const double websiteDesktopColumnGap = websiteDesktopGutter;
  static const double websiteDesktopGridGutter = websiteDesktopGutter;

  static const double websiteMobileHorizontalPadding = websiteMobilePageMargin;
  static const double websiteMobileColumnGap = websiteMobileGutter;
  static const double websiteMobileGridGutter = websiteMobileGutter;

  static const double adminDashboardContentPadding = adminDashboardPageMargin;
  static const double adminDashboardColumnGap = adminDashboardGutter;
  static const double adminDashboardGridGutter = adminDashboardGutter;

  // Short aliases used by existing widgets, mapped to the refreshed scale.
  static const double xxs = token2Xs;
  static const double xs = tokenXs;
  static const double s = tokenS;
  static const double sm = tokenM;
  static const double md = tokenL;
  static const double lg = tokenXl;
  static const double xl = token2Xl;
  static const double xxl2 = token3Xl;
  static const double xxl = token3Xl;

  // Legacy ValuesManager aliases.
  static const double p4 = xxs;
  static const double p8 = s;
  static const double p10 = 10;
  static const double p12 = sm;
  static const double p16 = md;
  static const double p20 = lg;
  static const double p24 = xl;
  static const double p28 = 28;
  static const double p32 = xxl;

  static const EdgeInsets screen = EdgeInsets.all(md);
  static const EdgeInsets card = EdgeInsets.all(appCardPadding);
  static const EdgeInsets cardLarge = EdgeInsets.all(xl);
}
