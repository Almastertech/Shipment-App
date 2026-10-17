import 'package:flutter/material.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';

class OnboardingProgress extends StatelessWidget {
  const OnboardingProgress({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primitives.primary.shade500;
    final inactiveColor = AppColors.primitives.neutral.shade300;

    return Row(
      textDirection: Directionality.of(context),
      children: List<Widget>.generate(pageCount, (index) {
        return Expanded(
          child: Container(
            height: AppSpacing.tokenXs,
            margin: EdgeInsetsDirectional.only(
              end: index == pageCount - 1 ? 0 : AppSpacing.tokenXs,
            ),
            decoration: BoxDecoration(
              color: index <= currentPage ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(AppRadius.tokenFull),
            ),
          ),
        );
      }),
    );
  }
}
