import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/components/secondary_request_custom_card.dart';
import 'package:shipments/l10n/app_localizations.dart';

void main() {
  testWidgets('SecondaryRequestCustomCard renders steps without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('ar'),
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: <Locale>[
          Locale('en'),
          Locale('ar'),
        ],
        home: Scaffold(
          body: SingleChildScrollView(
            child: SecondaryRequestCustomCard(
              requestNumber: 'HS-2048',
              requestType: 'مطالبة',
              remainingTimeLabel: 'خلال ٢-٣ أيام',
              title: 'عطر رجالي 100 مل',
              description: 'نراجع الحين صورة وتفاصيل مطالبتك',
              progressSteps: <String>[
                'استلمناها',
                'نراجعها',
                'القرار',
                'التعويض',
              ],
              activeStepIndex: 1,
              amountLabel: 'قيمة الطلب',
              amount: '480 ر.س',
              actionLabel: 'تابع المطالبة',
              onTap: () {},
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('استلمناها'), findsOneWidget);
    expect(find.text('نراجعها'), findsOneWidget);
    expect(find.text('القرار'), findsOneWidget);
    expect(find.text('التعويض'), findsOneWidget);
  });
}
