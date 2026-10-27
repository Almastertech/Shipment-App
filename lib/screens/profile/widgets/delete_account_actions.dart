import 'package:flutter/material.dart';

import '../../../components/buttons/primary_button.dart';
import '../../../components/buttons/secondary_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class DeleteAccountActions extends StatelessWidget {
  const DeleteAccountActions({
    super.key,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    required this.onCancel,
  });

  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  static const double _buttonHeight = AppSpacing.token6Xl;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        PrimaryButton(
          label: confirmLabel,
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.failure.shade500,
            foregroundColor: colors.neutral.shade100,
            minimumSize: const Size.fromHeight(_buttonHeight),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenL),
            shape: const StadiumBorder(),
            elevation: 0,
            textStyle: AppTypography.buyerMobile.button.toTextStyle(
              color: colors.neutral.shade100,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: AppSpacing.tokenS),
        SecondaryButton(
          label: cancelLabel,
          onPressed: onCancel,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.semantic.text.primary,
            minimumSize: const Size.fromHeight(_buttonHeight),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenL),
            side: BorderSide(color: colors.neutral.shade300, width: 1.5),
            shape: const StadiumBorder(),
            textStyle: AppTypography.buyerMobile.button.toTextStyle(
              color: AppColors.semantic.text.primary,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
