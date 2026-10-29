import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../core/validation/app_validators.dart';
import '../../core/validation/validation_message_mapper.dart';
import '../../data/datasource/remote/exception/api_error.dart';
import '../../data/model/customer_account.dart';
import '../../data/model/response/base/api_response.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import 'profile_view_model.dart';
import 'widgets/profile_edit_avatar_card.dart';
import 'widgets/profile_edit_field.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _initialized = false;
  bool _phoneUpdated = false;
  final Map<String, String> _serverErrors = <String, String>{};
  late final ProfileViewModel _profile;

  @override
  void initState() {
    super.initState();
    _profile = getIt<ProfileViewModel>()..addListener(_onProfileChanged);
    _profile.load();
  }

  void _onProfileChanged() {
    final account = _profile.account;
    if (!_initialized && account != null) {
      _nameController.text = account.fullName ?? '';
      _phoneController.text = account.phone ?? '';
      _emailController.text = account.email ?? '';
      _initialized = true;
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _profile
      ..removeListener(_onProfileChanged)
      ..dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final heroHeight = ProfileHero.heightForWidth(width);
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    const horizontalInset = AppSpacing.token2Xl;
    final inputTheme = Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        constraints: const BoxConstraints(minHeight: 58),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenL,
          vertical: AppSpacing.tokenL,
        ),
        hintStyle: AppTypography.buyerMobile.bodyMedium.toTextStyle(
          color: AppColors.primitives.neutral.shade600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.tokenL),
          borderSide: BorderSide(color: AppColors.primitives.neutral.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.tokenL),
          borderSide: BorderSide(
            color: AppColors.primitives.primary.shade500,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.tokenL),
          borderSide: BorderSide(color: AppColors.primitives.failure.shade500),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.tokenL),
          borderSide: BorderSide(color: AppColors.primitives.failure.shade500),
        ),
      ),
    );

    return AppScaffold(
      isLoading: widget.isLoading || _profile.loading || _profile.saving,
      loadingLabel: l10n.loading,
      padding: EdgeInsets.zero,
      safeArea: false,
      backgroundColor: AppColors.semantic.background.primary,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            height: heroHeight,
            child: ProfileSubpageHero(
              title: l10n.profileEditTitle,
              subtitle: l10n.profileEditSubtitle,
              backLabel: l10n.navigationBack,
              onBack: () => _goBack(context),
            ),
          ),
          PositionedDirectional(
            top: heroHeight - AppSpacing.token7Xl - AppSpacing.token2Xs,
            start: horizontalInset,
            end: horizontalInset,
            bottom: keyboardInset + bottomInset + AppSpacing.token8Xl,
            child: Theme(
              data: inputTheme,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.only(bottom: AppSpacing.tokenL),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      if (_profile.error != null)
                        TextButton.icon(
                          onPressed: _profile.load,
                          icon: const Icon(Icons.refresh),
                          label:
                              Text('${l10n.errorGenericMessage} ${l10n.retry}'),
                        ),
                      ProfileEditAvatarCard(
                        photo: null,
                        avatarUrl: _profile.account?.avatarUrl,
                        photoLabel: l10n.profileEditPhoto,
                        cameraLabel: l10n.profileEditPhoto,
                        onChangePhoto: () =>
                            _showMessage(l10n.profileEditAvatarUnavailable),
                      ),
                      const SizedBox(height: AppSpacing.token2Xl),
                      ProfileEditField(
                        label: l10n.profileEditFullNameLabel,
                        controller: _nameController,
                        onChanged: (_) => _clearFieldError('full_name'),
                        textDirection: TextDirection.rtl,
                        validator: (value) {
                          if (_serverErrors['full_name'] != null) {
                            return _serverErrors['full_name'];
                          }
                          final failure = AppValidators.required()(value);
                          return failure == null
                              ? null
                              : ValidationMessageMapper.toMessage(
                                  failure,
                                  l10n,
                                );
                        },
                      ),
                      const SizedBox(height: AppSpacing.token2Xl),
                      Semantics(
                        button: true,
                        label: l10n.phoneChangeTitle,
                        child: InkWell(
                          onTap: _profile.account == null
                              ? null
                              : _openPhoneChange,
                          child: IgnorePointer(
                            child: ProfileEditField(
                              label: l10n.profileEditPhoneLabel,
                              controller: _phoneController,
                              readOnly: true,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.tokenS),
                      AppText(
                        l10n.profileEditPhoneHelper,
                        variant: AppTextVariant.bodySmall,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                          color: AppColors.primitives.neutral.shade600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.token2Xl),
                      ProfileEditField(
                        label: l10n.profileEditEmailLabel,
                        controller: _emailController,
                        onChanged: (_) => _clearFieldError('email'),
                        hintText: l10n.profileEditEmailHint,
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.rtl,
                        validator: (value) {
                          if (_serverErrors['email'] != null) {
                            return _serverErrors['email'];
                          }
                          if ((value?.trim().isEmpty ?? true) &&
                              _profile.account?.email != null) {
                            return l10n.profileEditEmailCannotRemove;
                          }
                          final failure = AppValidators.email()(value);
                          return failure == null
                              ? null
                              : ValidationMessageMapper.toMessage(
                                  failure,
                                  l10n,
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: horizontalInset,
            end: horizontalInset,
            bottom: keyboardInset + bottomInset + AppSpacing.tokenXl,
            child: PrimaryButton(
              label: l10n.profileEditSave,
              onPressed: _profile.account == null ? null : () => _save(l10n),
              semanticLabel: l10n.profileEditSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primitives.primary.shade500,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(AppSpacing.token6Xl),
                shape: const StadiumBorder(),
                textStyle: AppTypography.buyerMobile.bodyMedium
                    .toTextStyle(color: AppColors.primitives.neutral.shade100)
                    .copyWith(fontWeight: FontWeight.w700),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearFieldError(String field) {
    if (_serverErrors.remove(field) != null) {
      _formKey.currentState?.validate();
    }
  }

  Future<void> _save(AppLocalizations l10n) async {
    if (_profile.saving) return;
    FocusScope.of(context).unfocus();
    _serverErrors.clear();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = _emailController.text.trim();
    final result = await _profile.save(
      fullName: _nameController.text.trim(),
      email: email.isEmpty ? null : email,
      preferredLanguage: _profile.account?.preferredLanguage ??
          Localizations.localeOf(context).languageCode,
    );
    if (!mounted) return;
    if (result is ApiFailure<CustomerAccount>) {
      for (final param
          in result.error.invalidParams ?? const <ApiInvalidParam>[]) {
        if ((param.name == 'full_name' || param.name == 'email') &&
            param.reason.isNotEmpty) {
          _serverErrors[param.name] = param.reason;
        }
      }
      if (_serverErrors.isNotEmpty) _formKey.currentState?.validate();
      _showMessage(result.error.message);
      return;
    }
    final account = (result as ApiSuccess<CustomerAccount>).data;
    if (context.canPop()) {
      context.pop(account);
    } else {
      context.go(AppRoutes.profile);
    }
  }

  Future<void> _openPhoneChange() async {
    FocusScope.of(context).unfocus();
    final verifiedPhone = await context.push<String>(
      AppRoutes.changePhone,
      extra: _profile.account?.phone ?? '',
    );
    if (!mounted || verifiedPhone == null) return;
    final account = _profile.account;
    if (account != null)
      _profile.updateAccount(account.withPhone(verifiedPhone));
    _phoneController.text = verifiedPhone;
    _phoneUpdated = true;
    _showMessage(AppLocalizations.of(context)!.phoneChangeVerified);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop(_phoneUpdated ? _profile.account : null);
    } else {
      context.go(AppRoutes.profile);
    }
  }
}
