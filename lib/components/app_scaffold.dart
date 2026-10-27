import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../core/resources/app_spacing.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.padding,
    this.safeArea = true,
    this.safeAreaBottom = true,
    this.dismissKeyboardOnTap = true,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.drawer,
    this.endDrawer,
    this.scrollable = false,
    this.isLoading = false,
    this.loadingLabel,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final bool safeArea;
  final bool safeAreaBottom;
  final bool dismissKeyboardOnTap;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool scrollable;
  final bool isLoading;
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    Widget content = body;

    if (scrollable) {
      content = SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: content,
      );
    }

    content = Padding(
      padding: padding ?? AppSpacing.screen,
      child: content,
    );

    if (safeArea) {
      content = SafeArea(bottom: safeAreaBottom, child: content);
    }

    if (dismissKeyboardOnTap) {
      content = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: content,
      );
    }

    return Skeletonizer(
      enabled: isLoading,
      child: Semantics(
        liveRegion: isLoading,
        label: isLoading ? loadingLabel ?? 'Loading' : null,
        child: ExcludeSemantics(
          excluding: isLoading,
          child: IgnorePointer(
            key: const Key('app-scaffold-loading-interaction-blocker'),
            ignoring: isLoading,
            child: Scaffold(
              appBar: appBar,
              body: content,
              backgroundColor: backgroundColor,
              bottomNavigationBar: bottomNavigationBar,
              floatingActionButton: floatingActionButton,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              extendBody: extendBody,
              drawer: drawer,
              endDrawer: endDrawer,
            ),
          ),
        ),
      ),
    );
  }
}
