import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class ShipmentFilters extends StatelessWidget {
  const ShipmentFilters({
    super.key,
    required this.activeLabel,
    required this.deliveredLabel,
    required this.selectedIndex,
    required this.onSelect,
  });

  final String activeLabel;
  final String deliveredLabel;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;

    return Container(
      height: 52,
      padding: const EdgeInsets.all(AppSpacing.tokenXs),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .18),
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Row(
        children: <Widget>[
          _filter(activeLabel, 0, primary),
          _filter(deliveredLabel, 1, primary),
        ],
      ),
    );
  }

  Widget _filter(String label, int index, AppColorRamp primary) {
    final selected = index == selectedIndex;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onSelect(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.tokenFull),
          ),
          child: AppText(
            label,
            variant: AppTextVariant.titleSmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.label.toTextStyle(
              color: selected ? primary.shade900 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
