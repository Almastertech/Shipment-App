import 'dart:async';

import 'package:flutter/material.dart';

enum AppToastType {
  success,
  error,
  info,
  warning,
}

abstract class ToastService {
  void success(
    String message, {
    Duration duration = const Duration(seconds: 2),
  });

  void error(
    String message, {
    Duration duration = const Duration(seconds: 3),
  });

  void info(
    String message, {
    Duration duration = const Duration(seconds: 2),
  });

  void warning(
    String message, {
    Duration duration = const Duration(seconds: 3),
  });
}

class OverlayToastService implements ToastService {
  OverlayToastService({required GlobalKey<NavigatorState> navigatorKey})
      : _navigatorKey = navigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey;

  OverlayEntry? _activeEntry;

  @override
  void error(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      message,
      type: AppToastType.error,
      duration: duration,
    );
  }

  @override
  void info(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    _show(
      message,
      type: AppToastType.info,
      duration: duration,
    );
  }

  @override
  void success(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    _show(
      message,
      type: AppToastType.success,
      duration: duration,
    );
  }

  @override
  void warning(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      message,
      type: AppToastType.warning,
      duration: duration,
    );
  }

  void _show(
    String message, {
    required AppToastType type,
    required Duration duration,
  }) {
    final overlay = _navigatorKey.currentState?.overlay;
    final context = _navigatorKey.currentContext;
    if (overlay == null || context == null) {
      return;
    }

    _activeEntry?.remove();

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) {
        return _ToastOverlay(
          message: message,
          duration: duration,
          type: type,
          onDismissed: () {
            if (_activeEntry == entry) {
              _activeEntry = null;
            }
            entry.remove();
          },
        );
      },
    );

    _activeEntry = entry;
    overlay.insert(entry);
  }
}

class _ToastOverlay extends StatefulWidget {
  const _ToastOverlay({
    required this.message,
    required this.duration,
    required this.type,
    required this.onDismissed,
  });

  final String message;
  final Duration duration;
  final AppToastType type;
  final VoidCallback onDismissed;

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _run();
  }

  Future<void> _run() async {
    await _controller.forward();
    await Future<void>.delayed(widget.duration);
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _style(context, widget.type);

    return Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      right: 16,
      child: IgnorePointer(
        ignoring: true,
        child: SlideTransition(
          position: _slide,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: colors.$1,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 14,
                    color: Color(0x26000000),
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Icon(colors.$3, color: colors.$2, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colors.$2,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  (Color, Color, IconData) _style(BuildContext context, AppToastType type) {
    final colorScheme = Theme.of(context).colorScheme;

    return switch (type) {
      AppToastType.success => (
          colorScheme.primaryContainer,
          colorScheme.onPrimaryContainer,
          Icons.check_circle_outline_rounded,
        ),
      AppToastType.error => (
          colorScheme.errorContainer,
          colorScheme.onErrorContainer,
          Icons.error_outline_rounded,
        ),
      AppToastType.info => (
          colorScheme.secondaryContainer,
          colorScheme.onSecondaryContainer,
          Icons.info_outline_rounded,
        ),
      AppToastType.warning => (
          colorScheme.tertiaryContainer,
          colorScheme.onTertiaryContainer,
          Icons.warning_amber_rounded,
        ),
    };
  }
}
