import 'package:flutter/material.dart';

import '../../core/resources/app_spacing.dart';
import 'app_card_skeleton.dart';

class AppListSkeleton extends StatelessWidget {
  const AppListSkeleton({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.p10),
      itemBuilder: (_, __) => const AppCardSkeleton(),
    );
  }
}
