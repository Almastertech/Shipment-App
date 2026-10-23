import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../../../l10n/app_localizations.dart';
import '../application/in_app_notification_center.dart';

class NotificationBellButton extends StatefulWidget {
  const NotificationBellButton({super.key});

  @override
  State<NotificationBellButton> createState() => _NotificationBellButtonState();
}

class _NotificationBellButtonState extends State<NotificationBellButton> {
  bool _isOpening = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<InAppNotificationCenter>(
      builder: (context, center, _) {
        return IconButton(
          tooltip: l10n.notificationsTitle,
          onPressed: _isOpening ? null : () => _openNotifications(),
          icon: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              const Icon(Icons.notifications_none_rounded),
              if (center.unreadCount > 0)
                PositionedDirectional(
                  end: -2,
                  top: -2,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      center.unreadCount > 99 ? '99+' : '${center.unreadCount}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onError,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openNotifications() async {
    if (!mounted || _isOpening) return;
    _isOpening = true;
    try {
      await context.push<void>(AppRoutes.notificationsCenter);
    } finally {
      if (mounted) _isOpening = false;
    }
  }
}
