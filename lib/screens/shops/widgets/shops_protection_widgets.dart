import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../components/app_card.dart';
import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class StoreHero extends StatelessWidget {
  const StoreHero({
    super.key,
    required this.storeName,
    required this.category,
    required this.protectionLabel,
    required this.protectionValue,
    required this.deliveryLabel,
    required this.deliveryValue,
    required this.returnLabel,
    required this.returnValue,
    required this.onBack,
  });

  final String storeName;
  final String category;
  final String protectionLabel;
  final String protectionValue;
  final String deliveryLabel;
  final String deliveryValue;
  final String returnLabel;
  final String returnValue;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final safeTop = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 380,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(AppImages.shopsHero, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  colors.primary.shade700.withValues(alpha: .68),
                  colors.primary.shade700.withValues(alpha: .82),
                  colors.primary.shade700.withValues(alpha: .98),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: safeTop + AppSpacing.tokenL,
            start: AppSpacing.token2Xl,
            child: _HeroBackButton(onPressed: onBack, isRtl: isRtl),
          ),
          PositionedDirectional(
            top: safeTop + 90,
            start: AppSpacing.token2Xl,
            end: AppSpacing.token2Xl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const _DiamondRow(),
                const SizedBox(height: AppSpacing.tokenM),
                AppText(
                  storeName,
                  variant: AppTextVariant.headlineLarge,
                  textAlign: TextAlign.start,
                  style: AppTypography.buyerMobile.h1.toTextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  category,
                  variant: AppTextVariant.bodyLarge,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodyLarge.toTextStyle(
                    color: const Color(0xFFE4DFF7),
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            start: AppSpacing.token2Xl,
            end: AppSpacing.token2Xl,
            bottom: AppSpacing.token4Xl,
            child: _StoreSummary(
              protectionLabel: protectionLabel,
              protectionValue: protectionValue,
              deliveryLabel: deliveryLabel,
              deliveryValue: deliveryValue,
              returnLabel: returnLabel,
              returnValue: returnValue,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBackButton extends StatelessWidget {
  const _HeroBackButton({required this.onPressed, required this.isRtl});

  final VoidCallback onPressed;
  final bool isRtl;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white.withValues(alpha: .14),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: const SizedBox(
            width: 42,
            height: 42,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      );
}

class _DiamondRow extends StatelessWidget {
  const _DiamondRow();

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(9, (index) {
        final color =
            index.isEven ? colors.accent01.shade300 : const Color(0xFFC9C3E0);
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 3),
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(width: 9, height: 9, color: color),
          ),
        );
      }),
    );
  }
}

class _StoreSummary extends StatelessWidget {
  const _StoreSummary({
    required this.protectionLabel,
    required this.protectionValue,
    required this.deliveryLabel,
    required this.deliveryValue,
    required this.returnLabel,
    required this.returnValue,
  });

  final String protectionLabel;
  final String protectionValue;
  final String deliveryLabel;
  final String deliveryValue;
  final String returnLabel;
  final String returnValue;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.tokenM,
        vertical: AppSpacing.tokenL,
      ),
      decoration: BoxDecoration(
        color: colors.primary.shade600,
        borderRadius: BorderRadius.circular(AppRadius.token3Xl),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _SummaryMetric(
              label: protectionLabel,
              value: protectionValue,
              valueColor: colors.success.shade400,
            ),
          ),
          const _SummaryDivider(),
          Expanded(
            child: _SummaryMetric(
              label: deliveryLabel,
              value: deliveryValue,
            ),
          ),
          const _SummaryDivider(),
          Expanded(
            child: _SummaryMetric(
              label: returnLabel,
              value: returnValue,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppText(
            label,
            variant: AppTextVariant.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.bodySmall.toTextStyle(
              color: const Color(0xFFDAD5F2),
            ),
          ),
          const SizedBox(height: AppSpacing.token2Xs),
          AppText(
            value,
            variant: AppTextVariant.titleMedium,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.h6.toTextStyle(
              color: valueColor ?? Colors.white,
            ),
          ),
        ],
      );
}

class _SummaryDivider extends StatelessWidget {
  const _SummaryDivider();

  @override
  Widget build(BuildContext context) => Container(
        height: 42,
        width: 1,
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenXs),
        color: Colors.white.withValues(alpha: .18),
      );
}

class ProtectionOptionCard extends StatelessWidget {
  const ProtectionOptionCard({
    super.key,
    required this.selected,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final accent = colors.primary.shade500;

    return AppCard(
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 82),
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.tokenL,
          AppSpacing.tokenM,
          AppSpacing.tokenL,
          AppSpacing.tokenM,
        ),
        decoration: BoxDecoration(
          color: selected ? colors.primary.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.token2Xl),
          border: Border.all(
            color: selected ? accent : colors.neutral.shade200,
            width: selected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: selected ? accent : colors.neutral.shade100,
                borderRadius: BorderRadius.circular(AppRadius.tokenL),
              ),
              child: Icon(
                icon,
                color: selected ? Colors.white : colors.neutral.shade700,
                size: 25,
              ),
            ),
            const SizedBox(width: AppSpacing.tokenM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppText(
                    title,
                    variant: AppTextVariant.titleMedium,
                    textAlign: TextAlign.start,
                    style: AppTypography.buyerMobile.h6.toTextStyle(
                      color: colors.neutral.shade900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.token2Xs),
                  AppText(
                    description,
                    variant: AppTextVariant.bodySmall,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                      color: colors.neutral.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.tokenM),
            _SelectionIndicator(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.primitives.primary.shade500;
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? accent : AppColors.primitives.neutral.shade300,
          width: selected ? 7 : 2,
        ),
        color: selected ? Colors.white : Colors.transparent,
      ),
    );
  }
}

class ProtectionDisclaimer extends StatelessWidget {
  const ProtectionDisclaimer({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return AppCard(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.tokenL,
        AppSpacing.tokenM,
        AppSpacing.tokenL,
        AppSpacing.tokenM,
      ),
      color: colors.neutral.shade100,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.verified_user_outlined,
            color: colors.neutral.shade600,
            size: 22,
          ),
          const SizedBox(width: AppSpacing.tokenS),
          Expanded(
            child: AppText(
              message,
              variant: AppTextVariant.bodySmall,
              textAlign: TextAlign.start,
              style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                color: colors.neutral.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
