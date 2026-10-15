import 'package:flutter/material.dart';
import 'package:shipments/components/feedback/toast_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OverlayToastService', () {
    testWidgets('shows toast overlay', (tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      final service = OverlayToastService(navigatorKey: navigatorKey);

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: const Scaffold(body: SizedBox.shrink()),
        ),
      );

      service.info('Hello toast', duration: const Duration(milliseconds: 300));
      await tester.pump();

      expect(find.text('Hello toast'), findsOneWidget);
    });
  });
}
