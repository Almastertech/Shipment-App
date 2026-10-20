import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class ClaimEvidenceStrip extends StatelessWidget {
  const ClaimEvidenceStrip({super.key, required this.labels});
  final List<String> labels;
  @override
  Widget build(BuildContext context) => Row(
        children: labels
            .map((label) => Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: AppSpacing.tokenS),
                    child: AspectRatio(
                      aspectRatio: .92,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.tokenL),
                        child: Stack(fit: StackFit.expand, children: <Widget>[
                          Image.asset(AppImages.boxFocus,
                              fit: BoxFit.cover, alignment: Alignment.center),
                          ColoredBox(
                              color: Colors.black.withValues(alpha: .12)),
                          if (label == labels[1])
                            const Center(
                                child: Icon(Icons.play_circle_fill_rounded,
                                    color: Colors.white, size: 32)),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  height: 28,
                                  color: Colors.black.withValues(alpha: .62),
                                  alignment: Alignment.center,
                                  child: AppText(label,
                                      variant: AppTextVariant.labelSmall,
                                      style: AppTypography.buyerMobile.caption
                                          .toTextStyle(color: Colors.white)))),
                        ]),
                      ),
                    ),
                  ),
                ))
            .toList(),
      );
}
