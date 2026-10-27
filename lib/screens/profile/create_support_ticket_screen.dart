import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/inputs/app_text_field.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_tap_target.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/create_support_ticket_widgets.dart';
import 'widgets/profile_subpage_hero.dart';

class CreateSupportTicketScreen extends StatefulWidget {
  const CreateSupportTicketScreen({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  State<CreateSupportTicketScreen> createState() =>
      _CreateSupportTicketScreenState();
}

class _CreateSupportTicketScreenState extends State<CreateSupportTicketScreen> {
  static const int _maxDescriptionLength = 1000;
  static const int _maxAttachmentCount = 5;
  static const int _maxAttachmentSize = 10 * 1024 * 1024;

  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _shipmentNumberController = TextEditingController();
  final List<PlatformFile> _attachments = <PlatformFile>[];

  TicketCategory _category = TicketCategory.claim;
  bool _isPickingAttachments = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    _shipmentNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final heroHeight = math.max(
      280.0,
      MediaQuery.sizeOf(context).width * .75,
    ).toDouble();
    final inputTheme = _inputTheme(context);

    return AppScaffold(
      isLoading: widget.isLoading || _isPickingAttachments,
      loadingLabel: l10n.loading,
      padding: EdgeInsets.zero,
      safeArea: false,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.token2Xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: heroHeight + TicketRequiredFieldsNote.height - TicketRequiredFieldsNote.overlap,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    height: heroHeight,
                    child: ProfileSubpageHero(
                      title: l10n.createSupportTicketTitle,
                      subtitle: l10n.createSupportTicketSubtitle,
                      backLabel: l10n.navigationBack,
                      onBack: () => _goBack(context),
                    ),
                  ),
                  PositionedDirectional(
                    top: heroHeight - TicketRequiredFieldsNote.overlap - AppSpacing.token3Xl,
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    child: TicketRequiredFieldsNote(
                      text: l10n.createSupportTicketRequiredNote,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.tokenXl,
              ),
              child: Theme(
                data: inputTheme,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: AppSpacing.tokenXl),
                      TicketSectionLabel(
                        text: l10n.createSupportTicketCategoryLabel,
                      ),
                      const SizedBox(height: AppSpacing.tokenS),
                      TicketCategoryOptions(
                        selected: _category,
                        labels: <TicketCategory, String>{
                          TicketCategory.claim: l10n.createSupportTicketClaims,
                          TicketCategory.shipment:
                              l10n.createSupportTicketShipments,
                          TicketCategory.account:
                              l10n.createSupportTicketAccount,
                        },
                        onChanged: (value) => setState(() => _category = value),
                      ),
                      const SizedBox(height: AppSpacing.token3Xl),
                      TicketSectionLabel(text: l10n.createSupportTicketSubjectLabel),
                      const SizedBox(height: AppSpacing.tokenS),
                      AppTextField(
                        controller: _subjectController,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        hintText: l10n.createSupportTicketSubjectHint,
                        style: _fieldTextStyle,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? l10n.createSupportTicketRequiredError
                                : null,
                      ),
                      const SizedBox(height: AppSpacing.token2Xl),
                      TicketSectionLabel(
                        text: l10n.createSupportTicketDescriptionLabel,
                      ),
                      const SizedBox(height: AppSpacing.tokenS),
                      AppTextField(
                        controller: _descriptionController,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        hintText: l10n.createSupportTicketDescriptionHint,
                        style: _fieldTextStyle,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 4,
                        maxLines: 4,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(
                            _maxDescriptionLength,
                          ),
                        ],
                        onChanged: (_) => setState(() {}),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? l10n.createSupportTicketRequiredError
                                : null,
                      ),
                      const SizedBox(height: AppSpacing.token3Xs),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: AppText(
                          l10n.createSupportTicketCharacterCount(
                            _descriptionController.text.length,
                            _maxDescriptionLength,
                          ),
                          variant: AppTextVariant.labelSmall,
                          textDirection: TextDirection.rtl,
                          style: AppTypography.buyerMobile.caption.toTextStyle(
                            color: AppColors.primitives.neutral.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.token2Xl),
                      TicketSectionLabel(
                        text: l10n.createSupportTicketShipmentLabel,
                      ),
                      const SizedBox(height: AppSpacing.tokenS),
                      AppTextField(
                        controller: _shipmentNumberController,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        hintText: l10n.createSupportTicketShipmentHint,
                        style: _fieldTextStyle,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: AppSpacing.token2Xs),
                      AppText(
                        l10n.createSupportTicketShipmentHelper,
                        variant: AppTextVariant.labelSmall,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                          color: AppColors.primitives.neutral.shade600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.token2Xl),
                      TicketSectionLabel(
                        text: l10n.createSupportTicketAttachmentsLabel,
                      ),
                      const SizedBox(height: AppSpacing.tokenS),
                      TicketAttachmentPicker(
                        attachments: _attachments,
                        onTap: _pickAttachments,
                        onRemove: _removeAttachment,
                        title: l10n.createSupportTicketUploadTitle,
                        description: l10n.createSupportTicketUploadDescription,
                        removeLabel: l10n.createSupportTicketRemoveAttachment,
                      ),
                      const SizedBox(height: AppSpacing.token3Xl),
                      PrimaryButton(
                        label: l10n.createSupportTicketSubmit,
                        onPressed: () => _submit(l10n),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(
                            AppTapTarget.actionButtonHeight,
                          ),
                          backgroundColor:
                              AppColors.primitives.primary.shade500,
                          foregroundColor:
                              AppColors.primitives.neutral.shade100,
                          shape: const StadiumBorder(),
                          textStyle: AppTypography.buyerMobile.bodyMedium
                              .toTextStyle(
                                color: AppColors.primitives.neutral.shade100,
                              )
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static TextStyle get _fieldTextStyle => AppTypography.buyerMobile.bodyMedium
      .toTextStyle(
        color: AppColors.primitives.neutral.shade900,
      )
      .copyWith(fontWeight: FontWeight.w500);

  ThemeData _inputTheme(BuildContext context) {
    const colors = AppColors.primitives;
    final shape = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.tokenL),
      borderSide: BorderSide(color: colors.neutral.shade300),
    );

    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        constraints: const BoxConstraints(minHeight: 58),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenL,
          vertical: AppSpacing.tokenL,
        ),
        hintStyle: AppTypography.buyerMobile.bodyMedium
            .toTextStyle(
              color: colors.neutral.shade700,
            )
            .copyWith(fontWeight: FontWeight.w500),
        enabledBorder: shape,
        focusedBorder: shape.copyWith(
          borderSide: BorderSide(color: colors.primary.shade500, width: 1.5),
        ),
        errorBorder: shape.copyWith(
          borderSide: BorderSide(color: colors.failure.shade500),
        ),
        focusedErrorBorder: shape.copyWith(
          borderSide: BorderSide(color: colors.failure.shade500, width: 1.5),
        ),
      ),
    );
  }

  Future<void> _pickAttachments() async {
    if (_isPickingAttachments) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isPickingAttachments = true);
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const <String>['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: true,
      );
      if (result == null || !mounted) return;

      final remainingSlots = _maxAttachmentCount - _attachments.length;
      if (result.files.length > remainingSlots) {
        _showMessage(l10n.createSupportTicketAttachmentLimit);
        return;
      }

      final oversized = result.files.any(
        (file) => file.size > _maxAttachmentSize,
      );
      if (oversized) {
        _showMessage(l10n.createSupportTicketAttachmentSizeLimit);
        return;
      }

      setState(() => _attachments.addAll(result.files));
    } catch (_) {
      if (!mounted) return;
      _showMessage(l10n.createSupportTicketPickerError);
    } finally {
      if (mounted) setState(() => _isPickingAttachments = false);
    }
  }

  void _removeAttachment(PlatformFile file) {
    setState(() => _attachments.remove(file));
  }

  void _submit(AppLocalizations l10n) {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _showMessage(l10n.createSupportTicketSubmitUnavailable);
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
      context.go(AppRoutes.supportTickets);
    }
  }
}
