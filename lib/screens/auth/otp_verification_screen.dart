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
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../core/validation/app_validators.dart';
import '../../core/validation/validation_message_mapper.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    this.contact,
    this.onVerify,
  });

  final String? contact;
  final Future<bool> Function(String code)? onVerify;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final TextEditingController _pinController;
  late final FocusNode _pinFocusNode;
  late final _SmartAuthSmsRetriever _smsRetriever;
  Timer? _resendTimer;
  int _resendSeconds = 18;
  _OtpResultState _resultState = _OtpResultState.idle;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    _pinFocusNode = FocusNode();
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
        AppValidators.minLength(6),
        AppValidators.maxLength(6),
        AppValidators.numericRange(min: 0, max: 999999),
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
    var isAccepted = true;
    try {
      isAccepted =
          await widget.onVerify?.call(_pinController.text.trim()) ?? true;
    } on Object {
      isAccepted = false;
    }
    if (!mounted) return;

    setState(() {
      _isVerifying = false;
      _resultState =
          isAccepted ? _OtpResultState.success : _OtpResultState.failure;
    });
    if (isAccepted) context.go(AppRoutes.otpSuccess);
  }

  void _resendCode() {
    _pinController.clear();
    _startResendCountdown();
    setState(() => _resultState = _OtpResultState.idle);
    _pinFocusNode.requestFocus();
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    _resendSeconds = 18;
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

  String _formatCountdown() {
    final seconds = _resendSeconds.toString().padLeft(2, '0');
    return '00:$seconds';
  }

  void _handleCodeChanged(String value) {
    if (_resultState != _OtpResultState.idle) {
      setState(() => _resultState = _OtpResultState.idle);
    } else {
      setState(() {});
    }
  }

  void _showHelp() {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: AppText(l10n.loginMethodHelp),
        content: AppText(l10n.loginMethodHelpMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: AppText(l10n.itemDetails),
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
    final isEmail = widget.contact?.contains('@') ?? false;
    final isSuccess = _resultState == _OtpResultState.success;
    final isFailure = _resultState == _OtpResultState.failure;
    final resultColor = isSuccess
        ? AppColors.primitives.success.shade600
        : AppColors.primitives.failure.shade500;
    final resultFill = isSuccess
        ? AppColors.primitives.success.shade100
        : AppColors.primitives.failure.shade100;
    final pinTheme = PinTheme(
      width: 48,
      height: 56,
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isSuccess || isFailure ? resultColor : colors.text.primary,
            fontWeight: FontWeight.w600,
          ),
      decoration: BoxDecoration(
        color: isSuccess || isFailure ? resultFill : colors.surface.secondary,
        borderRadius: BorderRadius.circular(AppRadius.tokenXl),
        border: isSuccess || isFailure ? Border.all(color: resultColor) : null,
      ),
    );

    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: colors.background.primary,
      dismissKeyboardOnTap: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.tokenM,
              AppSpacing.tokenM,
              AppSpacing.tokenM,
              AppSpacing.tokenL,
            ),
            child: Row(
              textDirection: Directionality.of(context),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Material(
                  color: colors.background.secondary,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => context.pop(),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.chevron_left,
                        color: colors.text.link,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _showHelp,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: AppText(
                    l10n.loginMethodHelp,
                    variant: AppTextVariant.bodySmall,
                    style: TextStyle(color: colors.text.link),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.tokenM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppText(
                  l10n.otpTitle,
                  variant: AppTextVariant.headlineSmall,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: colors.text.link,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  widget.contact == null
                      ? l10n.otpSubtitle
                      : l10n.otpDestination(_maskedContact(widget.contact!)),
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: colors.text.secondary),
                ),
                const SizedBox(height: AppSpacing.tokenL),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 6,
                    controller: _pinController,
                    focusNode: _pinFocusNode,
                    smsRetriever: _smsRetriever,
                    defaultPinTheme: pinTheme,
                    separatorBuilder: (_) =>
                        const SizedBox(width: AppSpacing.tokenS),
                    showCursor: true,
                    onChanged: _handleCodeChanged,
                    focusedPinTheme: pinTheme.copyWith(
                      decoration: pinTheme.decoration!.copyWith(
                        border: Border.all(
                          color: isSuccess || isFailure
                              ? resultColor
                              : colors.text.link,
                          width: 1.5,
                        ),
                      ),
                    ),
                    preFilledWidget: AppText(
                      '–',
                      variant: AppTextVariant.titleLarge,
                      style: TextStyle(color: colors.text.disabled),
                    ),
                  ),
                ),
                if (isFailure) ...<Widget>[
                  const SizedBox(height: AppSpacing.tokenS),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.tokenM,
                      vertical: AppSpacing.tokenS,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primitives.failure.shade100,
                      borderRadius: BorderRadius.circular(AppRadius.tokenXl),
                    ),
                    child: AppText(
                      l10n.otpVerificationFailed,
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: resultColor),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.tokenS),
                Align(
                  alignment: Alignment.center,
                  child: _resendSeconds > 0
                      ? AppText(
                          l10n.otpResendCountdown(_formatCountdown()),
                          variant: AppTextVariant.bodySmall,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colors.text.secondary),
                        )
                      : TextButton.icon(
                          onPressed: _resendCode,
                          icon: Icon(
                            Icons.reply,
                            size: 18,
                            color: colors.text.link,
                          ),
                          label: AppText(
                            l10n.otpResend,
                            variant: AppTextVariant.bodySmall,
                            style: TextStyle(color: colors.text.link),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.tokenS,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.tokenM,
            AppSpacing.tokenS,
            AppSpacing.tokenM,
            AppSpacing.tokenM,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppText(
                l10n.otpPrivacyNotice,
                variant: AppTextVariant.bodySmall,
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.text.disabled),
              ),
              const SizedBox(height: AppSpacing.tokenS),
              PrimaryButton(
                label: l10n.loginMethodContinue,
                onPressed: _pinController.text.length == 6 &&
                        !isFailure &&
                        !_isVerifying
                    ? _verifyCode
                    : null,
                isLoading: _isVerifying,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.action.primary,
                  foregroundColor: colors.text.inverse,
                  disabledBackgroundColor:
                      AppColors.primitives.primary.shade300,
                  disabledForegroundColor: colors.text.inverse,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: AppText(
                  isEmail ? l10n.otpChangeEmail : l10n.otpChangePhone,
                  variant: AppTextVariant.bodyMedium,
                  style: TextStyle(color: colors.text.link),
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
      final visible = local.length > 2 ? local.substring(0, 2) : local[0];
      return '$visible••••@${parts.last}';
    }

    try {
      final phone = PhoneNumber.parse(contact);
      if (phone.nsn.length < 5) return contact;
      return '+${phone.countryCode} •••• ${phone.nsn.substring(phone.nsn.length - 4)}';
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
      // SmartAuth might not be available on some platforms.
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
