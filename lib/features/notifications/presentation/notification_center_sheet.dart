import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../application/in_app_notification_center.dart';
import '../domain/in_app_notification.dart';

class NotificationCenterSheet extends StatelessWidget {
  const NotificationCenterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<InAppNotificationCenter>(
          builder: (context, center, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      l10n.notificationsTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: center.unreadCount == 0
                          ? null
                          : () => center.markAllRead(),
                      child: Text(l10n.notificationsMarkAllRead),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (center.items.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: Text(
                      l10n.notificationsEmpty,
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: center.items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = center.items[index];
                        return _NotificationTile(item: item);
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item});

  final InAppNotification item;

  @override
  Widget build(BuildContext context) {
    final center = context.read<InAppNotificationCenter>();

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: _NotificationTypeIcon(type: item.type),
      title: Text(
        item.title,
        style: item.isRead
            ? Theme.of(context).textTheme.titleSmall
            : Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(item.message),
      ),
      trailing: item.isRead
          ? null
          : Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
      onTap: () => center.markRead(item.id),
    );
  }
}

class _NotificationTypeIcon extends StatelessWidget {
  const _NotificationTypeIcon({required this.type});

  final InAppNotificationType type;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CircleAvatar(
      radius: 16,
      backgroundColor: switch (type) {
        InAppNotificationType.info => colorScheme.secondaryContainer,
        InAppNotificationType.success => colorScheme.primaryContainer,
        InAppNotificationType.warning => colorScheme.tertiaryContainer,
        InAppNotificationType.error => colorScheme.errorContainer,
      },
      child: Icon(
        switch (type) {
          InAppNotificationType.info => Icons.info_outline_rounded,
          InAppNotificationType.success => Icons.check_circle_outline_rounded,
          InAppNotificationType.warning => Icons.warning_amber_rounded,
          InAppNotificationType.error => Icons.error_outline_rounded,
        },
        size: 17,
      ),
    );
  }
}
