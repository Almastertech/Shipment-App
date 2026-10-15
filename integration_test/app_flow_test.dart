import 'package:flutter/material.dart';
import 'package:shipments/app.dart';
import 'package:shipments/core/config/app_environment.dart';
import 'package:shipments/core/push/push_notification_handler.dart';
import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/injection.dart';
import 'package:shipments/providers.dart';
import 'package:shipments/screens/auth/login_screen.dart';
import 'package:shipments/screens/sample_feature/sample_feature_list_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    AppEnvironment.initialize();
    await init();
  });

  setUp(() async {
    await getIt<SessionManager>().clearTokens();
  });

  tearDownAll(() async {
    await getIt<PushNotificationHandler>().dispose();
  });

  group('App end-to-end flow', () {
    testWidgets('fresh app launch resolves to login', (tester) async {
      await tester.pumpWidget(
        const GenerateMultiProvider(child: MyApp()),
      );

      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('guest flow navigates from login to sample list',
        (tester) async {
      await tester.pumpWidget(
        const GenerateMultiProvider(child: MyApp()),
      );

      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person_outline_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(SampleFeatureListScreen), findsOneWidget);
    });
  });
}
