import 'package:flutter/material.dart';

import '../../core/resources/adaptive_layout.dart';

class AdaptiveTwoPane extends StatelessWidget {
  const AdaptiveTwoPane({
    super.key,
    required this.firstPane,
    required this.secondPane,
    this.firstFlex = 5,
    this.secondFlex = 7,
    this.spacing,
    this.expandPanes = true,
    this.reverseOnCompact = false,
    this.useTwoPaneWhen,
  });

  final Widget firstPane;
  final Widget secondPane;
  final int firstFlex;
  final int secondFlex;
  final double? spacing;
  final bool expandPanes;
  final bool reverseOnCompact;
  final bool Function(AdaptiveLayoutData adaptive)? useTwoPaneWhen;

  @override
  Widget build(BuildContext context) {
    final adaptive = context.adaptiveLayout;
    final paneSpacing = spacing ?? adaptive.paneSpacing;
    final canUseTwoPane =
        useTwoPaneWhen?.call(adaptive) ?? adaptive.prefersTwoPane;

    if (!canUseTwoPane) {
      final orderedPanes = reverseOnCompact
          ? <Widget>[secondPane, firstPane]
          : <Widget>[firstPane, secondPane];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          orderedPanes[0],
          SizedBox(height: paneSpacing),
          orderedPanes[1],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Pane(
          flex: firstFlex,
          expanded: expandPanes,
          child: firstPane,
        ),
        SizedBox(width: paneSpacing),
        _Pane(
          flex: secondFlex,
          expanded: expandPanes,
          child: secondPane,
        ),
      ],
    );
  }
}

class _Pane extends StatelessWidget {
  const _Pane({
    required this.flex,
    required this.expanded,
    required this.child,
  });

  final int flex;
  final bool expanded;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Expanded(flex: flex, child: child);
    }
    return Flexible(flex: flex, child: child);
  }
}
