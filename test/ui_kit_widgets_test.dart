import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/components/app_scaffold.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/components/buttons/icon_circle_button.dart';
import 'package:shipments/components/buttons/primary_button.dart';
import 'package:shipments/components/feedback/status_banner.dart';
import 'package:shipments/components/inputs/app_text_field.dart';
import 'package:shipments/components/layout/adaptive_two_pane.dart';
import 'package:shipments/components/layout/app_bottom_sheet.dart';
import 'package:shipments/components/layout/app_section_card.dart';
import 'package:shipments/l10n/app_localizations.dart';

Widget _testApp(Widget child) {
  return MaterialApp(
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
  group('UI Kit widgets', () {
    testWidgets('AppText renders using selected variant', (tester) async {
      await tester.pumpWidget(
        _testApp(
          const AppText(
            'Hello UI Kit',
            variant: AppTextVariant.titleLarge,
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Hello UI Kit'));
      expect(textWidget.style, isNotNull);
      expect(textWidget.style?.fontSize, isNotNull);
    });

    testWidgets('AppTextField supports vertical text alignment', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(
          const AppTextField(
            hintText: 'Search',
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.textAlign, TextAlign.start);
      expect(textField.textAlignVertical, TextAlignVertical.center);
    });

    testWidgets('AppText.localized resolves localized value', (tester) async {
      await tester.pumpWidget(
        _testApp(
          AppText.localized(
            (l10n) => l10n.loginTitle,
            variant: AppTextVariant.titleLarge,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Sign in'), findsOneWidget);
    });

    testWidgets('PrimaryButton shows loading state and blocks taps', (
      tester,
    ) async {
      var taps = 0;

      await tester.pumpWidget(
        _testApp(
          PrimaryButton(
            label: 'Submit',
            isLoading: true,
            onPressed: () {
              taps++;
            },
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(PrimaryButton));
      await tester.pump();
      expect(taps, 0);
    });

    testWidgets('AppScaffold applies SafeArea and padding by default', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppScaffold(
            body: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('AppBottomSheet.show opens and displays content', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(
          Builder(
            builder: (context) {
              return PrimaryButton(
                label: 'Open Sheet',
                onPressed: () {
                  AppBottomSheet.show<void>(
                    context,
                    child: const Text('Bottom sheet content'),
                  );
                },
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Bottom sheet content'), findsOneWidget);
    });

    testWidgets('StatusBanner renders with action', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _testApp(
          StatusBanner(
            message: 'Status message',
            actionLabel: 'Action',
            onAction: () {
              tapped = true;
            },
          ),
        ),
      );

      expect(find.text('Status message'), findsOneWidget);
      await tester.tap(find.text('Action'));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('IconCircleButton enforces minimum interactive size', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(
          const IconCircleButton(
            icon: Icons.favorite_border_rounded,
            onPressed: null,
            size: 32,
          ),
        ),
      );

      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final minimumSize =
          iconButton.style?.minimumSize?.resolve(<WidgetState>{});
      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(IconButton),
          matching: find.byType(SizedBox),
        ),
      );

      expect(minimumSize, const Size.square(48));
      expect(sizedBox.width, 48);
      expect(sizedBox.height, 48);
    });

    testWidgets('AppSectionCard composes section title and card content', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(
          const AppSectionCard(
            title: 'Section title',
            subtitle: 'Section subtitle',
            child: Text('Section body'),
          ),
        ),
      );

      expect(find.text('Section title'), findsOneWidget);
      expect(find.text('Section subtitle'), findsOneWidget);
      expect(find.text('Section body'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('AdaptiveTwoPane uses Column on compact width', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(390, 844)),
            child: Scaffold(
              body: AdaptiveTwoPane(
                firstPane: Container(key: const Key('first-pane')),
                secondPane: Container(key: const Key('second-pane')),
              ),
            ),
          ),
        ),
      );

      expect(
        find.ancestor(
          of: find.byKey(const Key('first-pane')),
          matching: find.byType(Column),
        ),
        findsWidgets,
      );
    });

    testWidgets('AdaptiveTwoPane uses Row on medium width', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(900, 844)),
            child: Scaffold(
              body: AdaptiveTwoPane(
                firstPane: Container(key: const Key('first-pane')),
                secondPane: Container(key: const Key('second-pane')),
              ),
            ),
          ),
        ),
      );

      expect(
        find.ancestor(
          of: find.byKey(const Key('first-pane')),
          matching: find.byType(Row),
        ),
        findsWidgets,
      );
    });
  });
}
