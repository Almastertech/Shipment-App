import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/shipments/widgets/custom_product_card_shipments.dart';

void main() {
  testWidgets(
      'CustomProductCardShipments renders all elements cleanly matching design',
      (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    var actionTapped = false;
    var cardTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('ar'),
        ],
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomProductCardShipments(
              productTitle: 'ساعة ذكية — إصدار ذهبي',
              storeName: 'متجر جرير',
              price: '320 ر.س',
              protectionLabel: 'محمية بحصين',
              statusLabel: 'بالطريق',
              trackingLabel: 'رقم التتبع',
              trackingNumber: 'HS-2048',
              deliveryDateLabel: 'توصلك',
              deliveryDate: 'الجمعة 1 أكتوبر',
              actionLabel: 'التفاصيل',
              onAction: () => actionTapped = true,
              onTap: () => cardTapped = true,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('ساعة ذكية — إصدار ذهبي'), findsOneWidget);
    expect(find.text('متجر جرير • 320 ر.س'), findsOneWidget);
    expect(find.text('محمية بحصين'), findsOneWidget);
    expect(find.text('بالطريق'), findsOneWidget);
    expect(find.text('رقم التتبع'), findsOneWidget);
    expect(find.text('HS-2048'), findsOneWidget);
    expect(find.text('توصلك'), findsOneWidget);
    expect(find.text('الجمعة 1 أكتوبر'), findsOneWidget);
    expect(find.text('التفاصيل'), findsOneWidget);

    // Tap action button
    await tester.tap(find.text('التفاصيل'));
    await tester.pumpAndSettle();
    expect(actionTapped, isTrue);

    // Tap card
    await tester.tap(find.text('ساعة ذكية — إصدار ذهبي'));
    await tester.pumpAndSettle();
    expect(cardTapped, isTrue);
  });
}
