import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shipments/components/feedback/confirm_dialog.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app({
  required Widget child,
  Locale? locale,
}) {
  return MaterialApp(
    locale: locale,
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
    home: Scaffold(body: child),
  );
}

void main() {
  testWidgets('ConfirmDialog uses localized default actions', (tester) async {
    await tester.pumpWidget(
      _app(
        locale: const Locale('ar'),
        child: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                ConfirmDialog.show(
                  context,
                  title: '\u0639\u0646\u0648\u0627\u0646',
                  message: '\u0631\u0633\u0627\u0644\u0629',
                );
              },
              child: const Text('open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('\u062a\u0623\u0643\u064a\u062f'), findsOneWidget);
    expect(find.text('\u0625\u0644\u063a\u0627\u0621'), findsOneWidget);
  });
}
