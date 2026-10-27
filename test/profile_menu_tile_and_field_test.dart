import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/profile/widgets/profile_edit_field.dart';
import 'package:shipments/screens/profile/widgets/profile_menu_tile.dart';

Widget _wrapWidget({required Widget child, TextDirection textDirection = TextDirection.rtl}) {
  return MaterialApp(
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(
      body: Directionality(
        textDirection: textDirection,
        child: SingleChildScrollView(child: child),
      ),
    ),
  );
}

void main() {
  group('ProfileMenuTile Tests', () {
    testWidgets('renders tile with label and icon, and handles tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrapWidget(
          child: ProfileMenuTile(
            label: 'إعدادات الحساب',
            icon: Icons.person_outline,
            onTap: () => tapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('إعدادات الحساب'), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);

      await tester.tap(find.text('إعدادات الحساب'));
      expect(tapped, isTrue);
    });

    testWidgets('shows chevron_left in RTL direction', (tester) async {
      await tester.pumpWidget(
        _wrapWidget(
          textDirection: TextDirection.rtl,
          child: ProfileMenuTile(
            label: 'الطلبات',
            icon: Icons.receipt_outlined,
            onTap: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_left_rounded), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right_rounded), findsNothing);
    });

    testWidgets('shows chevron_right in LTR direction', (tester) async {
      await tester.pumpWidget(
        _wrapWidget(
          textDirection: TextDirection.ltr,
          child: ProfileMenuTile(
            label: 'Orders',
            icon: Icons.receipt_outlined,
            onTap: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
      expect(find.byIcon(Icons.chevron_left_rounded), findsNothing);
    });
  });

  group('ProfileEditField Tests', () {
    testWidgets('renders label and text field with input support', (tester) async {
      final controller = TextEditingController(text: 'أحمد');

      await tester.pumpWidget(
        _wrapWidget(
          child: ProfileEditField(
            label: 'الاسم الكامل',
            controller: controller,
            textDirection: TextDirection.rtl,
            hintText: 'أدخل اسمك',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('الاسم الكامل'), findsOneWidget);
      expect(find.text('أحمد'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'محمد');
      expect(controller.text, equals('محمد'));
    });
  });
}
