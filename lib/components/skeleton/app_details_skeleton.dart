import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/resources/app_spacing.dart';

class AppDetailsSkeleton extends StatelessWidget {
  const AppDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.p20),
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 24, child: Text('AA')),
                  SizedBox(width: AppSpacing.p12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Loading details title here'),
                        SizedBox(height: AppSpacing.p8),
                        Text('Loading details subtitle here'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.p12),
          Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.p20),
              child: Text(
                'Loading long description loading long description '
                'loading long description loading long description.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
