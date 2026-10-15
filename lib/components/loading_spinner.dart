import 'package:flutter/material.dart';

import '../core/resources/app_icon_size.dart';
import '../core/resources/app_spacing.dart';
import 'app_text.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    super.key,
    this.label,
    this.maxContentWidth = 360,
  });

  final String? label;
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.p24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: AppIconSize.iconL,
                  height: AppIconSize.iconL,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(colorScheme.primary),
                  ),
                ),
                if (label != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.p12),
                  AppText(
                    label!,
                    variant: AppTextVariant.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
