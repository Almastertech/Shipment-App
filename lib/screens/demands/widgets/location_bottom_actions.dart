import 'package:flutter/material.dart';

import '../../../components/buttons/primary_button.dart';
import '../../../components/buttons/text_link_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class LocationBottomActions extends StatelessWidget {
  const LocationBottomActions({
    super.key,
    required this.allowLocationLabel,
    required this.notNowLabel,
    required this.onAllowLocation,
    required this.onNotNow,
    this.isLoading = false,
  });

  final String allowLocationLabel;
  final String notNowLabel;
  final VoidCallback onAllowLocation;
  final VoidCallback onNotNow;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.tokenXl,
          AppSpacing.tokenXs,
          AppSpacing.tokenXl,
          AppSpacing.tokenXs,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            PrimaryButton(
              label: allowLocationLabel,
              onPressed: onAllowLocation,
              isLoading: isLoading,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary.shade500,
                foregroundColor: colors.neutral.shade100,
                disabledBackgroundColor: colors.primary.shade400,
                elevation: 0,
                minimumSize: const Size.fromHeight(52),
                shape: const StadiumBorder(),
                textStyle: AppTypography.buyerMobile.button.toTextStyle(),
              ),
            ),
            TextLinkButton(
              label: notNowLabel,
              onPressed: onNotNow,
              foregroundColor: colors.primary.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
