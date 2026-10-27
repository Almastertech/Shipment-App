import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/profile/widgets/profile_faq_widgets.dart';
import 'package:shipments/screens/profile/widgets/profile_legal_widgets.dart';

Widget _wrapWidget({required Widget child, Locale locale = const Locale('ar')}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(
      body: SingleChildScrollView(child: child),
    ),
  );
}

void main() {
  group('ProfileFaqWidgets Tests', () {
    testWidgets('ProfileFaqCategoryChip renders and handles tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrapWidget(
          child: ProfileFaqCategoryChip(
            label: 'الكل',
            selected: true,
            onTap: () => tapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('الكل'), findsOneWidget);
      await tester.tap(find.text('الكل'));
      expect(tapped, isTrue);
    });

    testWidgets('ProfileFaqQuestionCard toggles expansion and shows answer and steps', (tester) async {
      var isExpanded = false;
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return _wrapWidget(
              child: ProfileFaqQuestionCard(
                question: 'كيف أقدم مطالبة؟',
                answer: 'يمكنك تقديم مطالبة باتباع الخطوات التالية:',
                steps: const <String>['افتح الشحنة', 'اضغط على تقديم مطالبة'],
                note: 'ملاحظة: تنتهي صلاحية المطالبة بعد 14 يوم',
                expanded: isExpanded,
                onTap: () => setState(() => isExpanded = !isExpanded),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('كيف أقدم مطالبة؟'), findsOneWidget);
      // Not expanded yet
      expect(find.text('يمكنك تقديم مطالبة باتباع الخطوات التالية:'), findsNothing);

      // Tap to expand
      await tester.tap(find.text('كيف أقدم مطالبة؟'));
      await tester.pumpAndSettle();

      expect(find.text('يمكنك تقديم مطالبة باتباع الخطوات التالية:'), findsOneWidget);
      expect(find.text('افتح الشحنة'), findsOneWidget);
      expect(find.text('اضغط على تقديم مطالبة'), findsOneWidget);
      expect(find.text('ملاحظة: تنتهي صلاحية المطالبة بعد 14 يوم'), findsOneWidget);
    });

    testWidgets('ProfileFaqSupportCard renders and triggers action', (tester) async {
      var buttonPressed = false;
      await tester.pumpWidget(
        _wrapWidget(
          child: ProfileFaqSupportCard(
            title: 'هل تحتاج إلى مساعدة إضافية؟',
            description: 'فريق الدعم لدينا متاح 24/7',
            buttonLabel: 'تواصل معنا',
            onPressed: () => buttonPressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('هل تحتاج إلى مساعدة إضافية؟'), findsOneWidget);
      expect(find.text('فريق الدعم لدينا متاح 24/7'), findsOneWidget);
      expect(find.text('تواصل معنا'), findsOneWidget);

      await tester.tap(find.text('تواصل معنا'));
      await tester.pump();

      expect(buttonPressed, isTrue);
    });
  });

  group('ProfileLegalWidgets Tests', () {
    testWidgets('ProfileDocumentSummaryCard renders all items and values', (tester) async {
      const items = <ProfileSummaryItem>[
        ProfileSummaryItem(label: 'آخر تحديث', value: 'أكتوبر 2026'),
        ProfileSummaryItem(label: 'الإصدار', value: 'v2.1'),
      ];

      await tester.pumpWidget(
        _wrapWidget(
          child: const ProfileDocumentSummaryCard(items: items),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('آخر تحديث'), findsOneWidget);
      expect(find.text('أكتوبر 2026'), findsOneWidget);
      expect(find.text('الإصدار'), findsOneWidget);
      expect(find.text('v2.1'), findsOneWidget);
    });

    testWidgets('ProfileNumberedInfoCard renders number, title, and description', (tester) async {
      await tester.pumpWidget(
        _wrapWidget(
          child: const ProfileNumberedInfoCard(
            number: 1,
            title: 'شروط الاستخدام',
            description: 'يخضع استخدام هذه المنصة للضوابط المعمول بها.',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
      expect(find.text('شروط الاستخدام'), findsOneWidget);
      expect(find.text('يخضع استخدام هذه المنصة للضوابط المعمول بها.'), findsOneWidget);
    });
  });
}
