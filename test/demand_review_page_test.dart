import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipments/components/buttons/primary_button.dart';
import 'package:shipments/core/location/location_coordinates.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/demands/demand_review_page.dart';

Widget _buildTestApp({required Widget child}) {
  return MaterialApp(
    locale: const Locale('ar'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: child,
  );
}

void main() {
  testWidgets('DemandReviewPage renders location, evidence tiles and inputs',
      (tester) async {
    var submitted = false;

    await tester.pumpWidget(
      _buildTestApp(
        child: DemandReviewPage(
          locationUnavailable: false,
          location:
              const LocationCoordinates(latitude: 24.7136, longitude: 46.6753),
          evidence: const <XFile?>[null, null, null],
          optionalPhotos: const <XFile?>[null],
          onBack: () {},
          onRetakeEvidence: (_) {},
          onAddOptionalPhoto: (_) {},
          onSubmit: () => submitted = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(DemandReviewPage), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Test description notes');
    await tester.pumpAndSettle();

    expect(find.text('Test description notes'), findsOneWidget);

    final submitButton = find.byType(PrimaryButton);
    expect(submitButton, findsOneWidget);

    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    expect(submitted, isTrue);
  });
}
