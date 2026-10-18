import 'package:flutter/material.dart';
import 'package:shipments/components/app_card.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';

class LocationIllustration extends StatelessWidget {
  const LocationIllustration({
    super.key,
    required this.shadowProgress,
  });

  final Animation<double> shadowProgress;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return AppCard(
      padding: EdgeInsets.zero,
      child: AspectRatio(
        aspectRatio: 400 / 230,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                AppImages.riyadhCity,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) => ColoredBox(
                  color: colors.primary.shade700,
                ),
              ),
            ),
            Positioned.fill(
              child: ColoredBox(
                color: colors.primary.shade900.withValues(alpha: .38),
              ),
            ),
            for (final diameter in <double>[176, 136, 100])
              SizedBox.square(
                dimension: diameter,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .18),
                      width: 1,
                    ),
                  ),
                ),
              ),
            AnimatedBuilder(
              animation: shadowProgress,
              builder: (context, child) {
                final progress = shadowProgress.value;
                final markerColor = colors.accent01.shade300;
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: markerColor,
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: markerColor.withValues(
                          alpha: 0.2 + (0.16 * progress),
                        ),
                        blurRadius: 16 + (14 * progress),
                        spreadRadius: 2 + (5 * progress),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 34,
                    color: colors.neutral.shade900,
                  ),
                );
              },
            ),
            PositionedDirectional(
              end: AppSpacing.tokenM,
              bottom: AppSpacing.tokenS,
              child: Icon(
                Icons.my_location_rounded,
                color: Colors.white.withValues(alpha: .72),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
