import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../demands/widgets/dash_border_painter.dart';
import 'activity_filter_chip.dart';

enum TicketCategory { claim, shipment, account }

class TicketRequiredFieldsNote extends StatelessWidget {
  static const double height = 52;
  static const double overlap = 36;

  const TicketRequiredFieldsNote({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Container(
      height: height,
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

class TicketSectionLabel extends StatelessWidget {
  const TicketSectionLabel({super.key, required this.text});

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

class TicketCategoryOptions extends StatelessWidget {
  const TicketCategoryOptions({
    super.key,
    required this.selected,
    required this.labels,
    required this.onChanged,
  });

  final TicketCategory selected;
  final Map<TicketCategory, String> labels;
  final ValueChanged<TicketCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: Directionality.of(context),
        children: <Widget>[
          for (var index = 0;
              index < TicketCategory.values.length;
              index++) ...<Widget>[
            if (index > 0) const SizedBox(width: AppSpacing.tokenS),
            ActivityFilterChip(
              label: labels[TicketCategory.values[index]]!,
              selected: selected == TicketCategory.values[index],
              onTap: () => onChanged(TicketCategory.values[index]),
            ),
          ],
        ],
      ),
    );
  }
}

class TicketAttachmentPicker extends StatelessWidget {
  const TicketAttachmentPicker({
    super.key,
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
              child: TicketAttachmentRow(
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

class TicketAttachmentRow extends StatelessWidget {
  const TicketAttachmentRow({
    super.key,
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
