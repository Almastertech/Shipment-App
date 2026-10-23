import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/inputs/app_text_field.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_tap_target.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import '../demands/widgets/dash_border_painter.dart';
import 'widgets/activity_filter_chip.dart';
import 'widgets/profile_subpage_hero.dart';

enum _TicketCategory { claim, shipment, account }

class CreateSupportTicketScreen extends StatefulWidget {
  const CreateSupportTicketScreen({super.key});

  @override
  State<CreateSupportTicketScreen> createState() =>
      _CreateSupportTicketScreenState();
}

class _CreateSupportTicketScreenState extends State<CreateSupportTicketScreen> {
  static const double _noteHeight = 52;
  static const double _noteOverlap = 36;
  static const int _maxDescriptionLength = 1000;
  static const int _maxAttachmentCount = 5;
  static const int _maxAttachmentSize = 10 * 1024 * 1024;

  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _shipmentNumberController = TextEditingController();
  final List<PlatformFile> _attachments = <PlatformFile>[];

  _TicketCategory _category = _TicketCategory.claim;

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
              height: heroHeight + _noteHeight - _noteOverlap,
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
                    top: heroHeight - _noteOverlap - AppSpacing.token3Xl,
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    child: _RequiredFieldsNote(
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
                      _SectionLabel(
                        text: l10n.createSupportTicketCategoryLabel,
                      ),
                      const SizedBox(height: AppSpacing.tokenS),
                      _CategoryOptions(
                        selected: _category,
                        labels: <_TicketCategory, String>{
                          _TicketCategory.claim: l10n.createSupportTicketClaims,
                          _TicketCategory.shipment:
                              l10n.createSupportTicketShipments,
                          _TicketCategory.account:
                              l10n.createSupportTicketAccount,
                        },
                        onChanged: (value) => setState(() => _category = value),
                      ),
                      const SizedBox(height: AppSpacing.token3Xl),
                      _SectionLabel(text: l10n.createSupportTicketSubjectLabel),
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
                      _SectionLabel(
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
                      _SectionLabel(
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
                      _SectionLabel(
                        text: l10n.createSupportTicketAttachmentsLabel,
                      ),
                      const SizedBox(height: AppSpacing.tokenS),
                      _AttachmentPicker(
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
    final l10n = AppLocalizations.of(context)!;
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

class _RequiredFieldsNote extends StatelessWidget {
  const _RequiredFieldsNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Container(
      height: _CreateSupportTicketScreenState._noteHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenXl),
      decoration: BoxDecoration(
        color: AppColors.semantic.surface.primary,
        borderRadius: BorderRadius.circular(AppRadius.tokenXl),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: AlignmentDirectional.centerStart,
      child: AppText(
        text,
        variant: AppTextVariant.labelMedium,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: AppTypography.buyerMobile.label
            .toTextStyle(
              color: colors.neutral.shade700,
            )
            .copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      variant: AppTextVariant.labelMedium,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: AppTypography.buyerMobile.label.toTextStyle(
        color: AppColors.primitives.neutral.shade900,
      ),
    );
  }
}

class _CategoryOptions extends StatelessWidget {
  const _CategoryOptions({
    required this.selected,
    required this.labels,
    required this.onChanged,
  });

  final _TicketCategory selected;
  final Map<_TicketCategory, String> labels;
  final ValueChanged<_TicketCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: Directionality.of(context),
        children: <Widget>[
          for (var index = 0;
              index < _TicketCategory.values.length;
              index++) ...<Widget>[
            if (index > 0) const SizedBox(width: AppSpacing.tokenS),
            ActivityFilterChip(
              label: labels[_TicketCategory.values[index]]!,
              selected: selected == _TicketCategory.values[index],
              onTap: () => onChanged(_TicketCategory.values[index]),
            ),
          ],
        ],
      ),
    );
  }
}

class _AttachmentPicker extends StatelessWidget {
  const _AttachmentPicker({
    required this.attachments,
    required this.onTap,
    required this.onRemove,
    required this.title,
    required this.description,
    required this.removeLabel,
  });

  final List<PlatformFile> attachments;
  final VoidCallback onTap;
  final ValueChanged<PlatformFile> onRemove;
  final String title;
  final String description;
  final String removeLabel;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final radius = BorderRadius.circular(AppRadius.tokenL);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Semantics(
          button: true,
          label: title,
          child: Material(
            color: colors.neutral.shade200,
            borderRadius: radius,
            child: InkWell(
              onTap: onTap,
              borderRadius: radius,
              child: CustomPaint(
                painter: DashedBorderPainter(
                  color: colors.neutral.shade300,
                  radius: AppRadius.tokenL,
                ),
                child: SizedBox(
                  height: 96,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        AppImages.document,
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(height: AppSpacing.tokenS),
                      AppText(
                        title,
                        variant: AppTextVariant.labelMedium,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: AppTypography.buyerMobile.label
                            .toTextStyle(
                              color: colors.primary.shade500,
                            )
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppSpacing.token3Xs),
                      AppText(
                        description,
                        variant: AppTextVariant.labelSmall,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                          color: colors.neutral.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (attachments.isNotEmpty) ...<Widget>[
          const SizedBox(height: AppSpacing.tokenS),
          for (final attachment in attachments)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.tokenXs),
              child: _AttachmentRow(
                file: attachment,
                removeLabel: removeLabel,
                onRemove: () => onRemove(attachment),
              ),
            ),
        ],
      ],
    );
  }
}

class _AttachmentRow extends StatelessWidget {
  const _AttachmentRow({
    required this.file,
    required this.removeLabel,
    required this.onRemove,
  });

  final PlatformFile file;
  final String removeLabel;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Row(
      children: <Widget>[
        Icon(Icons.insert_drive_file_outlined, color: colors.primary.shade500),
        const SizedBox(width: AppSpacing.tokenS),
        Expanded(
          child: AppText(
            file.name,
            variant: AppTextVariant.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.bodySmall.toTextStyle(
              color: colors.neutral.shade900,
            ),
          ),
        ),
        IconButton(
          onPressed: onRemove,
          tooltip: removeLabel,
          icon: Icon(Icons.close_rounded, color: colors.neutral.shade600),
        ),
      ],
    );
  }
}
