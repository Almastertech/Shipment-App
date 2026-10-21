import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shipments/core/storage/local_storage.dart';
import 'package:shipments/features/notifications/application/in_app_notification_center.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/home/home_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

void main() {
  testWidgets('home screen skeletonizes all content and disables interaction',
      (tester) async {
    final notificationCenter = InAppNotificationCenter(
      storage: _MemoryLocalStorage(),
      storageKey: 'home_skeleton_test_notifications',
    );
    await notificationCenter.initialize();

    Widget buildApp({required bool isLoading}) {
      return ChangeNotifierProvider<InAppNotificationCenter>.value(
        value: notificationCenter,
        child: MaterialApp(
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
          home: HomeScreen(isLoading: isLoading),
        ),
      );
    }

    await tester.pumpWidget(buildApp(isLoading: true));
    await tester.pump(const Duration(milliseconds: 300));

    expect(tester.takeException(), isNull);
    final skeletonizerFinder = find.byWidgetPredicate(
      (widget) => widget is Skeletonizer,
    );
    expect(skeletonizerFinder, findsOneWidget);
    expect(
      tester.widget<Skeletonizer>(skeletonizerFinder).enabled,
      isTrue,
    );
    expect(
      tester
          .widget<IgnorePointer>(
            find.byKey(const Key('home-screen-loading-interaction-blocker')),
          )
          .ignoring,
      isTrue,
    );
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(buildApp(isLoading: false));
    await tester.pump();

    expect(
      tester.widget<Skeletonizer>(skeletonizerFinder).enabled,
      isFalse,
    );
    expect(
      tester
          .widget<IgnorePointer>(
            find.byKey(const Key('home-screen-loading-interaction-blocker')),
          )
          .ignoring,
      isFalse,
    );
    expect(tester.takeException(), isNull);

    notificationCenter.dispose();
  });
}

class _MemoryLocalStorage implements LocalStorage {
  final Map<String, Object> _data = <String, Object>{};

  @override
  bool? getBool(String key) => _data[key] as bool?;

  @override
  int? getInt(String key) => _data[key] as int?;

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }
}
