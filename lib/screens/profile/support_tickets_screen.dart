import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_tap_target.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'models/support_ticket.dart';
import 'widgets/activity_filter_chip.dart';
import 'widgets/activity_stats_card.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';
import 'widgets/support_ticket_card.dart';

enum _TicketFilter { all, shipments, compensations }

class SupportTicketsScreen extends StatefulWidget {
  const SupportTicketsScreen({super.key});

  @override
  State<SupportTicketsScreen> createState() => _SupportTicketsScreenState();
}

class _SupportTicketsScreenState extends State<SupportTicketsScreen> {
  static const double _statsOverlap =  AppSpacing.token2Xl;

  _TicketFilter _filter = _TicketFilter.all;
  bool _newestFirst = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final heroHeight =
        ProfileHero.heightForWidth(MediaQuery.sizeOf(context).width);
    final filteredTickets = _tickets(l10n).where(_matchesFilter).toList();
    final tickets =
        _newestFirst ? filteredTickets : filteredTickets.reversed.toList();

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
                      title: l10n.supportTicketsTitle,
                      subtitle: l10n.supportTicketsSubtitle,
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
                          label: l10n.supportTicketsStatAll,
                          value: '12',
                        ),
                        ActivityStat(
                          label: l10n.supportTicketsStatOpen,
                          value: '3',
                        ),
                        ActivityStat(
                          label: l10n.supportTicketsStatResolved,
                          value: '9',
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
                  PrimaryButton(
                    label: l10n.supportTicketsNewButton,
                    onPressed: () =>
                        context.push(AppRoutes.createSupportTicket),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                        AppTapTarget.actionButtonHeight,
                      ),
                      backgroundColor: AppColors.primitives.primary.shade500,
                      foregroundColor: AppColors.primitives.neutral.shade100,
                      shape: const StadiumBorder(),
                      textStyle: AppTypography.buyerMobile.bodyMedium
                          .toTextStyle(
                            color: AppColors.primitives.neutral.shade100,
                          )
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.token2Xl),
                  _TicketFilters(
                    selected: _filter,
                    newestFirst: _newestFirst,
                    onFilterChanged: (value) => setState(() => _filter = value),
                    onSortChanged: () =>
                        setState(() => _newestFirst = !_newestFirst),
                  ),
                  const SizedBox(height: AppSpacing.tokenXl),
                  for (var index = 0;
                      index < tickets.length;
                      index++) ...<Widget>[
                    SupportTicketCard(
                      status: tickets[index].status,
                      statusLabel: tickets[index].statusLabel,
                      title: tickets[index].title,
                      subtitle: tickets[index].subtitle,
                      lastUpdateLabel: l10n.supportTicketsLastUpdate,
                      lastUpdate: tickets[index].lastUpdate,
                      categoryLabel: l10n.supportTicketsCategory,
                      category: tickets[index].categoryLabel,
                      actionLabel: tickets[index].actionLabel,
                      onAction: () => context.push(
                        AppRoutes.supportTicketDetails,
                        extra: tickets[index],
                      ),
                    ),
                    if (index < tickets.length - 1)
                      const SizedBox(height: AppSpacing.tokenM),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _matchesFilter(SupportTicket ticket) => switch (_filter) {
        _TicketFilter.all => true,
        _TicketFilter.shipments =>
          ticket.category == SupportTicketCategory.shipment,
        _TicketFilter.compensations =>
          ticket.category == SupportTicketCategory.compensation,
      };

  List<SupportTicket> _tickets(AppLocalizations l10n) => <SupportTicket>[
        SupportTicket(
          category: SupportTicketCategory.compensation,
          status: SupportTicketStatus.inProgress,
          statusLabel: l10n.supportTicketsStatusInProgress,
          title: l10n.supportTicketsCompensationTitle,
          subtitle: l10n.supportTicketsCompensationSubtitle,
          lastUpdate: l10n.supportTicketsUpdateTwoHoursAgo,
          categoryLabel: l10n.supportTicketsCompensationCategory,
          actionLabel: l10n.supportTicketsViewTicket,
          conversationDate: l10n.supportTicketConversationDate,
          messages: <SupportTicketMessage>[
            SupportTicketMessage(
              author: SupportTicketMessageAuthor.customer,
              body: l10n.supportTicketCustomerMessage,
              metadata: l10n.supportTicketCustomerMetadata,
            ),
            SupportTicketMessage(
              author: SupportTicketMessageAuthor.team,
              body: l10n.supportTicketTeamMessage,
              metadata: l10n.supportTicketsUpdateTwoHoursAgo,
            ),
          ],
        ),
        SupportTicket(
          category: SupportTicketCategory.shipment,
          status: SupportTicketStatus.awaitingReply,
          statusLabel: l10n.supportTicketsStatusWaiting,
          title: l10n.supportTicketsShipmentTitle,
          subtitle: l10n.supportTicketsShipmentSubtitle,
          lastUpdate: l10n.supportTicketsUpdateYesterday,
          categoryLabel: l10n.supportTicketsShipmentCategory,
          actionLabel: l10n.supportTicketsViewReply,
          conversationDate: '',
          messages: const <SupportTicketMessage>[],
        ),
      ];

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }
}

class _TicketFilters extends StatelessWidget {
  const _TicketFilters({
    required this.selected,
    required this.newestFirst,
    required this.onFilterChanged,
    required this.onSortChanged,
  });

  final _TicketFilter selected;
  final bool newestFirst;
  final ValueChanged<_TicketFilter> onFilterChanged;
  final VoidCallback onSortChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sortLabel =
        newestFirst ? l10n.activityLatestFirst : l10n.activityOldestFirst;

    return Row(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        ActivityFilterChip(
          label: l10n.supportTicketsFilterAll,
          selected: selected == _TicketFilter.all,
          onTap: () => onFilterChanged(_TicketFilter.all),
        ),
        const SizedBox(width: AppSpacing.tokenS),
        ActivityFilterChip(
          label: l10n.supportTicketsFilterShipments,
          selected: selected == _TicketFilter.shipments,
          onTap: () => onFilterChanged(_TicketFilter.shipments),
        ),
        const SizedBox(width: AppSpacing.tokenS),
        ActivityFilterChip(
          label: l10n.supportTicketsFilterCompensations,
          selected: selected == _TicketFilter.compensations,
          onTap: () => onFilterChanged(_TicketFilter.compensations),
        ),
        const Spacer(),
        Semantics(
          button: true,
          label: sortLabel,
          child: GestureDetector(
            onTap: onSortChanged,
            child: AppText(
              sortLabel,
              variant: AppTextVariant.labelSmall,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.left,
              style: AppTypography.buyerMobile.labelSmall
                  .toTextStyle(
                    color: AppColors.primitives.primary.shade500,
                  )
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
