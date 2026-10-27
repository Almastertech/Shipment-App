import 'package:flutter/material.dart';
import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_typography.dart';

class ProfileFooter extends StatelessWidget {
  const ProfileFooter({
    super.key,
    required this.versionLabel,
    required this.creditsLabel,
  });

  final String versionLabel;
  final String creditsLabel;

  @override
  Widget build(BuildContext context) {
    final text = AppColors.semantic.text;

    return Column(
      children: <Widget>[
        AppText(
          versionLabel,
          variant: AppTextVariant.bodySmall,
          textAlign: TextAlign.center,
          style: AppTypography.buyerMobile.caption.toTextStyle(
            color: text.tertiary,
          ),
        ),
        // const SizedBox(height: AppSpacing.token2Xs),
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   textDirection: TextDirection.rtl,
        //   children: <Widget>[
        //     AppText(
        //       creditsLabel,
        //       variant: AppTextVariant.bodySmall,
        //       textAlign: TextAlign.center,
        //       style: AppTypography.buyerMobile.caption.toTextStyle(
        //         color: text.tertiary,
        //       ),
        //     ),
        //     const SizedBox(width: AppSpacing.token2Xs),
        //     SvgPicture.asset(
        //       AppImages.alMaster,
        //       width: 8,
        //       height: 9,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
