import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import '../../components/app_scaffold.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/layout/auth_hero.dart';
import '../../components/layout/auth_screen_shell.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../data/model/auth/otp_models.dart';
import '../../data/model/response/base/api_response.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import 'profile_view_model.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({super.key, this.currentPhone});
  final String? currentPhone;

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  final _phone = TextEditingController();
  late final ProfileViewModel _profile;
  String? _error;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _profile = getIt<ProfileViewModel>()..addListener(_changed);
    if (widget.currentPhone == null) _profile.load();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _phone.dispose();
    _profile
      ..removeListener(_changed)
      ..dispose();
    super.dispose();
  }

  String? _normalize(String value) {
    try {
      final phone =
          PhoneNumber.parse(value.trim(), destinationCountry: IsoCode.SA);
      if (phone.isoCode != IsoCode.SA ||
          !phone.isValid(type: PhoneNumberType.mobile)) return null;
      return phone.international;
    } on PhoneNumberException {
      return null;
    }
  }

  Future<void> _submit() async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context)!;
    final phone = _normalize(_phone.text);
    final current =
        _normalize(widget.currentPhone ?? _profile.account?.phone ?? '');
    if (phone == null || phone == current) {
      setState(() => _error =
          phone == null ? l10n.phoneChangeInvalid : l10n.phoneChangeSame);
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await _profile.requestPhoneChange(phone);
    if (!mounted) return;
    setState(() => _busy = false);
    if (result is ApiFailure<OtpRequestResponse>) {
      final retry = result.error.retryAfter;
      setState(() => _error = retry != null && retry > 0
          ? '${result.error.message} ${l10n.phoneChangeWait(retry)}'
          : result.error.message);
      return;
    }
    final challenge = (result as ApiSuccess<OtpRequestResponse>).data;
    final verified =
        await context.push<String>(AppRoutes.changePhoneOtp, extra: challenge);
    if (!mounted || verified == null) return;
    context.pop(verified);
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.editProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final current = widget.currentPhone ?? _profile.account?.phone;
    return AppScaffold(
      isLoading: _busy || _profile.loading,
      loadingLabel: l10n.loading,
      safeArea: false,
      padding: EdgeInsets.zero,
      body: AuthScreenShell(
        hero: AuthHero(
          helpLabel: l10n.loginMethodHelp,
          title: l10n.phoneChangeTitle,
          subtitle: l10n.profileEditPhoneHelper,
          onBack: _back,
          onHelp: () => showDialog<void>(
              context: context,
              builder: (dialogContext) => AlertDialog(
                    title: Text(l10n.loginMethodHelp),
                    content: Text(l10n.loginMethodHelpMessage),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          child: Text(l10n.close))
                    ],
                  )),
        ),
        content: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.tokenL),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (_profile.error != null)
              TextButton(
                  onPressed: _profile.load,
                  child: Text('${l10n.errorGenericMessage} ${l10n.retry}')),
            Text(l10n.phoneChangeCurrent),
            const SizedBox(height: AppSpacing.tokenS),
            Text(current ?? '—', textDirection: TextDirection.ltr),
            const SizedBox(height: AppSpacing.token2Xl),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                  labelText: l10n.phoneChangeNew,
                  hintText: l10n.phoneChangeNewHint,
                  errorText: _error),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),
            const SizedBox(height: AppSpacing.token2Xl),
            PrimaryButton(
              label: l10n.phoneChangeSend,
              onPressed: _profile.error != null ? null : _submit,
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
