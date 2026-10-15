import 'package:shipments/core/routing/app_routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sampleDetailsPath URI-encodes route parameter', () {
    final path = AppRoutes.sampleDetailsPath('id/with spaces');
    expect(path, '/sample/id%2Fwith%20spaces');
  });
}
