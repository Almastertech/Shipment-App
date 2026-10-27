import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../l10n/app_localizations.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : assert(selectedIndex >= 0 && selectedIndex < 5);

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primary = AppColors.primitives.primary.shade500;
    const selectedBackground = Colors.white;
    final localizedDestinations = <_NavDestinationData>[
      _NavDestinationData(l10n.bottomNavHome, 'Logo.svg'),
      _NavDestinationData(l10n.bottomNavShipments, 'products.svg'),
      _NavDestinationData(l10n.bottomNavClaims, 'receipt.svg'),
      _NavDestinationData(l10n.bottomNavStores, 'shop.svg'),
      _NavDestinationData(l10n.bottomNavProfile, 'user.svg'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenS),
      child: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Use flex allocation instead of fractional fixed widths. This
              // keeps the segments inside the real constraint after padding,
              // device preview rounding, and RTL layout are applied.
              const selectedFlex = 68;
              const inactiveFlex = 33;
              // Keep indexes in logical start-to-end order. The ambient
              // Directionality places the leading segment on the correct
              // side for both Arabic and English.
              final logicalIndices =
                  List<int>.generate(localizedDestinations.length, (i) => i);
              final leadingIndices = logicalIndices.take(selectedIndex);
              final trailingIndices = logicalIndices.skip(selectedIndex + 1);

              Widget buildBlueSegment(Iterable<int> indices) {
                final segmentIndices = indices.toList(growable: false);
                if (segmentIndices.isEmpty) return const SizedBox.shrink();

                return Expanded(
                  flex: segmentIndices.length * inactiveFlex,
                  child: Container(
                    height: 68,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                    ),
                    child: Row(
                      children: segmentIndices.map((logicalIndex) {
                        final destination = localizedDestinations[logicalIndex];
                        return Expanded(
                          child: _InactiveNavDestination(
                            key: ValueKey<int>(logicalIndex),
                            label: destination.label,
                            iconAsset: destination.iconAsset,
                            iconColor: selectedBackground,
                            onTap: () => onDestinationSelected(logicalIndex),
                          ),
                        );
                      }).toList(growable: false),
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 68,
                child: Row(
                  children: <Widget>[
                    buildBlueSegment(leadingIndices),
                    Expanded(
                      flex: selectedFlex,
                      child: _SelectedNavDestination(
                        label: localizedDestinations[selectedIndex].label,
                        iconAsset:
                            localizedDestinations[selectedIndex].iconAsset,
                        primaryColor: primary,
                        backgroundColor: selectedBackground,
                        onTap: () => onDestinationSelected(selectedIndex),
                      ),
                    ),
                    buildBlueSegment(trailingIndices),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _InactiveNavDestination extends StatelessWidget {
  const _InactiveNavDestination({
    super.key,
    required this.label,
    required this.iconAsset,
    required this.iconColor,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: false,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 68,
          child: Center(
            child: _NavIcon(
              asset: iconAsset,
              color: iconColor,
              size: iconAsset == 'Logo.svg' ? 26 : 22,
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedNavDestination extends StatelessWidget {
  const _SelectedNavDestination({
    required this.label,
    required this.iconAsset,
    required this.primaryColor,
    required this.backgroundColor,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final Color primaryColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Semantics(
      button: true,
      selected: true,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 360),
          curve: Curves.easeInOutCubic,
          height: 68,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.tokenFull),
            border: Border.all(
              color: primaryColor,
              width: AppSpacing.token3Xs,
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
            child: Row(
              key: ValueKey<String>('selected-$label'),
              mainAxisAlignment: MainAxisAlignment.center,
              children: isRtl
                  ? <Widget>[
                      _NavIcon(
                        asset: iconAsset,
                        color: primaryColor,
                        size: iconAsset == 'Logo.svg' ? 26 : 22,
                      ),
                      const SizedBox(width: AppSpacing.tokenS),
                      Flexible(
                        child: AppText(
                          label,
                          variant: AppTextVariant.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.h6.toTextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ]
                  : <Widget>[
                      Flexible(
                        child: AppText(
                          label,
                          variant: AppTextVariant.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.h6.toTextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenS),
                      _NavIcon(
                        asset: iconAsset,
                        color: primaryColor,
                        size: iconAsset == 'Logo.svg' ? 26 : 22,
                      ),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.asset,
    required this.color,
    required this.size,
  });

  final String asset;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages.svg(asset),
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}

class _NavDestinationData {
  const _NavDestinationData(this.label, this.iconAsset);

  final String label;
  final String iconAsset;
}
