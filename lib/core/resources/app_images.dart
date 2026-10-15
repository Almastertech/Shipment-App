class AppImages {
  AppImages._();

  static const String _imagesBasePath = 'assets/images';
  static const String _svgBasePath = '$_imagesBasePath/svg';
  static const String _gifBasePath = 'assets/gif';
  static const String _lottieBasePath = 'assets/lottie';

  static const String bannerBackground =
      '$_imagesBasePath/png/bannerBackground.png';
  static const String secondaryBannerBackground =
      '$_imagesBasePath/png/secondarybanner.png';
  static const String shipmentBackground =
      '$_imagesBasePath/png/shipmentbackground.png';
  static const String logo = '$_svgBasePath/Logo.svg';
  static const String phoneIcon = '$_svgBasePath/phoneicon.svg';
  static const String wavesBackground = '$_svgBasePath/wavesbackground.svg';
  static const String marker = '$_svgBasePath/marker.svg';
  static const String markerCross = '$_svgBasePath/markercross.svg';

  static String image(String fileName) => '$_imagesBasePath/$fileName';

  static String svg(String fileName) => '$_svgBasePath/$fileName';

  static String gif(String fileName) => '$_gifBasePath/$fileName';

  static String lottie(String fileName) => '$_lottieBasePath/$fileName';

  static const String loading = 'assets/lottie/loading.json';
}
