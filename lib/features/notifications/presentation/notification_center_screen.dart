import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/app_text.dart';
import '../../../components/buttons/text_link_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../core/routing/app_routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../../screens/profile/widgets/profile_subpage_hero.dart';
import '../application/in_app_notification_center.dart';
import '../domain/in_app_notification.dart';
import 'widgets/notification_filter_chip.dart';

enum _NotificationFilter { all, unread, shipments, claims }

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  static const Set<String> _demoReadIds = <String>{
    'demo_approved',
    'demo_review',
  };

  final Set<String> _locallyReadDemoIds = <String>{};
  _NotificationFilter _selectedFilter = _NotificationFilter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final heroHeight = width * .86 < 350 ? 350.0 : width * .86;

    return Consumer<InAppNotificationCenter>(
      builder: (context, center, _) {
        final isShowingDemo = center.items.isEmpty;
        final items =
            isShowingDemo ? _demoItems(l10n) : _liveItems(center.items);
        final unreadCount = items.where((item) => !item.isRead).length;
        final filtered = items.where(_matchesFilter).toList(growable: false);
        final today = DateTime.now();
        final todayItems = filtered
            .where((item) => _sameDate(item.createdAt, today))
            .toList(growable: false);
        final yesterdayDate = today.subtract(const Duration(days: 1));
        final yesterdayItems = filtered
            .where((item) => _sameDate(item.createdAt, yesterdayDate))
            .toList(growable: false);
        final olderItems = filtered
            .where(
              (item) =>
                  !_sameDate(item.createdAt, today) &&
                  !_sameDate(item.createdAt, yesterdayDate),
            )
            .toList(growable: false);

        return AppScaffold(
          padding: EdgeInsets.zero,
          safeArea: false,
          backgroundColor: AppColors.semantic.background.primary,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.tokenXl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: heroHeight,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: ProfileSubpageHero(
                          title: l10n.notificationsHeroTitle,
                          subtitle:
                              l10n.notificationsUnreadSubtitle(unreadCount),
                          backLabel: l10n.navigationBack,
                          onBack: () => _goBack(context),
                        ),
                      ),
                      PositionedDirectional(
                        start: AppSpacing.tokenL,
                        end: AppSpacing.tokenL,
                        bottom: AppSpacing.tokenM,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  _filterChip(
                                    _NotificationFilter.all,
                                    l10n.notificationsFilterAll,
                                  ),
                                  const SizedBox(width: AppSpacing.tokenS),
                                  _filterChip(
                                    _NotificationFilter.unread,
                                    l10n.notificationsFilterUnread(unreadCount),
                                  ),
                                  const SizedBox(width: AppSpacing.tokenS),
                                  _filterChip(
                                    _NotificationFilter.shipments,
                                    l10n.notificationsFilterShipments,
                                  ),
                                  const SizedBox(width: AppSpacing.tokenS),
                                  _filterChip(
                                    _NotificationFilter.claims,
                                    l10n.notificationsFilterClaims,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.tokenXs),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextLinkButton(
                                label: l10n.notificationsMarkAllRead,
                                onPressed: unreadCount == 0
                                    ? null
                                    : () => _markAllRead(
                                        center, isShowingDemo, items),
                                foregroundColor: Colors.white,
                                textStyle: AppTypography.buyerMobile.labelSmall
                                    .toTextStyle(
                                      color: Colors.white,
                                    )
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.tokenXl,
                    AppSpacing.tokenXl,
                    AppSpacing.tokenXl,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      if (filtered.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.token4Xl,
                          ),
                          child: AppText(
                            l10n.notificationsEmpty,
                            variant: AppTextVariant.bodyMedium,
                            textAlign: TextAlign.center,
                            style: AppTypography.buyerMobile.bodyMedium
                                .toTextStyle(
                              color: AppColors.semantic.text.secondary,
                            ),
                          ),
                        )
                      else ...<Widget>[
                        if (todayItems.isNotEmpty) ...<Widget>[
                          _DateGroupHeader(title: l10n.notificationsToday),
                          const SizedBox(height: AppSpacing.tokenS),
                          ..._notificationCards(
                            context,
                            todayItems,
                            center,
                            isShowingDemo,
                          ),
                        ],
                        if (yesterdayItems.isNotEmpty) ...<Widget>[
                          const SizedBox(height: AppSpacing.tokenL),
                          _DateGroupHeader(title: l10n.notificationsYesterday),
                          const SizedBox(height: AppSpacing.tokenS),
                          ..._notificationCards(
                            context,
                            yesterdayItems,
                            center,
                            isShowingDemo,
                          ),
                        ],
                        if (olderItems.isNotEmpty) ...<Widget>[
                          const SizedBox(height: AppSpacing.tokenL),
                          _DateGroupHeader(
                            title: DateFormat.yMMMMd(
                              Localizations.localeOf(context).toString(),
                            ).format(olderItems.first.createdAt),
                          ),
                          const SizedBox(height: AppSpacing.tokenS),
                          ..._notificationCards(
                            context,
                            olderItems,
                            center,
                            isShowingDemo,
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _filterChip(_NotificationFilter filter, String label) {
    return NotificationFilterChip(
      label: label,
      selected: _selectedFilter == filter,
      onTap: () => setState(() => _selectedFilter = filter),
    );
  }

  List<Widget> _notificationCards(
    BuildContext context,
    List<NotificationCardData> items,
    InAppNotificationCenter center,
    bool isShowingDemo,
  ) {
    return <Widget>[
      for (final item in items) ...<Widget>[
        NotificationItemCard(
          item: item,
          timeLabel: _timeLabel(context, item),
          onTap: () {
            if (isShowingDemo) {
              if (!item.isRead) {
                setState(() => _locallyReadDemoIds.add(item.id));
              }
            } else {
              center.markRead(item.id);
            }
          },
        ),
        const SizedBox(height: AppSpacing.tokenS),
      ],
    ];
  }

  List<NotificationCardData> _demoItems(AppLocalizations l10n) {
    final now = DateTime.now();
    final todayAtTenForty = DateTime(now.year, now.month, now.day, 10, 40);
    final yesterday = now.subtract(const Duration(days: 1));
    return <NotificationCardData>[
      NotificationCardData(
        id: 'demo_claim_todo',
        title: l10n.notificationsDemoClaimTitle,
        message: l10n.notificationsDemoClaimMessage,
        createdAt: now.subtract(const Duration(minutes: 5)),
        type: NotificationCardType.claim,
        isRead: _locallyReadDemoIds.contains('demo_claim_todo'),
        sampleTimeKey: 'five_minutes',
      ),
      NotificationCardData(
        id: 'demo_shipment',
        title: l10n.notificationsDemoShipmentTitle,
        message: l10n.notificationsDemoShipmentMessage,
        createdAt: now.subtract(const Duration(minutes: 30)),
        type: NotificationCardType.shipment,
        isRead: _locallyReadDemoIds.contains('demo_shipment'),
        sampleTimeKey: 'thirty_minutes',
      ),
      NotificationCardData(
        id: 'demo_protection',
        title: l10n.notificationsDemoProtectionTitle,
        message: l10n.notificationsDemoProtectionMessage,
        createdAt: todayAtTenForty,
        type: NotificationCardType.protection,
        isRead: _locallyReadDemoIds.contains('demo_protection'),
        sampleTimeKey: 'today',
      ),
      NotificationCardData(
        id: 'demo_approved',
        title: l10n.notificationsDemoApprovedTitle,
        message: l10n.notificationsDemoApprovedMessage,
        createdAt:
            DateTime(yesterday.year, yesterday.month, yesterday.day, 6, 20),
        type: NotificationCardType.success,
        isRead: _demoReadIds.contains('demo_approved') ||
            _locallyReadDemoIds.contains('demo_approved'),
        sampleTimeKey: 'yesterday_six',
      ),
      NotificationCardData(
        id: 'demo_review',
        title: l10n.notificationsDemoReviewTitle,
        message: l10n.notificationsDemoReviewMessage,
        createdAt:
            DateTime(yesterday.year, yesterday.month, yesterday.day, 9, 15),
        type: NotificationCardType.info,
        isRead: _demoReadIds.contains('demo_review') ||
            _locallyReadDemoIds.contains('demo_review'),
        sampleTimeKey: 'yesterday_nine',
      ),
    ];
  }

  List<NotificationCardData> _liveItems(List<InAppNotification> items) {
    return items.map((item) {
      final text = '${item.title} ${item.message}'.toLowerCase();
      final type = switch (item.type) {
        InAppNotificationType.success => NotificationCardType.success,
        InAppNotificationType.warning => NotificationCardType.protection,
        InAppNotificationType.error => NotificationCardType.claim,
        InAppNotificationType.info => _inferInfoType(text),
      };
      return NotificationCardData(
        id: item.id,
        title: item.title,
        message: item.message,
        createdAt: item.createdAt,
        type: type,
        isRead: item.isRead,
      );
    }).toList(growable: false);
  }

  NotificationCardType _inferInfoType(String text) {
    if (text.contains('claim') ||
        text.contains('مطالبة') ||
        text.contains('مطالبات') ||
        text.contains('تعويض')) {
      return NotificationCardType.claim;
    }
    if (text.contains('protect') || text.contains('حماية')) {
      return NotificationCardType.protection;
    }
    if (text.contains('shipment') || text.contains('شحنة')) {
      return NotificationCardType.shipment;
    }
    return NotificationCardType.info;
  }

  bool _matchesFilter(NotificationCardData item) {
    return switch (_selectedFilter) {
      _NotificationFilter.all => true,
      _NotificationFilter.unread => !item.isRead,
      _NotificationFilter.claims => item.type == NotificationCardType.claim,
      _NotificationFilter.shipments =>
        item.type == NotificationCardType.shipment ||
            item.type == NotificationCardType.protection,
    };
  }

  String _timeLabel(BuildContext context, NotificationCardData item) {
    final l10n = AppLocalizations.of(context)!;
    switch (item.sampleTimeKey) {
      case 'five_minutes':
        return l10n.notificationsTimeFiveMinutes;
      case 'thirty_minutes':
        return l10n.notificationsTimeThirtyMinutes;
      case 'today':
        return l10n.notificationsTimeTodayExample;
      case 'yesterday_six':
        return l10n.notificationsTimeYesterdaySix;
      case 'yesterday_nine':
        return l10n.notificationsTimeYesterdayNine;
    }

    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final difference = now.difference(item.createdAt);
    if (difference.inMinutes < 60 && difference.inDays == 0) {
      return l10n.notificationsMinutesAgo(
        difference.inMinutes.clamp(1, 59).toInt(),
      );
    }
    final time = DateFormat.jm(locale).format(item.createdAt);
    if (_sameDate(item.createdAt, now)) return l10n.notificationsTodayAt(time);
    if (_sameDate(item.createdAt, now.subtract(const Duration(days: 1)))) {
      return l10n.notificationsYesterdayAt(time);
    }
    return DateFormat.yMMMd(locale).add_jm().format(item.createdAt);
  }

  Future<void> _markAllRead(
    InAppNotificationCenter center,
    bool isShowingDemo,
    List<NotificationCardData> items,
  ) async {
    if (isShowingDemo) {
      setState(() {
        _locallyReadDemoIds.addAll(items.map((item) => item.id));
      });
    } else {
      await center.markAllRead();
    }
  }

  bool _sameDate(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }
}

class _DateGroupHeader extends StatelessWidget {
  const _DateGroupHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      variant: AppTextVariant.titleSmall,
      textAlign: TextAlign.right,
      style: AppTypography.buyerMobile.h6
          .toTextStyle(
            color: AppColors.primitives.neutral.shade700,
          )
          .copyWith(fontWeight: FontWeight.w700),
    );
  }
}
