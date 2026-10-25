import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shops hero image is bundled as a non-empty asset', (
    tester,
  ) async {
    final image = await rootBundle.load('assets/images/png/shops_hero.png');

    expect(image.lengthInBytes, greaterThan(0));
  });
}
