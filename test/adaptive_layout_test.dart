import 'package:flutter/widgets.dart';
import 'package:shipments/core/resources/adaptive_layout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdaptiveLayoutData', () {
    test('maps compact width to mobile + compact class', () {
      const adaptive = AdaptiveLayoutData(
        size: Size(390, 844),
        orientation: Orientation.portrait,
      );

      expect(adaptive.isMobile, isTrue);
      expect(adaptive.windowSizeClass, WindowSizeClass.compact);
      expect(adaptive.prefersTwoPane, isFalse);
      expect(adaptive.horizontalPadding, 16);
    });

    test('maps medium width to tablet + medium class', () {
      const adaptive = AdaptiveLayoutData(
        size: Size(768, 1024),
        orientation: Orientation.portrait,
      );

      expect(adaptive.isTablet, isTrue);
      expect(adaptive.windowSizeClass, WindowSizeClass.medium);
      expect(adaptive.prefersTwoPane, isTrue);
      expect(adaptive.horizontalPadding, 24);
    });

    test('maps expanded width to desktop + expanded class', () {
      const adaptive = AdaptiveLayoutData(
        size: Size(1366, 768),
        orientation: Orientation.landscape,
      );

      expect(adaptive.isDesktop, isTrue);
      expect(adaptive.windowSizeClass, WindowSizeClass.expanded);
      expect(adaptive.prefersTwoPane, isTrue);
      expect(adaptive.horizontalPadding, 32);
      expect(adaptive.isLandscape, isTrue);
    });

    test('select picks class-specific values with safe fallback', () {
      const compact = AdaptiveLayoutData(
        size: Size(390, 844),
        orientation: Orientation.portrait,
      );
      const medium = AdaptiveLayoutData(
        size: Size(768, 1024),
        orientation: Orientation.portrait,
      );
      const expanded = AdaptiveLayoutData(
        size: Size(1366, 768),
        orientation: Orientation.landscape,
      );

      expect(compact.select(compact: 1, medium: 2, expanded: 3), 1);
      expect(medium.select(compact: 1, medium: 2, expanded: 3), 2);
      expect(expanded.select(compact: 1, medium: 2, expanded: 3), 3);
      expect(expanded.select(compact: 1), 1);
    });
  });
}
