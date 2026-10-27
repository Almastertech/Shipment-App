import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/core/location/location_coordinates.dart';
import 'package:shipments/core/location/location_service.dart';
import 'package:shipments/core/permissions/app_permission.dart';
import 'package:shipments/core/permissions/permission_result.dart';
import 'package:shipments/core/permissions/permission_service.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/demands/open_demands_page.dart';

class _FakePermissionService implements PermissionService {
  bool granted = true;
  int requestCount = 0;

  @override
  Future<PermissionStatusResult> check(AppPermission permission) async {
    return PermissionStatusResult(
      permission: permission,
      status: AppPermissionStatus.granted,
    );
  }

  @override
  Future<PermissionRequestResult> request(AppPermission permission) async {
    requestCount++;
    return PermissionRequestResult(
      permission: permission,
      before: AppPermissionStatus.denied,
      after: granted ? AppPermissionStatus.granted : AppPermissionStatus.denied,
    );
  }

  @override
  Future<bool> openAppSettings() async => true;
}

class _FakeLocationService implements LocationService {
  bool serviceEnabled = true;

  @override
  Future<bool> isLocationServiceEnabled() async => serviceEnabled;

  @override
  Future<bool> openLocationSettings() async => true;

  @override
  Future<LocationCoordinates> getCurrentLocation() async =>
      const LocationCoordinates(latitude: 24.7136, longitude: 46.6753);
}

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
  testWidgets('OpenDemandsPage renders header, illustration and benefits',
      (tester) async {
    final permissions = _FakePermissionService();
    final locations = _FakeLocationService();

    await tester.pumpWidget(
      _buildTestApp(
        child: OpenDemandsPage(
          permissionService: permissions,
          locationService: locations,
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.byType(OpenDemandsPage), findsOneWidget);
    final l10n = AppLocalizations.of(
      tester.element(find.byType(OpenDemandsPage)),
    )!;
    expect(find.text(l10n.openDemandsAllowLocation), findsOneWidget);
    expect(find.text(l10n.openDemandsNotNow), findsOneWidget);
  });
}
