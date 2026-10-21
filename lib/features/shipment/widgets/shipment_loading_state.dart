import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Applies a consistent loading presentation to a complete shipment screen.
class ShipmentLoadingState extends StatelessWidget {
  const ShipmentLoadingState({
    super.key,
    required this.isLoading,
    required this.loadingLabel,
    required this.child,
  });

  final bool isLoading;
  final String loadingLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Semantics(
        liveRegion: isLoading,
        label: isLoading ? loadingLabel : null,
        child: ExcludeSemantics(
          excluding: isLoading,
          child: IgnorePointer(
            key: const Key('shipment-loading-interaction-blocker'),
            ignoring: isLoading,
            child: child,
          ),
        ),
      ),
    );
  }
}
