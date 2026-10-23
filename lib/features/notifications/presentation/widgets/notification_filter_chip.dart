import 'package:flutter/material.dart';

import '../../../../components/app_card.dart';
import '../../../../components/app_text.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_spacing.dart';
import '../../../../core/resources/app_typography.dart';

class NotificationFilterChip extends StatelessWidget {
  const NotificationFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Material(
        color: selected ? colors.accent01.shade300 : Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected
                ? Colors.transparent
                : Colors.white.withValues(alpha: .56),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.tokenL,
              vertical: AppSpacing.tokenS,
            ),
            child: AppText(
              label,
              variant: AppTextVariant.labelSmall,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: AppTypography.buyerMobile.labelSmall
                  .toTextStyle(
                    color: selected ? colors.neutral.shade900 : Colors.white,
                  )
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationItemCard extends StatelessWidget {
  const NotificationItemCard({
    super.key,
    required this.item,
    required this.timeLabel,
    required this.onTap,
  });

  final NotificationCardData item;
  final String timeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;
    final isReview = item.title.toLowerCase().contains('review') ||
        item.title.contains('المراجعة');
    final iconStyle = _iconStyle(item.type, isReview, colors);

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.tokenL),
      color: AppColors.semantic.surface.primary,
      onTap: onTap,
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconStyle.background,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(iconStyle.icon, color: iconStyle.foreground, size: 24),
          ),
          const SizedBox(width: AppSpacing.tokenM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppText(
                  item.title,
                  variant: AppTextVariant.bodyMedium,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodyMedium
                      .toTextStyle(
                        color: colors.neutral.shade900,
                      )
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  item.message,
                  variant: AppTextVariant.bodySmall,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: colors.neutral.shade700,
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  timeLabel,
                  variant: AppTextVariant.labelSmall,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: colors.neutral.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.tokenM),
          SizedBox(
            width: 10,
            child: item.isRead
                ? null
                : Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: colors.accent01.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _NotificationIconStyle _iconStyle(
    NotificationCardType type,
    bool isReview,
    AppColorPrimitives colors,
  ) {
    if (isReview) {
      return _NotificationIconStyle(
        icon: Icons.more_time_rounded,
        background: colors.neutral.shade200,
        foreground: colors.neutral.shade700,
      );
    }

    return switch (type) {
      NotificationCardType.claim => _NotificationIconStyle(
          icon: Icons.camera_alt_outlined,
          background: colors.accent01.shade100,
          foreground: colors.warning.shade700,
        ),
      NotificationCardType.shipment => _NotificationIconStyle(
          icon: Icons.inventory_2_outlined,
          background: colors.primary.shade100,
          foreground: colors.primary.shade500,
        ),
      NotificationCardType.protection => _NotificationIconStyle(
          icon: Icons.shield_outlined,
          background: colors.accent01.shade100,
          foreground: colors.warning.shade700,
        ),
      NotificationCardType.success => _NotificationIconStyle(
          icon: Icons.check_rounded,
          background: colors.success.shade100,
          foreground: colors.success.shade600,
        ),
      NotificationCardType.info => _NotificationIconStyle(
          icon: Icons.info_outline_rounded,
          background: colors.neutral.shade200,
          foreground: colors.neutral.shade700,
        ),
    };
  }
}

enum NotificationCardType { claim, shipment, protection, success, info }

class NotificationCardData {
  const NotificationCardData({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.type,
    required this.isRead,
    this.sampleTimeKey,
  });

  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final NotificationCardType type;
  final bool isRead;
  final String? sampleTimeKey;
}

class _NotificationIconStyle {
  const _NotificationIconStyle({
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
}
