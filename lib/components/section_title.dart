import 'package:flutter/material.dart';

import '../core/resources/app_spacing.dart';
import 'app_text.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppText(
                title,
                variant: AppTextVariant.titleLarge,
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: AppSpacing.xs),
                AppText(
                  subtitle!,
                  variant: AppTextVariant.bodyMedium,
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...<Widget>[
          const SizedBox(width: AppSpacing.md),
          trailing!,
        ],
      ],
    );
  }
}
