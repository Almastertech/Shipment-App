import 'package:flutter/material.dart';
import 'package:shipments/components/layout/bottom_sheet_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BottomSheetService', () {
    testWidgets('showSelection returns selected value', (tester) async {
      final key = GlobalKey<NavigatorState>();
      final service = BottomSheetService(navigatorKey: key);

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: key,
          home: const Scaffold(body: SizedBox.shrink()),
        ),
      );

      final future = service.showSelection<String>(
        title: 'Select',
        options: const <BottomSheetOption<String>>[
          BottomSheetOption<String>(label: 'One', value: '1'),
          BottomSheetOption<String>(label: 'Two', value: '2'),
        ],
      );

      await tester.pumpAndSettle();
      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();

      expect(await future, '2');
    });

    testWidgets('showConfirmation returns true when confirmed', (tester) async {
      final key = GlobalKey<NavigatorState>();
      final service = BottomSheetService(navigatorKey: key);

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: key,
          home: const Scaffold(body: SizedBox.shrink()),
        ),
      );

      final future = service.showConfirmation(
        title: 'Confirm',
        message: 'Message',
      );

      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Confirm'));
      await tester.pumpAndSettle();

      expect(await future, isTrue);
    });
  });
}
