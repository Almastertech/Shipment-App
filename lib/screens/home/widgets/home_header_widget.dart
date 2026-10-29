import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../components/app_text.dart';
import '../../../components/images/app_network_image.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../data/model/customer_home.dart';
import '../../../features/notifications/presentation/notification_bell_button.dart';
import '../../../l10n/app_localizations.dart';

/// Home hero with the latest shipment returned by the home endpoint.
class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    this.customerName,
    this.avatarUrl,
    this.heroState,
    this.featuredShipment,
    this.onShipmentTap,
  });

  final String? customerName;
  final String? avatarUrl;
  final String? heroState;
  final CustomerHomeShipment? featuredShipment;
  final VoidCallback? onShipmentTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final cardTop = width * .84;
    final cardHeight = math.max(220.0, width * .58).toDouble();

    return SizedBox(
      height: cardTop + cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            height: width * 1.07,
            child: _HomeImageHeader(
              greeting: l10n.homeHeroGreeting,
              name: customerName ?? '',
              avatarUrl: avatarUrl,
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
              shipment: featuredShipment,
              heroState: heroState,
              onTap: onShipmentTap,
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
    this.avatarUrl,
  });

  final String greeting;
  final String name;
  final String title;
  final String description;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final topInset = MediaQuery.paddingOf(context).top;
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(AppImages.splash, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  primary.shade900.withValues(alpha: .45),
                  primary.shade800.withValues(alpha: .30),
                  primary.shade900.withValues(alpha: .98),
                ],
                stops: const <double>[0, .55, 1],
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
                      clipBehavior: Clip.antiAlias,
                      child: avatarUrl != null && avatarUrl!.isNotEmpty
                          ? AppNetworkImage(
                              imageUrl: avatarUrl!,
                              width: 44,
                              height: 44,
                              error: (_) => const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                            )
                          : SvgPicture.asset(
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
                    const SizedBox(
                      width: 48,
                      height: 48,
                      child: IconTheme(
                        data: IconThemeData(color: Colors.white, size: 22),
                        child: NotificationBellButton(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.token6Xl),
                SizedBox(
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
                        style: AppTypography.buyerMobile.h1
                            .toTextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: AppSpacing.tokenXs),
                      AppText(
                        description,
                        variant: AppTextVariant.bodyMedium,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                          color: Colors.white.withValues(alpha: .92),
                        ),
                      ),
                    ],
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
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(10, (index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.token2Xs),
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                width: 7,
                height: 7,
                color: index.isEven
                    ? AppColors.primitives.accent01.shade300
                    : Colors.white.withValues(alpha: .7),
              ),
            ),
          );
        }),
      );
}

class _FeaturedShipmentCard extends StatelessWidget {
  const _FeaturedShipmentCard({
    required this.shipment,
    required this.heroState,
    required this.onTap,
  });

  final CustomerHomeShipment? shipment;
  final String? heroState;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const colors = AppColors.primitives;
    final status = _displayStatus(shipment?.status ?? heroState);
    final expected = shipment?.expectedDeliveryAt;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final shipmentDetails = <String>[
      if (shipment?.storeName != null) shipment!.storeName!,
      if (shipment?.orderNumber != null)
        '${l10n.homeOrderNumber} ${shipment!.orderNumber}',
    ].join(' · ');
    final delivery = expected == null
        ? l10n.homeNoDeliveryEstimate
        : DateFormat.yMMMd(locale).format(expected.toLocal());

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
        child: Material(
          color: colors.primary.shade700,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.tokenM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.inventory_2_outlined,
                        color: colors.accent01.shade300,
                      ),
                      const SizedBox(width: AppSpacing.tokenS),
                      Expanded(
                        child: Text(
                          shipment?.productName ??
                              (shipment == null
                                  ? l10n.homeNoFeaturedShipment
                                  : l10n.homeFeaturedShipment),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.label
                              .toTextStyle(color: Colors.white),
                        ),
                      ),
                      if (onTap != null)
                        Icon(
                          Icons.chevron_right_rounded,
                          color: colors.accent01.shade300,
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenXs),
                  Text(
                    shipmentDetails.isEmpty
                        ? l10n.homeNoShipmentDetails
                        : shipmentDetails,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.buyerMobile.caption
                        .toTextStyle(color: colors.primary.shade100),
                  ),
                  const Spacer(),
                  Text(
                    status ?? l10n.homeNoShipmentStatus,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.buyerMobile.h6
                        .toTextStyle(color: colors.accent01.shade300),
                  ),
                  const SizedBox(height: AppSpacing.tokenXs),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.schedule_outlined,
                        size: 16,
                        color: colors.primary.shade100,
                      ),
                      const SizedBox(width: AppSpacing.tokenXs),
                      Expanded(
                        child: Text(
                          '${l10n.homeExpectedDelivery}: $delivery',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.caption
                              .toTextStyle(color: colors.primary.shade100),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String? _displayStatus(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  return raw
      .trim()
      .replaceAll(RegExp(r'[_-]+'), ' ')
      .split(' ')
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
}
