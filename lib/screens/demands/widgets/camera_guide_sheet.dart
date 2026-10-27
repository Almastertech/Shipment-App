import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/layout/app_bottom_sheet.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../l10n/app_localizations.dart';

class CameraGuideSheet extends StatelessWidget {
  const CameraGuideSheet({
    super.key,
    required this.categoryIndex,
    required this.isVideo,
    required this.onReady,
  });

  final int categoryIndex;
  final bool isVideo;
  final VoidCallback onReady;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = AppColors.semantic.text;
    final detail = switch (categoryIndex) {
      0 => l10n.cameraGuideDocuments,
      1 => l10n.cameraGuidePackaging,
      2 => l10n.cameraGuideDamage,
      _ => l10n.cameraGuideDocuments,
    };
    final checklist = <String>[
      l10n.cameraGuideShippingLabel,
      l10n.cameraGuideTrackingNumber,
      l10n.cameraGuideIncludedDocuments,
    ];

    return AppBottomSheet(
      padding: EdgeInsets.zero,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppText(
                l10n.cameraGuideQuestion,
                variant: AppTextVariant.headlineSmall,
                textAlign: TextAlign.end,
                style: AppTypography.buyerMobile.h3.toTextStyle(
                  color: text.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.tokenXs),
              AppText(
                isVideo ? detail : l10n.cameraGuidePhotoHint,
                variant: AppTextVariant.bodySmall,
                textAlign: TextAlign.end,
                style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                  color: text.secondary,
                ),
              ),
              const SizedBox(height: AppSpacing.tokenM),
              ...checklist.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 48),
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      14,
                      8,
                      12,
                      8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primitives.neutral.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_rounded,
                          color: AppColors.primitives.primary.shade500,
                          size: 20,
                        ),
                        const Spacer(),
                        Flexible(
                          child: AppText(
                            item,
                            variant: AppTextVariant.bodyMedium,
                            textAlign: TextAlign.end,
                            style: AppTypography.buyerMobile.bodyMedium
                                .toTextStyle(color: text.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.tokenS),
              PrimaryButton(
                label: l10n.cameraGuideReady,
                onPressed: onReady,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: const StadiumBorder(),
                  textStyle: AppTypography.buyerMobile.button.toTextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
