import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Skeletonizes a demands flow screen and prevents interaction while loading.
class DemandLoadingState extends StatelessWidget {
  const DemandLoadingState({
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
            key: const Key('demand-loading-interaction-blocker'),
            ignoring: isLoading,
            child: child,
          ),
        ),
      ),
    );
  }
}
