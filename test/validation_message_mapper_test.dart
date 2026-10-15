import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shipments/core/validation/validation_failure.dart';
import 'package:shipments/core/validation/validation_message_mapper.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ValidationMessageMapper maps failure to localized message', (
    tester,
  ) async {
    AppLocalizations? l10n;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
        home: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    final message = ValidationMessageMapper.toMessage(
      const ValidationFailure(type: ValidationFailureType.required),
      l10n!,
    );

    expect(message, 'This field is required.');
  });
}
