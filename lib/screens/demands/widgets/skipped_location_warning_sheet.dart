import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/components/buttons/primary_button.dart';
import 'package:shipments/components/buttons/secondary_button.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class SkippedLocationWarningSheet extends StatelessWidget {
  const SkippedLocationWarningSheet({
    super.key,
    required this.title,
    required this.description,
    required this.allowLocationLabel,
    required this.continueWithoutLocationLabel,
    required this.onAllowLocation,
    required this.onContinueWithoutLocation,
    required this.colors,
  });

  final String title;
  final String description;
  final String allowLocationLabel;
  final String continueWithoutLocationLabel;
  final VoidCallback onAllowLocation;
  final VoidCallback onContinueWithoutLocation;
  final AppColorPrimitives colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: colors.warning.shade100,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.warning_amber_rounded,
            color: colors.warning.shade800,
            size: 30,
          ),
        ),
        const SizedBox(height: AppSpacing.tokenL),
        AppText(
          title,
          variant: AppTextVariant.titleLarge,
          textAlign: TextAlign.center,
          style: AppTypography.buyerMobile.h4.toTextStyle(
            color: colors.neutral.shade900,
          ),
        ),
        const SizedBox(height: AppSpacing.tokenS),
        AppText(
          description,
          variant: AppTextVariant.bodySmall,
          textAlign: TextAlign.center,
          style: AppTypography.buyerMobile.bodySmall.toTextStyle(
            color: colors.neutral.shade600,
          ),
        ),
        const SizedBox(height: AppSpacing.tokenXl),
        PrimaryButton(
          label: allowLocationLabel,
          onPressed: onAllowLocation,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary.shade500,
            foregroundColor: colors.neutral.shade100,
            elevation: 0,
            minimumSize: const Size.fromHeight(52),
            shape: const StadiumBorder(),
            textStyle: AppTypography.buyerMobile.button.toTextStyle(),
          ),
        ),
        const SizedBox(height: AppSpacing.tokenS),
        SecondaryButton(
          label: continueWithoutLocationLabel,
          onPressed: onContinueWithoutLocation,
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.neutral.shade900,
            side: BorderSide(color: colors.neutral.shade300),
            minimumSize: const Size.fromHeight(52),
            shape: const StadiumBorder(),
            textStyle: AppTypography.buyerMobile.button.toTextStyle(),
          ),
        ),
      ],
    );
  }
}
