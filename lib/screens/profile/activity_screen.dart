import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../data/model/customer_activity.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import 'activity_view_model.dart';
import 'profile_view_model.dart';
import 'widgets/activity_entry_card.dart';
import 'widgets/activity_filter_chip.dart';
import 'widgets/activity_stats_card.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key, this.isLoading = false});
  final bool isLoading;

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late final ActivityViewModel _activity;
  late final ProfileViewModel _profile;

  @override
  void initState() {
    super.initState();
    _activity = getIt<ActivityViewModel>()..addListener(_changed);
    _profile = getIt<ProfileViewModel>()..addListener(_changed);
    _activity.load();
    _profile.load();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _activity
      ..removeListener(_changed)
      ..dispose();
    _profile
      ..removeListener(_changed)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final heroHeight =
        ProfileHero.heightForWidth(MediaQuery.sizeOf(context).width);
    final account = _profile.account;
    final grouped = <DateTime, List<CustomerActivity>>{};
    for (final item in _activity.items) {
      final local = item.occurredAt.toLocal();
      grouped
          .putIfAbsent(DateTime(local.year, local.month, local.day), () => [])
          .add(item);
    }

    return AppScaffold(
      isLoading: widget.isLoading,
      loadingLabel: l10n.loading,
      padding: EdgeInsets.zero,
      safeArea: false,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.token2Xl),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            height: heroHeight + ActivityStatsCard.height - AppSpacing.tokenXl,
            child: Stack(clipBehavior: Clip.none, children: [
              PositionedDirectional(
                  top: 0,
                  start: 0,
                  end: 0,
                  height: heroHeight,
                  child: ProfileSubpageHero(
                      title: l10n.activityTitle,
                      subtitle: l10n.activitySubtitle,
                      backLabel: l10n.navigationBack,
                      onBack: _goBack)),
              PositionedDirectional(
                  top: heroHeight - AppSpacing.tokenXl,
                  start: AppSpacing.tokenXl,
                  end: AppSpacing.tokenXl,
                  child: ActivityStatsCard(stats: [
                    ActivityStat(
                        label: l10n.profileStatShipments,
                        value: account?.shipmentsCount.toString() ?? '—'),
                    ActivityStat(
                        label: l10n.profileStatClaims,
                        value: account?.claimsCount.toString() ?? '—'),
                    ActivityStat(
                        label: l10n.profileStatCompensations,
                        value: account == null
                            ? '—'
                            : '${account.compensationRiyals} ${locale.startsWith('ar') ? 'ر.س' : 'SAR'}',
                        valueColor: AppColors.primitives.mint.shade400),
                  ])),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenXl),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.token2Xl),
                  Wrap(
                      spacing: AppSpacing.tokenS,
                      runSpacing: AppSpacing.tokenS,
                      children: [
                        for (final filter in <(String, String)>[
                          ('all', l10n.activityFilterAll),
                          ('shipments', l10n.activityFilterShipments),
                          ('claims', l10n.activityFilterClaims)
                        ])
                          ActivityFilterChip(
                              label: filter.$2,
                              selected: _activity.type == filter.$1,
                              onTap: () => _activity.selectType(filter.$1)),
                      ]),
                  const SizedBox(height: AppSpacing.token2Xl),
                  if (_profile.error != null)
                    TextButton(
                        onPressed: _profile.load,
                        child:
                            Text('${l10n.errorGenericMessage} ${l10n.retry}')),
                  if (_activity.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (_activity.error != null && _activity.items.isEmpty)
                    TextButton(
                        onPressed: _activity.load,
                        child:
                            Text('${l10n.errorGenericMessage} ${l10n.retry}'))
                  else if (_activity.items.isEmpty)
                    Center(child: Text(l10n.noItemsTitle))
                  else ...[
                    for (final day in grouped.entries) ...[
                      AppText(DateFormat.yMMMd(locale).format(day.key),
                          variant: AppTextVariant.labelMedium),
                      const SizedBox(height: AppSpacing.tokenS),
                      for (final item in day.value) ...[
                        ActivityEntryCard(entry: _entry(item, locale)),
                        const SizedBox(height: AppSpacing.tokenS),
                      ],
                      const SizedBox(height: AppSpacing.tokenL),
                    ],
                    if (_activity.error != null)
                      TextButton(
                          onPressed: _activity.loadMore,
                          child:
                              Text('${l10n.errorGenericMessage} ${l10n.retry}'))
                    else if (_activity.loadingMore)
                      const Center(child: CircularProgressIndicator())
                    else if (_activity.hasMore)
                      TextButton(
                          onPressed: _activity.loadMore,
                          child: Text(l10n.activityShowOlder)),
                  ],
                ]),
          ),
        ]),
      ),
    );
  }

  ActivityEntry _entry(CustomerActivity item, String locale) {
    final isClaim = item.type == 'claims';
    final details = [
      item.storeName,
      item.productName,
      item.orderNumber ?? item.trackingNumber
    ].whereType<String>().join(' • ');
    return ActivityEntry(
      day: item.occurredAt.toLocal().day,
      time: DateFormat.jm(locale).format(item.occurredAt.toLocal()),
      title:
          item.event.isNotEmpty ? item.event : (isClaim ? 'Claim' : 'Shipment'),
      description: details,
      kind:
          isClaim ? ActivityEntryKind.pendingClaim : ActivityEntryKind.shipment,
      filter:
          isClaim ? ActivityEntryFilter.claim : ActivityEntryFilter.shipment,
    );
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }
}
