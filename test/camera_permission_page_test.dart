import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/core/camera/camera_capture_service.dart';
import 'package:shipments/core/permissions/app_permission.dart';
import 'package:shipments/core/permissions/permission_result.dart';
import 'package:shipments/core/permissions/permission_service.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/demands/camera_permission_page.dart';

void main() {
  testWidgets('allow camera requests access and returns to the caller', (
    tester,
  ) async {
    final cameraService = _FakeCameraCaptureService();
    final permissionService = _FakePermissionService();
    final router = _cameraTestRouter(cameraService, permissionService);

    await tester.pumpWidget(_TestApp(router: router));
    await tester.tap(find.text('Open camera page'));
    await tester.pumpAndSettle();
    final allowLabel = AppLocalizations.of(
      tester.element(find.byType(CameraPermissionPage)),
    )!
        .cameraPermissionAllow;
    await tester.tap(find.text(allowLabel));
    await tester.pumpAndSettle();

    expect(cameraService.requestCount, 1);
    expect(find.text('true'), findsOneWidget);
  });

  testWidgets('camera denial opens settings and permits retry on return', (
    tester,
  ) async {
    final cameraService = _FakeCameraCaptureService(
      error: PlatformException(code: 'camera_access_denied'),
    );
    final permissionService = _FakePermissionService();
    final router = _cameraTestRouter(cameraService, permissionService);

    await tester.pumpWidget(_TestApp(router: router));
    await tester.tap(find.text('Open camera page'));
    await tester.pumpAndSettle();
    final l10n = AppLocalizations.of(
      tester.element(find.byType(CameraPermissionPage)),
    )!;
    await tester.tap(find.text(l10n.cameraPermissionAllow));
    await tester.pumpAndSettle();

    expect(find.text(l10n.cameraPermissionOpenSettings), findsOneWidget);
    await tester.tap(find.text(l10n.cameraPermissionOpenSettings));
    await tester.pumpAndSettle();
    expect(permissionService.openSettingsCount, 1);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(find.text(l10n.cameraPermissionAllow), findsOneWidget);
  });
}

GoRouter _cameraTestRouter(
  CameraCaptureService cameraService,
  PermissionService permissionService,
) {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (context, state) => _CameraTestHome()),
      GoRoute(
        path: '/camera',
        builder: (context, state) => CameraPermissionPage(
          cameraCaptureService: cameraService,
          permissionService: permissionService,
        ),
      ),
    ],
  );
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.router});
  final GoRouter router;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: router,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      );
}

class _CameraTestHome extends StatefulWidget {
  @override
  State<_CameraTestHome> createState() => _CameraTestHomeState();
}

class _CameraTestHomeState extends State<_CameraTestHome> {
  String _cameraOpened = 'false';

  Future<void> _openCameraPage() async {
    final cameraOpened = await context.push<bool>('/camera');
    if (cameraOpened != null && mounted) {
      setState(() => _cameraOpened = cameraOpened.toString());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            TextButton(
              onPressed: _openCameraPage,
              child: const Text('Open camera page'),
            ),
            Text(_cameraOpened),
          ],
        ),
      );
}

class _FakeCameraCaptureService implements CameraCaptureService {
  _FakeCameraCaptureService({this.error});
  final Object? error;
  int requestCount = 0;

  @override
  bool get hasPreviouslyGrantedCameraPermission => false;
  @override
  bool get hasSeenCameraGuide => false;
  @override
  Future<bool> requestCameraAccess() async {
    requestCount++;
    if (error != null) throw error!;
    return true;
  }

  @override
  Future<void> markCameraGuideSeen() async {}
  @override
  Future<void> saveCameraPermissionGranted() async {}
}

class _FakePermissionService implements PermissionService {
  int openSettingsCount = 0;

  @override
  Future<PermissionStatusResult> check(AppPermission permission) async =>
      PermissionStatusResult(
        permission: permission,
        status: AppPermissionStatus.granted,
      );

  @override
  Future<bool> openAppSettings() async {
    openSettingsCount++;
    return true;
  }

  @override
  Future<PermissionRequestResult> request(AppPermission permission) async =>
      PermissionRequestResult(
        permission: permission,
        before: AppPermissionStatus.denied,
        after: AppPermissionStatus.granted,
      );
}
