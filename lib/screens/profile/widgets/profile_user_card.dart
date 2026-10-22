import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({
    super.key,
    required this.name,
    required this.phone,
    required this.compensationsLabel,
    required this.compensationsValue,
    required this.claimsLabel,
    required this.claimsValue,
    required this.shipmentsLabel,
    required this.shipmentsValue,
    this.avatarAsset,
    this.onEdit,
  });

  final String name;
  final String phone;
  final String compensationsLabel;
  final String compensationsValue;
  final String claimsLabel;
  final String claimsValue;
  final String shipmentsLabel;
  final String shipmentsValue;
  final String? avatarAsset;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        child: ColoredBox(
          color: colors.primary.shade700,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              PositionedDirectional(
                top: -100,
                end: -80,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.primary.shade500.withValues(alpha: 0.45),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.tokenXl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _ProfileAvatar(avatarAsset: avatarAsset),
                        const SizedBox(width: AppSpacing.tokenS),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppText(
                                name,
                                variant: AppTextVariant.titleLarge,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.buyerMobile.h5.toTextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              AppText(
                                phone,
                                variant: AppTextVariant.bodySmall,
                                textAlign: TextAlign.start,
                                textDirection: TextDirection.ltr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.buyerMobile.bodySmall
                                    .toTextStyle(
                                  color: Colors.white.withValues(alpha: .75),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.tokenS),
                        _EditProfileButton(onPressed: onEdit),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.tokenXl),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.white.withValues(alpha: .14),
                    ),
                    const SizedBox(height: AppSpacing.tokenXl),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _ProfileStat(
                            label: compensationsLabel,
                            value: compensationsValue,
                            valueColor: colors.mint.shade400,
                          ),
                        ),
                        Expanded(
                          child: _ProfileStat(
                            label: claimsLabel,
                            value: claimsValue,
                          ),
                        ),
                        Expanded(
                          child: _ProfileStat(
                            label: shipmentsLabel,
                            value: shipmentsValue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({this.avatarAsset});

  final String? avatarAsset;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives.primary;

    final image = avatarAsset ?? AppImages.profileAvatar;

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.shade400,
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        width: 64,
        height: 64,
        errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
          AppImages.user,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Semantics(
      button: true,
      child: Material(
        color: AppColors.primitives.neutral.shade100.withValues(alpha: 0.10),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: SvgPicture.asset(
                AppImages.edit,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  colors.accent01.shade300,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppText(
          label,
          variant: AppTextVariant.bodySmall,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.bodySmall.toTextStyle(
            color: Colors.white.withValues(alpha: .75),
          ),
        ),
        const SizedBox(height: 2),
        AppText(
          value,
          variant: AppTextVariant.titleMedium,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.h5.toTextStyle(
            color: valueColor ?? Colors.white,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
