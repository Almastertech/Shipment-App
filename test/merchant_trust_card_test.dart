import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/screens/merchant/widgets/merchant_trust_card.dart';

void main() {
  Widget buildCard({double textScaleFactor = 1.0}) {
    return MaterialApp(
      locale: const Locale('ar'),
      home: Scaffold(
        body: MediaQuery(
          data: MediaQueryData(
            size: const Size(390, 844),
            textScaler: TextScaler.linear(textScaleFactor),
          ),
          child: const SingleChildScrollView(
            child: ShopsTrustCard(
              title: 'شبكة المتاجر المعتمدة',
              description: 'جميع المتاجر تخضع للفحص والتحقق',
              partnersLabel: 'متجر شريك',
              categoriesLabel: 'فئات متنوعة',
              daysLabel: 'فترة التجربة',
              daysValue: '14 يوم',
              promise: 'ضمان استرداد كامل خلال 48 ساعة',
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('ShopsTrustCard renders all metrics and labels', (tester) async {
    await tester.pumpWidget(buildCard());
    await tester.pumpAndSettle();

    expect(find.text('+40'), findsOneWidget);
    expect(find.text('متجر شريك'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text('فئات متنوعة'), findsOneWidget);
    expect(find.text('14 يوم'), findsOneWidget);
    expect(find.text('فترة التجربة'), findsOneWidget);
  });

  testWidgets(
      'ShopsTrustCard does not overflow under large 1.75x text scale',
      (tester) async {
    await tester.pumpWidget(buildCard(textScaleFactor: 1.75));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('+40'), findsOneWidget);
    expect(find.text('متجر شريك'), findsOneWidget);
  });

  testWidgets(
      'ShopsTrustCard does not overflow under extreme 2.0x text scale',
      (tester) async {
    await tester.pumpWidget(buildCard(textScaleFactor: 2.0));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
