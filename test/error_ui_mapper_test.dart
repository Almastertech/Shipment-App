import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shipments/components/error_ui_mapper.dart';
import 'package:shipments/components/error_ui_model.dart';
import 'package:shipments/data/datasource/remote/exception/api_error.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorUiMapper', () {
    testWidgets('maps offline-like errors to offline UI model', (tester) async {
      late ErrorUiModel mapped;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
          home: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              mapped = ErrorUiMapper.fromApiError(
                const ApiError(
                  type: ApiErrorType.offline,
                  message: 'No internet',
                ),
                l10n,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(mapped.type, ErrorUiType.offline);
      expect(mapped.title, isNotEmpty);
    });

    testWidgets('maps unauthorized errors to unauthorized UI model',
        (tester) async {
      late ErrorUiModel mapped;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
          home: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              mapped = ErrorUiMapper.fromApiError(
                const ApiError(
                  type: ApiErrorType.unauthorized,
                  message: '',
                ),
                l10n,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(mapped.type, ErrorUiType.unauthorized);
      expect(mapped.message, isNotEmpty);
    });
  });
}
