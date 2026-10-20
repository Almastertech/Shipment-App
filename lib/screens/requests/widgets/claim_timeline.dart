import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class ClaimTimelineEntry {
  const ClaimTimelineEntry(this.title, this.subtitle);
  final String title;
  final String subtitle;
}

class ClaimTimeline extends StatelessWidget {
  const ClaimTimeline({super.key, required this.entries});
  final List<ClaimTimelineEntry> entries;
  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary.shade500;
    return Column(
        children: List<Widget>.generate(entries.length, (index) {
      final entry = entries[index];
      return SizedBox(
        height: 52,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 34,
                child: Stack(alignment: Alignment.topCenter, children: <Widget>[
                  if (index < entries.length - 1)
                    Positioned(
                        top: 16,
                        bottom: 0,
                        child: Container(width: 2, color: primary)),
                  Container(
                      width: 32,
                      height: 32,
                      decoration:
                          BoxDecoration(color: primary, shape: BoxShape.circle),
                      child: const Icon(Icons.check_rounded,
                          color: Colors.white, size: 20)),
                ]),
              ),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    AppText(entry.title,
                        variant: AppTextVariant.titleSmall,
                        textAlign: TextAlign.start,
                        style: AppTypography.buyerMobile.label.toTextStyle(
                            color: AppColors.primitives.neutral.shade900)),
                    AppText(entry.subtitle,
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.start,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                            color: AppColors.primitives.neutral.shade600)),
                  ])),
            ]),
      );
    }));
  }
}
