
import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';
import 'package:shipments/features/notifications/presentation/notification_bell_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.greeting, required this.title});

  final String greeting;
  final String title;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final text = AppColors.semantic.text.primary;

    return SizedBox(
      height: 58,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 23,
            backgroundColor: primary.shade100,
            child: Icon(
              Icons.person_rounded,
              color: primary.shade500,
              size: 26,
            ),
          ),
          const SizedBox(width: AppSpacing.tokenS),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  greeting,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: primary.shade500,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  title,
                  variant: AppTextVariant.titleLarge,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.h4.toTextStyle(
                    color: text,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.tokenM),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.primitives.neutral.shade200,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 48,
              height: 48,
              child: IconTheme(
                data: IconThemeData(
                  color: AppColors.semantic.text.secondary,
                  size: 22,
                ),
                child: const NotificationBellButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
