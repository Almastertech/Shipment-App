class AppRadius {
  AppRadius._();

  // Shared design-system scale (Primitive/Radius -> Token/Radius).
  static const double tokenNone = 0;
  static const double tokenXs = 2;
  static const double tokenS = 4;
  static const double tokenM = 8;
  static const double tokenL = 12;
  static const double tokenXl = 16;
  static const double token2Xl = 24;
  static const double token3Xl = 32;
  static const double tokenFull = 9999;

  // Existing app aliases retained to avoid changing current layouts at once.
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;

  // Legacy aliases for smooth migration from ValuesManager.
  static const double r8 = sm;
  static const double r12 = md;
  static const double r16 = lg;
  static const double r20 = xl;
  static const double r24 = xxl;

  static const double sheet = 24;
  static const double circle = tokenFull;
}
