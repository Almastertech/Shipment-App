import 'package:flutter/material.dart';

import '../../core/routing/bottom_nav_destinations.dart';
import 'custom_bottom_nav_bar.dart';

class AppShellBottomBar extends StatelessWidget {
  const AppShellBottomBar({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 84,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: CustomBottomNavBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                if (index == selectedIndex) return;
                BottomNavDestinations.go(context, index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
