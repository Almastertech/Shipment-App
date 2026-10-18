import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';
import 'package:shipments/features/notifications/presentation/notification_bell_button.dart';
import 'package:shipments/screens/shipments/widgets/shipments_dot_marks.dart';
import 'package:shipments/screens/shipments/widgets/shipments_filter.dart';

class ShipmentsHero extends StatelessWidget {
  const ShipmentsHero({
    super.key,
    required this.title,
    required this.subtitle,
    required this.activeLabel,
    required this.deliveredLabel,
    required this.selectedIndex,
    required this.onSelect,
  });

  final String title;
  final String subtitle;
  final String activeLabel;
  final String deliveredLabel;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final topInset = MediaQuery.paddingOf(context).top;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(AppRadius.token2Xl),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            AppImages.boxesStack,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: primary.shade900.withValues(alpha: .66),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  primary.shade900.withValues(alpha: .35),
                  primary.shade800.withValues(alpha: .82),
                  primary.shade700,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenXl,
              topInset + AppSpacing.tokenS,
              AppSpacing.tokenXl,
              AppSpacing.tokenL,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .16),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .48),
                        ),
                      ),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: IconTheme(
                          data: IconThemeData(
                            color: Colors.white,
                            size: 21,
                          ),
                          child: NotificationBellButton(),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const ShipmentDotsMark(),
                  ],
                ),
                const SizedBox(height: AppSpacing.token3Xl),
                AppText(
                  title,
                  variant: AppTextVariant.headlineMedium,
                  textAlign: TextAlign.end,
                  style: AppTypography.buyerMobile.h2.toTextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  subtitle,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: Colors.white.withValues(alpha: .82),
                  ),
                ),
                const SizedBox(height: AppSpacing.token4Xl),
                ShipmentFilters(
                  activeLabel: activeLabel,
                  deliveredLabel: deliveredLabel,
                  selectedIndex: selectedIndex,
                  onSelect: onSelect,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
