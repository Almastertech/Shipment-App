import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_text.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/buttons/text_link_button.dart';
import '../../../components/layout/app_bottom_sheet.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ProfileLogoutBottomSheet {
  const ProfileLogoutBottomSheet._();

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
  }) async {
    final result = await AppBottomSheet.show<bool>(
      context,
      isScrollControlled: false,
      useSafeArea: true,
      barrierColor: Colors.black.withValues(alpha: .55),
      backgroundColor: AppColors.semantic.surface.primary,
      topRadius: AppRadius.token3Xl,
      topPadding: AppSpacing.tokenS,
      handleBottomSpacing: AppSpacing.tokenXl,
      maxWidth: 440,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.token2Xl,
        0,
        AppSpacing.token2Xl,
        AppSpacing.tokenM,
      ),
      child: _ProfileLogoutContent(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
      ),
    );

    return result ?? false;
  }
}

class _ProfileLogoutContent extends StatelessWidget {
  const _ProfileLogoutContent({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final text = AppColors.semantic.text;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colors.primary.shade100,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppImages.logout,
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                colors.failure.shade500,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.token2Xl),
        AppText(
          title,
          variant: AppTextVariant.titleLarge,
          textAlign: TextAlign.center,
          style: AppTypography.buyerMobile.h4
              .toTextStyle(color: text.primary)
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.tokenS),
        AppText(
          message,
          variant: AppTextVariant.bodySmall,
          textAlign: TextAlign.center,
          style: AppTypography.buyerMobile.bodySmall.toTextStyle(
            color: colors.neutral.shade700,
          ),
        ),
        const SizedBox(height: AppSpacing.token2Xl),
        PrimaryButton(
          label: confirmLabel,
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.failure.shade500,
            foregroundColor: colors.neutral.shade100,
            minimumSize: const Size.fromHeight(56),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.token2Xl,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.tokenFull),
            ),
            elevation: 0,
            textStyle: AppTypography.buyerMobile.bodyMedium
                .toTextStyle(color: colors.neutral.shade100)
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: AppSpacing.tokenS),
        TextLinkButton(
          label: cancelLabel,
          onPressed: () => Navigator.of(context).pop(false),
          foregroundColor: colors.primary.shade500,
          textStyle: AppTypography.buyerMobile.bodyMedium.toTextStyle(
            color: colors.primary.shade500,
          ).copyWith(fontWeight: FontWeight.w700),
          buttonStyle: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
