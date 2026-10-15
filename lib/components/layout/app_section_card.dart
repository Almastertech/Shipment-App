import 'package:flutter/material.dart';

import '../../core/resources/app_spacing.dart';
import '../app_card.dart';
import '../section_title.dart';

/// Reusable section pattern for feature, form, and settings screens.
///
/// Provides a consistent "title + optional subtitle + content card" structure.
class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.trailing,
    this.cardPadding = AppSpacing.card,
    this.headerSpacing = AppSpacing.sm,
    this.useCard = true,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;
  final EdgeInsets cardPadding;
  final double headerSpacing;
  final bool useCard;

  @override
  Widget build(BuildContext context) {
    final content = useCard
        ? AppCard(
            padding: cardPadding,
            child: child,
          )
        : child;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionTitle(
          title: title,
          subtitle: subtitle,
          trailing: trailing,
        ),
        SizedBox(height: headerSpacing),
        content,
      ],
    );
  }
}
