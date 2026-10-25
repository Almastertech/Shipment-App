import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shipments/core/storage/local_storage.dart';
import 'package:shipments/data/datasource/remote/dio/dio_client.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/localization/controllers/localization_controller.dart';
import 'package:shipments/screens/profile/widgets/profile_language_switcher.dart';
import 'package:shipments/screens/profile/widgets/profile_menu_section.dart';

class _FakeLocalStorage implements LocalStorage {
  final Map<String, dynamic> _data = <String, dynamic>{};

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeDioClient implements DioClient {
  String? updatedLanguageCode;

  @override
  void updateHeaders({String? languageCode}) {
    updatedLanguageCode = languageCode;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _buildTestApp({
  required LocalizationController controller,
  required Widget child,
}) {
  return ChangeNotifierProvider<LocalizationController>.value(
    value: controller,
    child: Consumer<LocalizationController>(
      builder: (context, loc, _) {
        return MaterialApp(
          locale: loc.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Scaffold(body: child),
        );
      },
    ),
  );
}

void main() {
  late _FakeLocalStorage storage;
  late _FakeDioClient dioClient;
  late LocalizationController controller;

  setUp(() {
    storage = _FakeLocalStorage();
    dioClient = _FakeDioClient();
    controller = LocalizationController(
      storage: storage,
      dioClient: dioClient,
    );
  });

  testWidgets('renders Arabic and English segments', (tester) async {
    await tester.pumpWidget(
      _buildTestApp(
        controller: controller,
        child: const ProfileLanguageSwitcher(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('العربية'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
  });

  testWidgets('switching language to Arabic updates controller and DioClient',
      (tester) async {
    await controller.setLanguage('en');

    await tester.pumpWidget(
      _buildTestApp(
        controller: controller,
        child: const ProfileLanguageSwitcher(),
      ),
    );
    await tester.pumpAndSettle();

    expect(controller.locale.languageCode, equals('en'));

    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();

    expect(controller.locale.languageCode, equals('ar'));
    expect(dioClient.updatedLanguageCode, equals('ar'));
    expect(storage.getString('app_locale'), equals('ar'));
  });

  testWidgets('switching language to English updates controller and storage',
      (tester) async {
    await controller.setLanguage('ar');

    await tester.pumpWidget(
      _buildTestApp(
        controller: controller,
        child: const ProfileLanguageSwitcher(),
      ),
    );
    await tester.pumpAndSettle();

    expect(controller.locale.languageCode, equals('ar'));

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(controller.locale.languageCode, equals('en'));
    expect(dioClient.updatedLanguageCode, equals('en'));
    expect(storage.getString('app_locale'), equals('en'));
  });

  testWidgets('handleSystemLocale updates app to device language',
      (tester) async {
    await controller.setLanguage('en');
    expect(controller.locale.languageCode, equals('en'));

    controller.handleSystemLocale(const Locale('ar', 'SA'));
    expect(controller.locale.languageCode, equals('ar'));
    expect(dioClient.updatedLanguageCode, equals('ar'));
    expect(storage.getString('app_locale'), equals('ar'));

    controller.handleSystemLocale(const Locale('en', 'US'));
    expect(controller.locale.languageCode, equals('en'));
    expect(dioClient.updatedLanguageCode, equals('en'));
    expect(storage.getString('app_locale'), equals('en'));
  });

  testWidgets(
      'didChangeLocales updates app language when system locales change',
      (tester) async {
    await controller.setLanguage('en');
    expect(controller.locale.languageCode, equals('en'));

    controller.didChangeLocales(<Locale>[const Locale('ar')]);
    expect(controller.locale.languageCode, equals('ar'));

    controller.didChangeLocales(<Locale>[const Locale('en')]);
    expect(controller.locale.languageCode, equals('en'));
  });

  testWidgets('ProfileMenuItem renders with ProfileLanguageSwitcher trailing',
      (tester) async {
    await tester.pumpWidget(
      _buildTestApp(
        controller: controller,
        child: Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return ProfileMenuSection(
              title: l10n.profileSectionGeneral,
              items: <ProfileMenuItem>[
                ProfileMenuItem(
                  label: l10n.profileLanguage,
                  icon: Icons.language_rounded,
                  trailing: const ProfileLanguageSwitcher(),
                  onTap: () => controller.toggleLanguage(),
                ),
              ],
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ProfileLanguageSwitcher), findsOneWidget);
    expect(find.byIcon(Icons.language_rounded), findsOneWidget);
  });
}
