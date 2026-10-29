import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shipments/core/storage/local_storage.dart';
import 'package:shipments/data/model/customer_home.dart';
import 'package:shipments/features/notifications/application/in_app_notification_center.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/home/widgets/home_header_widget.dart';

void main() {
  testWidgets('HomeHeaderWidget renders backend shipment data without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final notificationCenter = InAppNotificationCenter(
      storage: _MemoryLocalStorage(),
      storageKey: 'test_notification_key',
    );
    await notificationCenter.initialize();

    await tester.pumpWidget(
      ChangeNotifierProvider<InAppNotificationCenter>.value(
        value: notificationCenter,
        child: const MaterialApp(
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
              child: HomeHeaderWidget(
                customerName: 'Maha',
                featuredShipment: CustomerHomeShipment(
                  packageId: 'package-1',
                  productName: 'Camera',
                  storeName: 'Camera Store',
                  status: 'in_transit',
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(HomeHeaderWidget), findsOneWidget);
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('In Transit'), findsOneWidget);
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
