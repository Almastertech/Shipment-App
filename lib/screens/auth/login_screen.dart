import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/inputs/app_text_field.dart';
import '../../components/inputs/country_code_picker.dart';
import '../../components/layout/auth_hero.dart';
import '../../components/layout/auth_screen_shell.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../core/validation/app_validators.dart';
import '../../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.initialMethod});

  final String? initialMethod;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _inputController;
  late final FocusNode _inputFocusNode;
  late Country _selectedCountry;

  bool get _isEmail => widget.initialMethod == 'email';

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
    _inputFocusNode = FocusNode();
    _selectedCountry = CountryService().findByCode('SA')!;
  }

  @override
  void dispose() {
    _inputController.dispose();
    _inputFocusNode.dispose();
    super.dispose();
  }

  bool get _isInputValid {
    if (_isEmail) {
      final validation = AppValidators.validate(
        _inputController.text,
        <Validator>[AppValidators.required(), AppValidators.email()],
      );
      return validation.isValid;
    }

    final value = _inputController.text.trim();
    if (value.isEmpty) return false;

    final isoCode = IsoCode.values.where(
      (code) => code.name == _selectedCountry.countryCode,
    );
    if (isoCode.isEmpty) return false;

    try {
      return PhoneNumber.parse(
        _toAsciiDigits(value),
        destinationCountry: isoCode.first,
      ).isValid(type: PhoneNumberType.mobile);
    } on PhoneNumberException {
      return false;
    }
  }

  String? get _normalizedContact {
    final input = _inputController.text.trim();
    if (_isEmail) return input;

    final isoCode = IsoCode.values.firstWhere(
      (code) => code.name == _selectedCountry.countryCode,
    );
    try {
      return PhoneNumber.parse(
        _toAsciiDigits(input),
        destinationCountry: isoCode,
      ).international;
    } on PhoneNumberException {
      return null;
    }
  }

  void _continue() {
    _inputFocusNode.unfocus();
    context.push(AppRoutes.otp, extra: _normalizedContact);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primary = AppColors.primitives.primary;
    final neutral = AppColors.primitives.neutral;
    final isInputValid = _isInputValid;

    final title = _isEmail ? l10n.loginEmailTitle : l10n.loginPhoneTitle;
    final subtitle =
        _isEmail ? l10n.loginEmailSubtitle : l10n.loginPhoneSubtitle;
    final fieldLabel =
        _isEmail ? l10n.loginEmailFieldLabel : l10n.loginPhoneFieldLabel;
    final fieldHint = _isEmail
        ? l10n.loginEmailFieldHint
        : _phoneHintFor(_selectedCountry, l10n);
    final fieldHelper =
        _isEmail ? l10n.loginEmailFieldHelper : l10n.loginPhoneFieldHelper;

    return AppScaffold(
      safeArea: false,
      padding: EdgeInsets.zero,
      backgroundColor: neutral.shade100,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.tokenL,
            AppSpacing.tokenS,
            AppSpacing.tokenL,
            AppSpacing.tokenS,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                label: l10n.loginSendCode,
                onPressed: isInputValid ? _continue : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isInputValid ? primary.shade500 : neutral.shade300,
                  foregroundColor:
                      isInputValid ? neutral.shade100 : neutral.shade600,
                  disabledBackgroundColor: neutral.shade300,
                  disabledForegroundColor: neutral.shade600,
                  minimumSize: const Size.fromHeight(52),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                  ),
                  textStyle: AppTypography.buyerMobile.button.toTextStyle(
                    color: isInputValid ? neutral.shade100 : neutral.shade600,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.tokenS),
              AppText(
                l10n.authPrivacyNotice,
                variant: AppTextVariant.labelSmall,
                textAlign: TextAlign.center,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: neutral.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
      body: AuthScreenShell(
        hero: AuthHero(
          helpLabel: l10n.loginMethodHelp,
          title: title,
          subtitle: subtitle,
          onBack: () => context.go(AppRoutes.loginMethod),
          onHelp: () => _showHelp(context, l10n),
        ),
        content: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.tokenL,
            AppSpacing.token2Xl,
            AppSpacing.tokenL,
            AppSpacing.tokenL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText(
                fieldLabel,
                variant: AppTextVariant.labelMedium,
                style: AppTypography.buyerMobile.label.toTextStyle(
                  color: neutral.shade800,
                ),
              ),
              const SizedBox(height: AppSpacing.tokenS),
              if (_isEmail)
                _buildAppTextField(
                  hint: fieldHint,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const <String>[AutofillHints.email],
                  textInputAction: TextInputAction.done,
                )
              else
                Row(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Expanded(
                      child: _buildAppTextField(
                        hint: fieldHint,
                        keyboardType: TextInputType.phone,
                        autofillHints: const <String>[
                          AutofillHints.telephoneNumberNational,
                        ],
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9]'),
                          ),
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.tokenS),
                    CountryCodePicker(
                      initialCountryCode: 'SA',
                      width: 96,
                      onChanged: (country) {
                        setState(() {
                          _selectedCountry = country;
                        });
                      },
                    ),
                  ],
                ),
              const SizedBox(height: AppSpacing.tokenS),
              if (_inputController.text.trim().isNotEmpty && !isInputValid)
                AppText(
                  _isEmail ? l10n.validationEmail : l10n.loginPhoneInvalid,
                  variant: AppTextVariant.bodySmall,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: AppColors.primitives.failure.shade500,
                  ),
                  textAlign: TextAlign.right,
                )
              else
                AppText(
                  fieldHelper,
                  variant: AppTextVariant.bodySmall,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: neutral.shade600,
                  ),
                  textAlign: TextAlign.right,
                ),
              const SizedBox(height: AppSpacing.token3Xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppTextField({
    required String hint,
    required TextInputType keyboardType,
    required List<String> autofillHints,
    required TextInputAction textInputAction,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final neutral = AppColors.primitives.neutral;
    final radius = BorderRadius.circular(AppRadius.tokenXl);
    final inputTheme = Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenM,
          vertical: AppSpacing.tokenM,
        ),
        hintStyle: AppTypography.buyerMobile.bodySmall.toTextStyle(
          color: neutral.shade500,
        ),
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: neutral.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: neutral.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: AppColors.primitives.primary.shade500),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: AppColors.primitives.failure.shade500),
        ),
      ),
    );

    return SizedBox(
      height: 56,
      child: Theme(
        data: inputTheme,
        child: AppTextField(
          controller: _inputController,
          focusNode: _inputFocusNode,
          hintText: hint,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          inputFormatters: inputFormatters,
          textDirection: Directionality.of(context),
          onChanged: (_) => setState(() {}),
        ),
      ),
    );
  }

  String _toAsciiDigits(String value) {
    return String.fromCharCodes(
      value.runes.map((rune) {
        if (rune >= 0x0660 && rune <= 0x0669) return rune - 0x0660 + 0x30;
        if (rune >= 0x06F0 && rune <= 0x06F9) return rune - 0x06F0 + 0x30;
        return rune;
      }),
    );
  }

  String _phoneHintFor(Country country, AppLocalizations l10n) {
    if (country.countryCode == 'SA') return l10n.loginPhoneFieldHint;

    final example = country.example.replaceAll(RegExp(r'\D'), '');
    if (example.isEmpty) return 'XXXXXXXX';
    return example.replaceAll(RegExp(r'\d'), 'X');
  }

  void _showHelp(BuildContext context, AppLocalizations l10n) {
    final neutral = AppColors.primitives.neutral;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: neutral.shade100,
        title: AppText(
          l10n.loginMethodHelp,
          variant: AppTextVariant.titleLarge,
        ),
        content: AppText(
          l10n.loginMethodHelpMessage,
          variant: AppTextVariant.bodyMedium,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AppText(l10n.close, variant: AppTextVariant.labelLarge),
          ),
        ],
      ),
    );
  }
}
