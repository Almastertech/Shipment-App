import 'package:flutter/material.dart';

class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
    required this.page,
  });

  final Widget icon;
  final Widget? selectedIcon;
  final String label;
  final Widget page;
}

class AppBottomNavTemplate extends StatefulWidget {
  const AppBottomNavTemplate({
    super.key,
    required this.items,
    this.initialIndex = 0,
    this.appBar,
    this.floatingActionButton,
    this.backgroundColor,
  });

  final List<BottomNavItem> items;
  final int initialIndex;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;

  @override
  State<AppBottomNavTemplate> createState() => _AppBottomNavTemplateState();
}

class _AppBottomNavTemplateState extends State<AppBottomNavTemplate> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.items.length >= 2,
      'AppBottomNavTemplate needs at least 2 items.',
    );

    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      floatingActionButton: widget.floatingActionButton,
      body: IndexedStack(
        index: _currentIndex,
        children: widget.items.map((item) => item.page).toList(growable: false),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: widget.items
            .map(
              (item) => NavigationDestination(
                icon: item.icon,
                selectedIcon: item.selectedIcon,
                label: item.label,
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}
