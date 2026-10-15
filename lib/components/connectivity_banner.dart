import 'dart:async';
import 'package:flutter/material.dart';
import '../core/network_info.dart';
import '../injection.dart';
import '../l10n/app_localizations.dart';

/// A global connectivity banner that shows "You are offline" when disconnected.
///
/// Mount this in [MaterialApp.builder] or wrap it around your root widget via
/// [Stack] so all screens benefit.
class ConnectivityBanner extends StatefulWidget {
  const ConnectivityBanner({required this.child, super.key});

  final Widget child;

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner>
    with SingleTickerProviderStateMixin {
  late final StreamSubscription<bool> _subscription;
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    final networkInfo = getIt<NetworkInfo>();
    _subscription =
        networkInfo.connectivityStream.listen(_onConnectivityChanged);
    networkInfo.isConnected.then(_onConnectivityChanged);
  }

  void _onConnectivityChanged(bool isOnline) {
    if (!mounted) return;
    setState(() {
      _isOnline = isOnline;
    });
    if (isOnline) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: <Widget>[
        widget.child,
        if (!_isOnline)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _slideAnimation,
              child: Material(
                elevation: 4,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 4,
                    bottom: 8,
                    left: 16,
                    right: 16,
                  ),
                  color: colorScheme.error,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.wifi_off_rounded,
                        color: colorScheme.onError,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n?.offlineBanner ?? 'You are offline',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onError,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
