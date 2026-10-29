import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/feedback/toast_service.dart';
import '../../components/layout/auth_hero.dart';
import '../../components/layout/auth_screen_shell.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../core/device/device_id_service.dart';
import '../../core/session/session_manager.dart';
import '../../core/validation/app_validators.dart';
import '../../core/validation/validation_message_mapper.dart';
import '../../data/datasource/remote/exception/api_error.dart';
import '../../data/datasource/remote/exception/api_error_handler.dart';
import '../../data/model/response/base/api_response.dart';
import '../../data/model/auth/otp_models.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/customer_account_repository.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    this.contact,
    this.request,
    this.onVerify,
    this.phoneChange = false,
  });

  final String? contact;
  final OtpRequestResponse? request;
  final Future<bool> Function(String code)? onVerify;
  final bool phoneChange;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final TextEditingController _pinController;
  late final FocusNode _pinFocusNode;
  late final _SmartAuthSmsRetriever _smsRetriever;
  Timer? _resendTimer;
  int _resendSeconds = 45;
  _OtpResultState _resultState = _OtpResultState.idle;
  bool _isVerifying = false;
  bool _isResending = false;
  String? _verificationError;
  late OtpRequestResponse? _challenge;

  bool get _isEmail =>
      _challenge?.channel == 'email' || widget.contact?.contains('@') == true;
  String? get _destination => _challenge?.destination ?? widget.contact;
  String get _channel => _challenge?.channel ?? (_isEmail ? 'email' : 'phone');
  static const int _codeLength = 4;
  static const int _numericLimit = 9999;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    _pinFocusNode = FocusNode();
    _challenge = widget.request;
    _smsRetriever = _SmartAuthSmsRetriever(SmartAuth.instance);
    _startResendCountdown();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    _resendTimer?.cancel();
    _smsRetriever.dispose();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    if (_isVerifying) return;
    final l10n = AppLocalizations.of(context)!;
    final result = AppValidators.validate(
      _pinController.text.trim(),
      <Validator>[
        AppValidators.required(),
        AppValidators.minLength(_codeLength),
        AppValidators.maxLength(_codeLength),
        AppValidators.numericRange(min: 0, max: _numericLimit),
      ],
    );
    if (!result.isValid) {
      setState(() => _resultState = _OtpResultState.failure);
      final failure = result.firstFailure;
      _showMessage(
        failure == null
            ? l10n.otpInvalid
            : ValidationMessageMapper.toMessage(failure, l10n),
      );
      return;
    }

    setState(() => _isVerifying = true);

    if (widget.phoneChange) {
      final destination = _destination;
      if (destination == null || destination.isEmpty) {
        _finishVerificationWithError(const ApiError(
            type: ApiErrorType.validation, message: 'Missing phone number.'));
        return;
      }
      final response =
          await getIt<CustomerAccountRepository>().verifyPhoneChange(
        phone: destination,
        code: _pinController.text.trim(),
      );
      if (!mounted) return;
      if (response is ApiFailure<String>) {
        _finishVerificationWithError(response.error);
      } else if (response is ApiSuccess<String>) {
        context.pop(response.data);
      }
      return;
    }

    if (widget.onVerify != null) {
      var accepted = false;
      try {
        accepted = await widget.onVerify!.call(_pinController.text.trim());
      } on Object {
        accepted = false;
      }
      if (!mounted) return;
      setState(() {
        _isVerifying = false;
        _resultState =
            accepted ? _OtpResultState.success : _OtpResultState.failure;
      });
      if (accepted) context.go(AppRoutes.otpSuccess);
      return;
    }

    await _verifyAgainstApi();
  }

  Future<void> _verifyAgainstApi() async {
    final destination = _destination;
    if (destination == null || destination.isEmpty) {
      _finishVerificationWithError(
        const ApiError(
          type: ApiErrorType.validation,
          message: 'A verification destination is missing.',
        ),
      );
      return;
    }

    try {
      final deviceId = await getIt<DeviceIdService>().getOrCreate();
      final result = await getIt<AuthRepository>().verifyOtp(
        deviceId: deviceId,
        channel: _channel,
        code: _pinController.text.trim(),
        phone: _isEmail ? null : destination,
        email: _isEmail ? destination : null,
      );

      if (!mounted) return;
      if (result is ApiFailure<OtpVerifyResponse>) {
        _finishVerificationWithError(result.error);
        return;
      }

      final response = (result as ApiSuccess<OtpVerifyResponse>).data;
      if (response.accessToken.isEmpty || response.refreshToken.isEmpty) {
        _finishVerificationWithError(
          const ApiError(
            type: ApiErrorType.unknown,
            message:
                'The verification response did not include session tokens.',
          ),
        );
        return;
      }

      await getIt<SessionManager>().saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      if (!mounted) return;
      setState(() {
        _isVerifying = false;
        _resultState = _OtpResultState.success;
      });
      context.go(AppRoutes.home);
    } on Object catch (error) {
      _finishVerificationWithError(ApiErrorHandler.map(error));
    }
  }

  void _finishVerificationWithError(ApiError error) {
    if (!mounted) return;
    setState(() {
      _isVerifying = false;
      _resultState = _OtpResultState.failure;
      _verificationError = _errorMessage(error);
    });
    getIt<ToastService>().error(_errorMessage(error));
  }

  String _errorMessage(ApiError error) {
    final retryAfter = error.retryAfter;
    if (retryAfter != null && retryAfter > 0) {
      return '${error.message} ($retryAfter s)';
    }
    return error.message;
  }

  Future<void> _resendCode() async {
    if (widget.phoneChange) {
      final destination = _destination;
      if (_isResending || destination == null || destination.isEmpty) return;
      setState(() => _isResending = true);
      final result = await getIt<CustomerAccountRepository>()
          .requestPhoneChange(destination);
      if (!mounted) return;
      setState(() => _isResending = false);
      if (result is ApiFailure<OtpRequestResponse>) {
        if ((result.error.retryAfter ?? 0) > 0)
          _startResendCountdown(result.error.retryAfter);
        getIt<ToastService>().error(_errorMessage(result.error));
        return;
      }
      _challenge = (result as ApiSuccess<OtpRequestResponse>).data;
    }
    _pinController.clear();
    _startResendCountdown();
    setState(() => _resultState = _OtpResultState.idle);
    _pinFocusNode.requestFocus();
  }

  void _startResendCountdown([int? seconds]) {
    _resendTimer?.cancel();
    _resendSeconds =
        seconds ?? _challenge?.retryAfterSeconds ?? (_isEmail ? 18 : 45);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_resendSeconds <= 1) {
        timer.cancel();
        setState(() => _resendSeconds = 0);
      } else {
        setState(() => _resendSeconds--);
      }
    });
  }

  String _formatCountdown() =>
      '${(_resendSeconds ~/ 60).toString().padLeft(2, '0')}:${(_resendSeconds % 60).toString().padLeft(2, '0')}';

  void _handleCodeChanged(String value) {
    setState(() {
      if (_resultState != _OtpResultState.idle) {
        _resultState = _OtpResultState.idle;
        _verificationError = null;
      }
    });
  }

  void _showHelp() {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: AppText(l10n.loginMethodHelp),
        content: AppText(l10n.loginMethodHelpMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: AppText(l10n.close),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    getIt<ToastService>().info(message);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.semantic;
    final isEmail = _isEmail;
    final isSuccess = _resultState == _OtpResultState.success;
    final isFailure = _resultState == _OtpResultState.failure;
    final resultColor = isSuccess
        ? AppColors.primitives.success.shade600
        : AppColors.primitives.failure.shade500;
    final resultFill = isSuccess
        ? AppColors.primitives.success.shade100
        : AppColors.primitives.failure.shade100;
    final pinTheme = PinTheme(
      width: 78,
      height: 56,
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isSuccess || isFailure ? resultColor : colors.text.primary,
            fontWeight: FontWeight.w600,
          ),
      decoration: BoxDecoration(
        color: isSuccess || isFailure
            ? resultFill
            : AppColors.primitives.neutral.shade200,
        borderRadius: BorderRadius.circular(AppRadius.tokenL),
        border: isSuccess || isFailure
            ? Border.all(color: resultColor)
            : Border.all(color: AppColors.primitives.neutral.shade200),
      ),
    );
    final destination = _destination == null
        ? l10n.otpSubtitle
        : isEmail
            ? l10n.otpEmailDestination(_maskedContact(_destination!))
            : l10n.otpPhoneDestination(_maskedContact(_destination!));

    return AppScaffold(
      safeArea: false,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.primitives.neutral.shade100,
      dismissKeyboardOnTap: false,
      body: AuthScreenShell(
        hero: AuthHero(
          helpLabel: l10n.loginMethodHelp,
          title: l10n.otpTitle,
          subtitle: destination,
          onBack: () => context.pop(),
          onHelp: _showHelp,
        ),
        content: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.tokenL,
            AppSpacing.token3Xl,
            AppSpacing.tokenL,
            AppSpacing.tokenL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText(
                l10n.otpHint,
                variant: AppTextVariant.titleSmall,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.primitives.neutral.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.tokenM),
              // OTP digits follow LTR entry order in both locales.
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: _codeLength,
                  controller: _pinController,
                  focusNode: _pinFocusNode,
                  smsRetriever: _smsRetriever,
                  defaultPinTheme: pinTheme,
                  separatorBuilder: (_) =>
                      const SizedBox(width: AppSpacing.tokenS),
                  showCursor: false,
                  onChanged: _handleCodeChanged,
                  focusedPinTheme: pinTheme.copyWith(
                    decoration: pinTheme.decoration!.copyWith(
                      border: Border.all(
                        color: isSuccess || isFailure
                            ? resultColor
                            : AppColors.primitives.primary.shade500,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              if (isFailure) ...[
                const SizedBox(height: AppSpacing.tokenS),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.tokenM,
                    vertical: AppSpacing.tokenS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primitives.failure.shade100,
                    borderRadius: BorderRadius.circular(AppRadius.tokenL),
                  ),
                  child: AppText(
                    _verificationError ?? l10n.otpVerificationFailed,
                    variant: AppTextVariant.bodySmall,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: resultColor),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.tokenM),
              _resendSeconds > 0
                  ? Row(
                      textDirection: Directionality.of(context),
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 18,
                          color: AppColors.primitives.neutral.shade600,
                        ),
                        const SizedBox(width: AppSpacing.tokenXs),
                        Expanded(
                          child: AppText(
                            l10n.otpResendCountdown(_formatCountdown()),
                            variant: AppTextVariant.bodySmall,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: colors.text.secondary),
                          ),
                        ),
                      ],
                    )
                  : Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton.icon(
                        onPressed:
                            _isResending || _isVerifying ? null : _resendCode,
                        icon: Icon(
                          Icons.refresh_rounded,
                          size: 18,
                          color: AppColors.primitives.primary.shade500,
                        ),
                        label: AppText(
                          l10n.otpResend,
                          variant: AppTextVariant.bodySmall,
                          style: TextStyle(
                            color: AppColors.primitives.primary.shade500,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.tokenL,
            AppSpacing.tokenS,
            AppSpacing.tokenL,
            AppSpacing.tokenS,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.tokenM,
                  vertical: AppSpacing.tokenS,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primitives.neutral.shade200,
                  borderRadius: BorderRadius.circular(AppRadius.tokenL),
                ),
                child: Row(
                  textDirection: Directionality.of(context),
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      size: 18,
                      color: AppColors.primitives.primary.shade500,
                    ),
                    const SizedBox(width: AppSpacing.tokenS),
                    Expanded(
                      child: AppText(
                        l10n.otpPrivacyNotice,
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.tokenL),
              PrimaryButton(
                label: l10n.otpVerify,
                onPressed: _pinController.text.length == _codeLength &&
                        !isFailure &&
                        !_isVerifying
                    ? _verifyCode
                    : null,
                isLoading: _isVerifying,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primitives.primary.shade500,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      AppColors.primitives.neutral.shade300,
                  disabledForegroundColor:
                      AppColors.primitives.neutral.shade600,
                  elevation: 0,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.phoneChange) {
                    context.pop();
                  } else {
                    context.go(AppRoutes.login,
                        extra: isEmail ? 'email' : 'phone');
                  }
                },
                child: AppText(
                  isEmail ? l10n.otpChangeEmail : l10n.otpChangePhone,
                  variant: AppTextVariant.bodyMedium,
                  style:
                      TextStyle(color: AppColors.primitives.primary.shade500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _maskedContact(String contact) {
    if (contact.contains('@')) {
      final parts = contact.split('@');
      final local = parts.first;
      final visible = local.length > 2 ? local.substring(0, 2) : local;
      return '$visible***@${parts.last}';
    }
    try {
      final phone = PhoneNumber.parse(contact);
      if (phone.nsn.length < 5) return contact;
      return phone.nsn.substring(phone.nsn.length - 4);
    } on PhoneNumberException {
      return contact;
    }
  }
}

enum _OtpResultState { idle, success, failure }

class _SmartAuthSmsRetriever implements SmsRetriever {
  const _SmartAuthSmsRetriever(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() async {
    try {
      await smartAuth.removeUserConsentApiListener();
    } on Object {
      // SmartAuth might be unavailable on this platform.
    }
  }

  @override
  Future<String?> getSmsCode() async {
    try {
      final result = await smartAuth.getSmsWithUserConsentApi();
      return result.data?.code;
    } on Object {
      return null;
    }
  }

  @override
  bool get listenForMultipleSms => false;
}
