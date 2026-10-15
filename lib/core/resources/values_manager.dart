import 'app_icon_size.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

@Deprecated(
  'Use AppSpacing/AppRadius/AppIconSize from lib/themes directly.',
)
class ValuesManager {
  // Spacing aliases
  static const double p4 = AppSpacing.p4;
  static const double p8 = AppSpacing.p8;
  static const double p10 = AppSpacing.p10;
  static const double p12 = AppSpacing.p12;
  static const double p16 = AppSpacing.p16;
  static const double p20 = AppSpacing.p20;
  static const double p24 = AppSpacing.p24;
  static const double p28 = AppSpacing.p28;
  static const double p32 = AppSpacing.p32;

  // Radius aliases
  static const double r8 = AppRadius.r8;
  static const double r12 = AppRadius.r12;
  static const double r16 = AppRadius.r16;
  static const double r20 = AppRadius.r20;
  static const double r24 = AppRadius.r24;

  // Icon-size aliases
  static const double iconS = AppIconSize.iconS;
  static const double iconM = AppIconSize.iconM;
  static const double iconL = AppIconSize.iconL;
}
