import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/inputs/app_text_field.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../core/validation/app_validators.dart';
import '../../core/validation/validation_message_mapper.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/profile_edit_avatar_card.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _imagePicker = ImagePicker();
  XFile? _photo;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    final l10n = AppLocalizations.of(context)!;
    _nameController.text = l10n.profileEditFullName;
    _phoneController.text = l10n.profilePhone;
    _initialized = true;
  }

  @override
  void dispose() {
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
    final horizontalInset = AppSpacing.token2Xl;
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
                      ProfileEditAvatarCard(
                        photo: _photo,
                        photoLabel: l10n.profileEditPhoto,
                        cameraLabel: l10n.profileEditPhoto,
                        onChangePhoto: _pickPhoto,
                      ),
                      const SizedBox(height: AppSpacing.token2Xl),
                      _EditField(
                        label: l10n.profileEditFullNameLabel,
                        controller: _nameController,
                        textDirection: TextDirection.rtl,
                        validator: (value) {
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
                      _EditField(
                        label: l10n.profileEditPhoneLabel,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        validator: (value) {
                          final normalized = value?.replaceAll(
                            RegExp(r'[\s()-]'),
                            '',
                          );
                          final requiredFailure =
                              AppValidators.required()(normalized);
                          final failure = requiredFailure ??
                              AppValidators.phone()(normalized);
                          return failure == null
                              ? null
                              : ValidationMessageMapper.toMessage(
                                  failure,
                                  l10n,
                                );
                        },
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
                      _EditField(
                        label: l10n.profileEditEmailLabel,
                        controller: _emailController,
                        hintText: l10n.profileEditEmailHint,
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.rtl,
                        validator: (value) {
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
              onPressed: () => _save(l10n),
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

  Future<void> _pickPhoto() async {
    try {
      final selected = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
      );
      if (selected != null && mounted) setState(() => _photo = selected);
    } catch (_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      _showMessage(l10n.profileEditPhotoUnavailable);
    }
  }

  void _save(AppLocalizations l10n) {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _showMessage(l10n.profileEditSaveUnavailable);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }
}

class _EditField extends StatelessWidget {
  const _EditField({
    required this.label,
    required this.controller,
    required this.textDirection,
    this.hintText,
    this.keyboardType,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final TextDirection textDirection;
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.tokenS),
          child: AppText(
            label,
            variant: AppTextVariant.labelMedium,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: AppTypography.buyerMobile.label.toTextStyle(
              color: AppColors.primitives.neutral.shade900,
            ),
          ),
        ),
        AppTextField(
          controller: controller,
          hintText: hintText,
          keyboardType: keyboardType,
          textDirection: textDirection,
          textAlign: TextAlign.right,
          style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
            color: AppColors.primitives.neutral.shade900,
          ).copyWith(fontWeight: FontWeight.w500),
          validator: validator,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
