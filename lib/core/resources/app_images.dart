class AppImages {
  AppImages._();

  static const String _imagesBasePath = 'assets/images';
  static const String _svgBasePath = '$_imagesBasePath/svg';
  static const String _gifBasePath = 'assets/gif';
  static const String _lottieBasePath = 'assets/lottie';
  static const String _pngBasePath = '$_imagesBasePath/png';

  static const String splash = '$_pngBasePath/splash.png';
  static const String onboardingProtection = '$_pngBasePath/onboarding1.png';
  static const String onboardingTracking = '$_pngBasePath/onboarding2.png';
  static const String onboardingClaim = '$_pngBasePath/onboarding3.png';
  static const String verification = '$_pngBasePath/verification.png';

  static const String bannerBackground =
      '$_imagesBasePath/png/bannerBackground.png';
  static const String secondaryBannerBackground =
      '$_imagesBasePath/png/secondarybanner.png';
  static const String shipmentBackground =
      '$_imagesBasePath/png/shipmentbackground.png';
  static const String boxesStack = '$_pngBasePath/boxesstack.png';
  static const String riyadhCity = '$_pngBasePath/riyadhcity.png';
  static const String boxFocus = '$_pngBasePath/boxfocus.png';
  static const String logo = '$_svgBasePath/Logo.svg';
  static const String phoneIcon = '$_svgBasePath/phoneicon.svg';
  static const String wavesBackground = '$_svgBasePath/wavesbackground.svg';
  static const String marker = '$_svgBasePath/marker.svg';
  static const String markerCross = '$_svgBasePath/markercross.svg';

  // Product icon library (assets/images/svg).
  static const String receipt = '$_svgBasePath/receipt.svg';
  static const String receiptSolid = '$_svgBasePath/receipt-solid.svg';
  static const String shop = '$_svgBasePath/shop.svg';
  static const String shieldCheck = '$_svgBasePath/shield-check.svg';
  static const String user = '$_svgBasePath/user.svg';
  static const String envelope = '$_svgBasePath/envelope.svg';
  static const String redo = '$_svgBasePath/redo.svg';
  static const String search = '$_svgBasePath/search.svg';
  static const String bell = '$_svgBasePath/bell.svg';
  static const String timeQuarterTo = '$_svgBasePath/time-quarter-to.svg';
  static const String mapMarkerCross = '$_svgBasePath/map-marker-cross.svg';
  static const String camera = '$_svgBasePath/camera.svg';
  static const String crossSmall = '$_svgBasePath/cross-small.svg';
  static const String edit = '$_svgBasePath/edit.svg';
  static const String interrogation = '$_svgBasePath/interrogation.svg';
  static const String settings = '$_svgBasePath/settings.svg';
  static const String phoneCall = '$_svgBasePath/phone-call.svg';
  static const String shoppingBag = '$_svgBasePath/shopping-bag.svg';
  static const String chartBars = '$_svgBasePath/Chart.svg';
  static const String products = '$_svgBasePath/products.svg';
  static const String rectangle = '$_svgBasePath/Rectangle 1.svg';
  static const String vector = '$_svgBasePath/Vector 1.svg';

  static String image(String fileName) => '$_imagesBasePath/$fileName';

  static String svg(String fileName) => '$_svgBasePath/$fileName';

  static String gif(String fileName) => '$_gifBasePath/$fileName';

  static String lottie(String fileName) => '$_lottieBasePath/$fileName';

  static const String loading = 'assets/lottie/loading.json';
}
