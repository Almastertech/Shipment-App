import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_radius.dart';

class LocationIllustration extends StatelessWidget {
  const LocationIllustration({
    super.key,
    required this.size,
    required this.shadowProgress,
    this.locationDisabled = false,
  });

  final double size;
  final Animation<double> shadowProgress;
  final bool locationDisabled;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          for (final factor in <double>[1, 0.74, 0.5, 0.32])
            SizedBox.square(
              dimension: size * factor,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colors.neutral.shade200.withValues(alpha: 0.5),
                    width: 0.7,
                  ),
                ),
              ),
            ),
          SvgPicture.asset(
            AppImages.wavesBackground,
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
          AnimatedBuilder(
            animation: shadowProgress,
            builder: (context, child) {
              final progress = shadowProgress.value;
              final markerColor = locationDisabled
                  ? colors.neutral.shade500
                  : colors.primary.shade500;
              return Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: markerColor,
                  borderRadius: BorderRadius.circular(AppRadius.token2Xl),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: markerColor.withValues(
                        alpha: 0.16 + (0.18 * progress),
                      ),
                      blurRadius: 18 + (22 * progress),
                      spreadRadius: 2 + (8 * progress),
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    locationDisabled ? AppImages.markerCross : AppImages.marker,
                    width: 36,
                    height: 36,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: size * 0.21,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: locationDisabled
                    ? colors.neutral.shade500
                    : colors.primary.shade500,
                borderRadius: BorderRadius.circular(AppRadius.tokenFull),
              ),
              child: const SizedBox.square(dimension: 8),
            ),
          ),
        ],
      ),
    );
  }
}
