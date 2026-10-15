import 'package:flutter/widgets.dart';

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

enum WindowSizeClass {
  compact,
  medium,
  expanded,
}

class AdaptiveBreakpoints {
  AdaptiveBreakpoints._();

  static const double compactMax = 599;
  static const double mediumMax = 839;
  static const double tablet = 700;
  static const double desktop = 1100;
}

class AdaptiveLayoutData {
  const AdaptiveLayoutData({
    required this.size,
    required this.orientation,
  });

  factory AdaptiveLayoutData.fromContext(BuildContext context) {
    return AdaptiveLayoutData(
      size: MediaQuery.sizeOf(context),
      orientation: MediaQuery.orientationOf(context),
    );
  }

  final Size size;
  final Orientation orientation;

  double get width => size.width;
  double get height => size.height;

  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  WindowSizeClass get windowSizeClass {
    if (width <= AdaptiveBreakpoints.compactMax) {
      return WindowSizeClass.compact;
    }
    if (width <= AdaptiveBreakpoints.mediumMax) {
      return WindowSizeClass.medium;
    }
    return WindowSizeClass.expanded;
  }

  DeviceType get deviceType {
    if (width >= AdaptiveBreakpoints.desktop) {
      return DeviceType.desktop;
    }
    if (width >= AdaptiveBreakpoints.tablet) {
      return DeviceType.tablet;
    }
    return DeviceType.mobile;
  }

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;

  bool get isCompact => windowSizeClass == WindowSizeClass.compact;
  bool get isMedium => windowSizeClass == WindowSizeClass.medium;
  bool get isExpanded => windowSizeClass == WindowSizeClass.expanded;

  bool get prefersTwoPane => isMedium || isExpanded;

  double get maxContentWidth {
    return switch (windowSizeClass) {
      WindowSizeClass.compact => double.infinity,
      WindowSizeClass.medium => 1024,
      WindowSizeClass.expanded => 1320,
    };
  }

  double get horizontalPadding {
    return switch (windowSizeClass) {
      WindowSizeClass.compact => 16,
      WindowSizeClass.medium => 24,
      WindowSizeClass.expanded => 32,
    };
  }

  double get verticalPadding {
    return switch (windowSizeClass) {
      WindowSizeClass.compact => 16,
      WindowSizeClass.medium => 20,
      WindowSizeClass.expanded => 24,
    };
  }

  double get paneSpacing {
    return switch (windowSizeClass) {
      WindowSizeClass.compact => 12,
      WindowSizeClass.medium => 16,
      WindowSizeClass.expanded => 24,
    };
  }

  T select<T>({
    required T compact,
    T? medium,
    T? expanded,
  }) {
    return switch (windowSizeClass) {
      WindowSizeClass.compact => compact,
      WindowSizeClass.medium => medium ?? compact,
      WindowSizeClass.expanded => expanded ?? medium ?? compact,
    };
  }
}

extension AdaptiveLayoutContext on BuildContext {
  AdaptiveLayoutData get adaptiveLayout => AdaptiveLayoutData.fromContext(this);
}
