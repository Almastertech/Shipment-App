import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/activity_entry_card.dart';
import 'widgets/activity_filter_chip.dart';
import 'widgets/activity_stats_card.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';

enum _ActivityFilter { all, shipments, claims }

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  _ActivityFilter _filter = _ActivityFilter.all;
  bool _newestFirst = true;
  bool _showOlder = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final heroHeight =
        ProfileHero.heightForWidth(MediaQuery.sizeOf(context).width);
    final orderedEntries = _activityEntries(l10n, includeOlder: _showOlder)
        .where(_matchesFilter)
        .toList();
    final entries = _newestFirst
        ? orderedEntries
        : orderedEntries.reversed.toList();

    final grouped = <int, List<ActivityEntry>>{};
    for (final entry in entries) {
      grouped.putIfAbsent(entry.day, () => <ActivityEntry>[]).add(entry);
    }

    return AppScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.token2Xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: heroHeight + ActivityStatsCard.height - _statsOverlap,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    height: heroHeight,
                    child: ProfileSubpageHero(
                      title: l10n.activityTitle,
                      subtitle: l10n.activitySubtitle,
                      backLabel: l10n.navigationBack,
                      onBack: () => _goBack(context),
                    ),
                  ),
                  PositionedDirectional(
                    top: heroHeight - _statsOverlap,
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    child: ActivityStatsCard(
                      stats: <ActivityStat>[
                        ActivityStat(
                          label: l10n.profileStatShipments,
                          value: l10n.profileStatShipmentsValue,
                        ),
                        ActivityStat(
                          label: l10n.profileStatClaims,
                          value: l10n.profileStatClaimsValue,
                        ),
                        ActivityStat(
                          label: l10n.profileStatCompensations,
                          value: l10n.profileStatCompensationsValue,
                          valueColor: AppColors.primitives.mint.shade400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.tokenXl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: AppSpacing.token2Xl),
                  _ActivityFilters(
                    filter: _filter,
                    newestFirst: _newestFirst,
                    onFilterChanged: (filter) =>
                        setState(() => _filter = filter),
                    onSortChanged: () =>
                        setState(() => _newestFirst = !_newestFirst),
                  ),
                  const SizedBox(height: AppSpacing.token2Xl),
                  for (final entry in grouped.entries) ...<Widget>[
                    AppText(
                      _dayLabel(entry.key, l10n),
                      variant: AppTextVariant.labelMedium,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: AppTypography.buyerMobile.label.toTextStyle(
                        color: AppColors.primitives.neutral.shade700,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppSpacing.tokenS),
                    for (var index = 0;
                        index < entry.value.length;
                        index++) ...<Widget>[
                      ActivityEntryCard(entry: entry.value[index]),
                      if (index < entry.value.length - 1)
                        const SizedBox(height: AppSpacing.tokenS),
                    ],
                    const SizedBox(height: AppSpacing.token2Xl),
                  ],
                  Center(
                    child: TextButton(
                      onPressed: () => setState(() => _showOlder = !_showOlder),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primitives.primary.shade500,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: AppTypography.buyerMobile.label.toTextStyle(
                          color: AppColors.primitives.primary.shade500,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                      child: Text(
                        _showOlder
                            ? l10n.activityShowLess
                            : l10n.activityShowOlder,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const double _statsOverlap =
      AppSpacing.token3Xl + AppSpacing.tokenXl;

  bool _matchesFilter(ActivityEntry entry) {
    return switch (_filter) {
      _ActivityFilter.all => true,
      _ActivityFilter.shipments =>
        entry.filter == ActivityEntryFilter.shipment,
      _ActivityFilter.claims => entry.filter == ActivityEntryFilter.claim,
    };
  }

  List<ActivityEntry> _activityEntries(
    AppLocalizations l10n, {
    required bool includeOlder,
  }) {
    final entries = <ActivityEntry>[
      ActivityEntry(
        day: 6,
        time: l10n.activityTime1040,
        title: l10n.activityShipmentOutTitle,
        description: l10n.activityShipmentOutDescription,
        kind: ActivityEntryKind.shipment,
        filter: ActivityEntryFilter.shipment,
      ),
      ActivityEntry(
        day: 6,
        time: l10n.activityTime0915,
        title: l10n.activityClaimReviewTitle,
        description: l10n.activityClaimReviewDescription,
        kind: ActivityEntryKind.pendingClaim,
        filter: ActivityEntryFilter.claim,
      ),
      ActivityEntry(
        day: 5,
        time: l10n.activityTime0420,
        title: l10n.activityCompensationTitle,
        description: l10n.activityCompensationDescription,
        kind: ActivityEntryKind.compensation,
        filter: ActivityEntryFilter.claim,
      ),
      ActivityEntry(
        day: 3,
        time: l10n.activityTime0210,
        title: l10n.activityClaimSubmittedTitle,
        description: l10n.activityClaimSubmittedDescription,
        kind: ActivityEntryKind.submittedClaim,
        filter: ActivityEntryFilter.claim,
      ),
    ];

    if (includeOlder) {
      entries.addAll(<ActivityEntry>[
        ActivityEntry(
          day: 2,
          time: l10n.activityTime1130,
          title: l10n.activityShipmentDeliveredTitle,
          description: l10n.activityShipmentOutDescription,
          kind: ActivityEntryKind.shipment,
          filter: ActivityEntryFilter.shipment,
        ),
        ActivityEntry(
          day: 1,
          time: l10n.activityTime0805,
          title: l10n.activityClaimReviewTitle,
          description: l10n.activityClaimReviewDescription,
          kind: ActivityEntryKind.pendingClaim,
          filter: ActivityEntryFilter.claim,
        ),
      ]);
    }

    return entries;
  }

  String _dayLabel(int day, AppLocalizations l10n) => switch (day) {
        6 => l10n.activityToday,
        5 => l10n.activityYesterday,
        3 => l10n.activityOctoberThird,
        2 => l10n.activityOctoberSecond,
        _ => l10n.activityOctoberFirst,
      };

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }
}

class _ActivityFilters extends StatelessWidget {
  const _ActivityFilters({
    required this.filter,
    required this.newestFirst,
    required this.onFilterChanged,
    required this.onSortChanged,
  });

  final _ActivityFilter filter;
  final bool newestFirst;
  final ValueChanged<_ActivityFilter> onFilterChanged;
  final VoidCallback onSortChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        ActivityFilterChip(
          label: l10n.activityFilterAll,
          selected: filter == _ActivityFilter.all,
          onTap: () => onFilterChanged(_ActivityFilter.all),
        ),
        const SizedBox(width: AppSpacing.tokenS),
        ActivityFilterChip(
          label: l10n.activityFilterShipments,
          selected: filter == _ActivityFilter.shipments,
          onTap: () => onFilterChanged(_ActivityFilter.shipments),
        ),
        const SizedBox(width: AppSpacing.tokenS),
        ActivityFilterChip(
          label: l10n.activityFilterClaims,
          selected: filter == _ActivityFilter.claims,
          onTap: () => onFilterChanged(_ActivityFilter.claims),
        ),
        const Spacer(),
        Semantics(
          button: true,
          label: newestFirst
              ? l10n.activityLatestFirst
              : l10n.activityOldestFirst,
          child: GestureDetector(
            onTap: onSortChanged,
            child: AppText(
              newestFirst ? l10n.activityLatestFirst : l10n.activityOldestFirst,
              variant: AppTextVariant.labelSmall,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.left,
              style: AppTypography.buyerMobile.labelSmall.toTextStyle(
                color: AppColors.primitives.primary.shade500,
              ).copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
