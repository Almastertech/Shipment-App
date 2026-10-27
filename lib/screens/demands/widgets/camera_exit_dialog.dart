import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../l10n/app_localizations.dart';

Future<bool?> showCameraExitConfirmationDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black54,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primitives.failure.shade100,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.warning_amber_rounded,
                  size: 30,
                  color: AppColors.primitives.failure.shade600,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.tokenM),
            AppText(
              l10n.cameraExitTitle,
              variant: AppTextVariant.titleLarge,
              textAlign: TextAlign.center,
              style: AppTypography.buyerMobile.h4.toTextStyle(
                color: AppColors.primitives.neutral.shade900,
              ),
            ),
            const SizedBox(height: AppSpacing.tokenS),
            AppText(
              l10n.cameraExitDescription,
              variant: AppTextVariant.bodySmall,
              textAlign: TextAlign.center,
              style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                color: AppColors.primitives.neutral.shade600,
              ),
            ),
            const SizedBox(height: AppSpacing.tokenL),
            PrimaryButton(
              label: l10n.cameraContinueClaim,
              onPressed: () => Navigator.of(dialogContext).pop(false),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: const StadiumBorder(),
                textStyle: AppTypography.buyerMobile.button.toTextStyle(),
              ),
            ),
            const SizedBox(height: AppSpacing.tokenXs),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primitives.failure.shade600,
                textStyle: AppTypography.buyerMobile.button.toTextStyle(),
              ),
              child: Text(l10n.cameraExitClaim),
            ),
          ],
        ),
      ),
    ),
  );
}
