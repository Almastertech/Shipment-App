import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_text.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../features/notifications/presentation/notification_bell_button.dart';
import '../../../l10n/app_localizations.dart';

/// Full-width image header with the overlapping featured shipment card.
class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final headerHeight = width * 1.07;
    final cardTop = width * .84;
    final cardHeight = math.max(280.0, width * .68).toDouble();

    return SizedBox(
      height: cardTop + cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            height: headerHeight,
            child: _HomeImageHeader(
              greeting: l10n.homeHeroGreeting,
              name: l10n.homeUserName,
              title: l10n.homeTitle,
              description: l10n.homeHeroDescription,
            ),
          ),
          PositionedDirectional(
            top: cardTop,
            start: AppSpacing.tokenXl,
            end: AppSpacing.tokenXl,
            height: cardHeight,
            child: _FeaturedShipmentCard(
              productTitle: l10n.homeShipmentProduct,
              merchant: l10n.homeShipmentMerchant,
              price: l10n.homeShipmentPrice,
              protectionLabel: l10n.homeShipmentProtection,
              statusHeadline: l10n.homeShipmentStatusHeadline,
              steps: <String>[
                l10n.homeShipmentStepOrdered,
                l10n.homeShipmentStepInTransit,
                l10n.homeShipmentStepDelivered,
              ],
              activeStepIndex: 1,
              arrivalDate: l10n.homeHeroShipmentDelivery,
              actionLabel: l10n.homeHeroShipmentAction,
              onAction: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeImageHeader extends StatelessWidget {
  const _HomeImageHeader({
    required this.greeting,
    required this.name,
    required this.title,
    required this.description,
  });

  final String greeting;
  final String name;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final topInset = MediaQuery.paddingOf(context).top;

    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            AppImages.splash,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: primary.shade900.withValues(alpha: .26),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  primary.shade900.withValues(alpha: .32),
                  primary.shade900.withValues(alpha: .06),
                  primary.shade800.withValues(alpha: .30),
                  primary.shade900.withValues(alpha: .98),
                ],
                stops: const <double>[0, .35, .72, 1],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenXl,
              topInset + AppSpacing.tokenS,
              AppSpacing.tokenXl,
              AppSpacing.token2Xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .18),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .45),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppImages.user,
                        width: 22,
                        height: 22,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.tokenS),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppText(
                            greeting,
                            variant: AppTextVariant.labelSmall,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.buyerMobile.caption
                                .toTextStyle(color: Colors.white),
                          ),
                          AppText(
                            name,
                            variant: AppTextVariant.titleSmall,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.buyerMobile.label
                                .toTextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.tokenS),
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .16),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: .45),
                            ),
                          ),
                          child: const IconTheme(
                            data: IconThemeData(color: Colors.white, size: 22),
                            child: NotificationBellButton(),
                          ),
                        ),
                        PositionedDirectional(
                          end: 7,
                          top: 5,
                          child: Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: AppColors.primitives.accent01.shade300,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.token6Xl),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * .58,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const _HomeBrandPattern(),
                        const SizedBox(height: AppSpacing.tokenL),
                        AppText(
                          title,
                          variant: AppTextVariant.headlineMedium,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.h1.toTextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.tokenXs),
                        AppText(
                          description,
                          variant: AppTextVariant.bodyMedium,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTypography.buyerMobile.bodySmall.toTextStyle(
                            color: Colors.white.withValues(alpha: .92),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeBrandPattern extends StatelessWidget {
  const _HomeBrandPattern();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List<Widget>.generate(10, (index) {
        final isAccent = index.isEven;
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: AppSpacing.token2Xs),
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: 7,
              height: 7,
              color: isAccent
                  ? AppColors.primitives.accent01.shade300
                  : Colors.white.withValues(alpha: .7),
            ),
          ),
        );
      }),
    );
  }
}

class _FeaturedShipmentCard extends StatelessWidget {
  const _FeaturedShipmentCard({
    required this.productTitle,
    required this.merchant,
    required this.price,
    required this.protectionLabel,
    required this.statusHeadline,
    required this.steps,
    required this.activeStepIndex,
    required this.arrivalDate,
    required this.actionLabel,
    required this.onAction,
  });

  final String productTitle;
  final String merchant;
  final String price;
  final String protectionLabel;
  final String statusHeadline;
  final List<String> steps;
  final int activeStepIndex;
  final String arrivalDate;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .18),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: <Color>[colors.primary.shade600, colors.primary.shade700],
            ),
          ),
          child: Stack(
            children: <Widget>[
              PositionedDirectional(
                end: -46,
                top: -40,
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    color: colors.primary.shade500.withValues(alpha: .55),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.tokenM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: _ProtectionPill(label: protectionLabel),
                              ),
                              const SizedBox(height: AppSpacing.tokenS),
                              AppText(
                                productTitle,
                                variant: AppTextVariant.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    AppTypography.buyerMobile.label.toTextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              AppText(
                                '$merchant · $price',
                                variant: AppTextVariant.bodySmall,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.buyerMobile.caption
                                    .toTextStyle(
                                  color: colors.primary.shade200,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.tokenS),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadius.tokenXl),
                          child: Image.asset(
                            AppImages.shipmentBackground,
                            width: 82,
                            height: 82,
                            fit: BoxFit.cover,
                            alignment: const Alignment(-.4, 0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 19,
                          color: colors.accent01.shade300,
                        ),
                        const SizedBox(width: AppSpacing.tokenXs),
                        Expanded(
                          child: AppText(
                            statusHeadline,
                            variant: AppTextVariant.titleMedium,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.buyerMobile.h6.toTextStyle(
                              color: colors.accent01.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.tokenM),
                    _FeaturedShipmentProgress(
                      steps: steps,
                      activeStepIndex: activeStepIndex,
                    ),
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: _ArrivalPill(date: arrivalDate),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.tokenS),
                        PrimaryButton(
                          label: actionLabel,
                          onPressed: onAction,
                          fullWidth: false,
                          iconOnTrailing: true,
                          icon: Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: colors.neutral.shade900,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.accent01.shade300,
                            foregroundColor: colors.neutral.shade900,
                            minimumSize: const Size(0, 40),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.tokenM,
                            ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: 0,
                            shape: const StadiumBorder(),
                            textStyle: AppTypography.buyerMobile.button
                                .toTextStyle(color: colors.neutral.shade900),
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

class _ProtectionPill extends StatelessWidget {
  const _ProtectionPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.accent01.shade300,
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenS,
          vertical: AppSpacing.token2Xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: AppText(
                label,
                variant: AppTextVariant.labelSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: colors.neutral.shade900,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.token2Xs),
            SvgPicture.asset(
              AppImages.shieldCheck,
              width: 15,
              height: 15,
              colorFilter: ColorFilter.mode(
                colors.neutral.shade900,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedShipmentProgress extends StatelessWidget {
  const _FeaturedShipmentProgress({
    required this.steps,
    required this.activeStepIndex,
  });

  final List<String> steps;
  final int activeStepIndex;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final activeColor = colors.accent01.shade300;
    final inactiveColor = colors.primary.shade400.withValues(alpha: .45);

    return Row(
      children: <Widget>[
        for (var index = 0; index < steps.length; index++)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 18,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: index == 0
                                ? const SizedBox.shrink()
                                : Container(
                                    height: 3.5,
                                    color: (index - 1) < activeStepIndex
                                        ? activeColor
                                        : inactiveColor,
                                  ),
                          ),
                          Expanded(
                            child: index == steps.length - 1
                                ? const SizedBox.shrink()
                                : Container(
                                    height: 3.5,
                                    color: index < activeStepIndex
                                        ? activeColor
                                        : inactiveColor,
                                  ),
                          ),
                        ],
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index <= activeStepIndex
                              ? activeColor
                              : inactiveColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  steps[index],
                  variant: AppTextVariant.labelSmall,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: index <= activeStepIndex
                        ? Colors.white
                        : colors.primary.shade200,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ArrivalPill extends StatelessWidget {
  const _ArrivalPill({required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenS,
          vertical: AppSpacing.tokenXs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              AppImages.timeQuarterTo,
              width: 15,
              height: 15,
              colorFilter: ColorFilter.mode(
                colors.neutral.shade100,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSpacing.tokenXs),
            Flexible(
              child: AppText(
                date,
                variant: AppTextVariant.labelSmall,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: colors.neutral.shade100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
