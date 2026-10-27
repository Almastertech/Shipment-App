import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../l10n/app_localizations.dart';

class DemandReviewDescriptionInput extends StatelessWidget {
  const DemandReviewDescriptionInput({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const colors = AppColors.primitives;
    final hasText = controller.text.isNotEmpty;

    return Container(
      height: 118,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.tokenM,
        AppSpacing.tokenS,
        AppSpacing.tokenM,
        AppSpacing.tokenXs,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: hasText ? colors.primary.shade500 : colors.neutral.shade300,
          width: hasText ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              maxLength: 300,
              maxLines: null,
              expands: true,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              style: AppTypography.buyerMobile.bodySmall
                  .toTextStyle(color: colors.neutral.shade900),
              decoration: InputDecoration(
                hintText: l10n.demandReviewDescriptionHint,
                hintStyle: AppTypography.buyerMobile.bodySmall
                    .toTextStyle(color: colors.neutral.shade500),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                counterText: '',
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: onChanged,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: AppText(
              l10n.demandReviewCharacterCount(controller.text.length),
              variant: AppTextVariant.labelSmall,
              style: AppTypography.buyerMobile.caption.toTextStyle(
                color: colors.neutral.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
