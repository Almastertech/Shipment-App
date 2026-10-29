import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:shipments/core/routing/app_routes.dart';
import 'package:shipments/data/datasource/remote/customer_account_data_source.dart';
import 'package:shipments/data/datasource/remote/dio/dio_client.dart';
import 'package:shipments/data/model/auth/otp_models.dart';
import 'package:shipments/data/model/customer_account.dart';
import 'package:shipments/data/model/response/base/api_response.dart';
import 'package:shipments/data/repository/customer_account_repository.dart';
import 'package:shipments/injection.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/auth/otp_verification_screen.dart';
import 'package:shipments/screens/profile/change_phone_screen.dart';
import 'package:shipments/screens/profile/edit_profile_screen.dart';
import 'package:shipments/screens/profile/profile_view_model.dart';

void main() {
  testWidgets('phone change uses separate screens and preserves profile edits',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final repository = _Repository();
    getIt.registerSingleton<CustomerAccountRepository>(repository);
    getIt.registerFactory<ProfileViewModel>(() => ProfileViewModel(repository));
    addTearDown(() async {
      await getIt.unregister<ProfileViewModel>();
      await getIt.unregister<CustomerAccountRepository>();
    });
    final router = GoRouter(initialLocation: AppRoutes.editProfile, routes: [
      GoRoute(
          path: AppRoutes.editProfile,
          builder: (_, __) => const EditProfileScreen()),
      GoRoute(
          path: AppRoutes.changePhone,
          builder: (_, state) =>
              ChangePhoneScreen(currentPhone: state.extra as String?)),
      GoRoute(
          path: AppRoutes.changePhoneOtp,
          builder: (_, state) => OtpVerificationScreen(
              request: state.extra! as OtpRequestResponse, phoneChange: true)),
    ]);
    addTearDown(router.dispose);
    await tester.pumpWidget(MaterialApp.router(
      routerConfig: router,
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'edit profile');
    await tester.enterText(find.byType(TextFormField).first, 'Unsaved Name');
    await tester.tap(find.bySemanticsLabel('Change phone number'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'change phone');
    expect(find.text('+966501234567'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, '0551234567');
    await tester.tap(find.text('Send verification code'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'otp');
    expect(repository.requestedPhone, '+966551234567');
    expect(find.byType(OtpVerificationScreen), findsOneWidget);
    await tester.enterText(
        find.descendant(
            of: find.byType(Pinput), matching: find.byType(EditableText)),
        '0012');
    await tester.pump();
    await tester.tap(find.text('Verify'));
    await tester.pumpAndSettle();
    expect(repository.verifiedCode, '0012');
    expect(find.text('Unsaved Name'), findsOneWidget);
    expect(find.text('+966551234567'), findsOneWidget);
  });
}

class _Repository extends CustomerAccountRepository {
  _Repository() : super(CustomerAccountDataSource(_Client()));
  String? requestedPhone;
  String? verifiedCode;
  @override
  Future<ApiResult<CustomerAccount>> fetchAccount() async =>
      ApiSuccess(CustomerAccount.fromJson(
          {'id': 'customer', 'full_name': 'Name', 'phone': '+966501234567'}));
  @override
  Future<ApiResult<OtpRequestResponse>> requestPhoneChange(String phone) async {
    requestedPhone = phone;
    return ApiSuccess(OtpRequestResponse(
        channel: 'phone',
        destination: phone,
        expiresAt: 0,
        retryAfterSeconds: 60));
  }

  @override
  Future<ApiResult<String>> verifyPhoneChange(
      {required String phone, required String code}) async {
    verifiedCode = code;
    return ApiSuccess(phone);
  }
}

class _Client implements DioClient {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
