import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shipments/core/resources/app_colors.dart';

class ShipmentDotsMark extends StatelessWidget {
  const ShipmentDotsMark({super.key});

  @override
  Widget build(BuildContext context) {
    final neutral = AppColors.primitives.neutral;
    final accent = AppColors.primitives.accent01;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(9, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.5),
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: 8,
              height: 8,
              color: index % 2 == 0
                  ? accent.shade300
                  : neutral.shade100.withValues(alpha: .45),
            ),
          ),
        );
      }),
    );
  }
}
