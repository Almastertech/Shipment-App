import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/layout/bottom_sheet_service.dart';
import '../../../l10n/app_localizations.dart';
import '../application/in_app_notification_center.dart';
import 'notification_center_sheet.dart';

class NotificationBellButton extends StatelessWidget {
  const NotificationBellButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<InAppNotificationCenter>(
      builder: (context, center, _) {
        return IconButton(
          tooltip: l10n.notificationsTitle,
          onPressed: () {
            context.read<AppBottomSheetService>().showCustom<void>(
                  isScrollControlled: true,
                  builder: (_) =>
                      ChangeNotifierProvider<InAppNotificationCenter>.value(
                    value: center,
                    child: const NotificationCenterSheet(),
                  ),
                );
          },
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
}
