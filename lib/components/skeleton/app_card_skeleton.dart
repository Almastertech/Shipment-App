import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../core/resources/app_spacing.dart';

class AppCardSkeleton extends StatelessWidget {
  const AppCardSkeleton({
    super.key,
    this.showAvatar = true,
  });

  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Card(
        child: ListTile(
          minTileHeight: 76,
          leading: showAvatar
              ? const CircleAvatar(
                  radius: 20,
                  child: Text('AA'),
                )
              : null,
          title: const Text('Loading title for skeleton item'),
          subtitle: const Padding(
            padding: EdgeInsets.only(top: AppSpacing.p4),
            child: Text('Loading subtitle line for skeleton state'),
          ),
        ),
      ),
    );
  }
}
