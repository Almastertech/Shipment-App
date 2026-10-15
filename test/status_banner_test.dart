import 'package:flutter/material.dart';
import 'package:shipments/components/feedback/status_banner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('StatusBanner renders message and action callback',
      (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatusBanner(
            title: 'Info',
            message: 'Banner message',
            type: StatusBannerType.info,
            actionLabel: 'Action',
            onAction: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Banner message'), findsOneWidget);
    await tester.tap(find.text('Action'));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
