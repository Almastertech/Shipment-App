import 'package:flutter/material.dart';
import 'package:shipments/components/empty_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EmptyState supports primary and secondary actions',
      (tester) async {
    var primaryTapped = false;
    var secondaryTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmptyState(
            title: 'No data',
            description: 'Try again',
            primaryActionLabel: 'Retry',
            onPrimaryAction: () {
              primaryTapped = true;
            },
            secondaryActionLabel: 'Reset',
            onSecondaryAction: () {
              secondaryTapped = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Retry'));
    await tester.pump();
    await tester.tap(find.text('Reset'));
    await tester.pump();

    expect(primaryTapped, isTrue);
    expect(secondaryTapped, isTrue);
  });
}
