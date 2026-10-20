import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/components/app_card.dart';
import 'package:shipments/components/app_scaffold.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/components/buttons/text_link_button.dart';
import 'package:shipments/components/layout/custom_bottom_nav_bar.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';
import 'package:shipments/core/routing/app_routes.dart';
import 'package:shipments/l10n/app_localizations.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  bool _showAllDetails = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      safeAreaBottom: false,
      extendBody: true,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.token3Xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 400,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned.fill(
                    child: _ClaimHero(
                      title: l10n.claimDetailsTitle,
                      subtitle: l10n.claimDetailsProduct,
                      status: l10n.claimDetailsAccepted,
                    ),
                  ),
                  PositionedDirectional(
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    bottom: -108,
                    child: _SuccessSummary(
                      title: l10n.claimDetailsSuccessTitle,
                      body: l10n.claimDetailsSuccessBody,
                      compensationLabel: l10n.requestsCompensationLabel,
                      compensation: l10n.requestsAcceptedCompensation,
                      valueLabel: l10n.requestsItemValueLabel,
                      value: l10n.requestsClosedItemValue,
                      settlementLabel: l10n.claimDetailsSettlement,
                      settlement: l10n.claimDetailsSep7,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 148),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.tokenXl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _SectionTitle(l10n.claimDetailsTimelineTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  _ClaimTimeline(
                    entries: <_TimelineEntry>[
                      _TimelineEntry(
                          l10n.claimDetailsSubmitted, l10n.claimDetailsSep6),
                      _TimelineEntry(
                          l10n.claimDetailsReviewed, l10n.claimDetailsSep7),
                      _TimelineEntry(
                          l10n.claimDetailsDecision, l10n.claimDetailsSep7),
                      _TimelineEntry(
                        l10n.claimDetailsCompensation,
                        '${l10n.claimDetailsSep7} · ${l10n.requestsAcceptedCompensation}',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  _SectionTitle(l10n.claimDetailsEvidenceTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  _EvidenceStrip(
                    labels: <String>[
                      l10n.claimDetailsLabel,
                      l10n.claimDetailsPackaging,
                      l10n.claimDetailsVideo,
                      l10n.claimDetailsAttachment,
                    ],
                  ),
                  const SizedBox(height: AppSpacing.token2Xl),
                  _SectionTitle(l10n.claimDetailsLocationTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  _LocationCard(
                    caption: l10n.claimDetailsLocationCaption,
                    address: l10n.claimDetailsLocation,
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  _NoteCard(
                    title: l10n.claimDetailsNoteTitle,
                    note: l10n.claimDetailsNote,
                  ),
                  const SizedBox(height: AppSpacing.token2Xl),
                  _SectionTitle(l10n.claimDetailsDetailsTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  _DetailsCard(
                    expanded: _showAllDetails,
                    onToggle: () =>
                        setState(() => _showAllDetails = !_showAllDetails),
                    seeAll: l10n.claimDetailsSeeAll,
                    hide: l10n.claimDetailsHide,
                    rows: <_DetailRow>[
                      _DetailRow(l10n.claimDetailsClaimNumber, 'HS-2048'),
                      _DetailRow(l10n.claimDetailsProductLabel,
                          l10n.claimDetailsProductName),
                      _DetailRow(l10n.claimDetailsItemPrice,
                          l10n.requestsClosedItemValue),
                      _DetailRow(l10n.claimDetailsClaimValue,
                          l10n.requestsAcceptedCompensation),
                      _DetailRow(l10n.claimDetailsShipment, 'HS-2048'),
                      _DetailRow(
                          l10n.claimDetailsStore, l10n.claimDetailsStoreName),
                      _DetailRow(l10n.claimDetailsSubmittedDate,
                          l10n.claimDetailsSubmittedDateValue),
                      _DetailRow(l10n.claimDetailsDecisionDate,
                          l10n.claimDetailsDecisionDateValue),
                      _DetailRow(l10n.claimDetailsTransferDate,
                          l10n.claimDetailsTransferDateValue),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.token9Xl),
                        const SizedBox(height: AppSpacing.tokenL),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: SizedBox(
          height: 84,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: CustomBottomNavBar(
                selectedIndex: 2,
                onDestinationSelected: (index) {
                  if (index == 0) context.go(AppRoutes.home);
                  if (index == 1) context.go(AppRoutes.shipments);
                  if (index == 2) context.go(AppRoutes.requests);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ClaimHero extends StatelessWidget {
  const _ClaimHero(
      {required this.title, required this.subtitle, required this.status});

  final String title;
  final String subtitle;
  final String status;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;
    final l10n = AppLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.token2Xl)),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(AppImages.boxFocus,
              fit: BoxFit.cover, alignment: const Alignment(.25, -.3)),
          ColoredBox(color: colors.primary.shade900.withValues(alpha: .42)),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  colors.primary.shade900.withValues(alpha: .14),
                  colors.primary.shade900.withValues(alpha: .88)
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenXl,
              MediaQuery.paddingOf(context).top + AppSpacing.tokenS,
              AppSpacing.tokenXl,
              AppSpacing.token5Xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _HeroAction(
                        icon: Icons.chevron_right_rounded,
                        label: l10n.navigationBack,
                        onTap: () => context.pop()),
                    _HeroAction(
                        icon: Icons.ios_share_rounded,
                        label: l10n.navigationBack,
                        onTap: () {}),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.tokenS,
                        vertical: AppSpacing.token2Xs),
                    decoration: BoxDecoration(
                        color: colors.success.shade100,
                        borderRadius:
                            BorderRadius.circular(AppRadius.tokenFull)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.inventory_2_outlined,
                            size: 16, color: colors.success.shade700),
                        const SizedBox(width: AppSpacing.token2Xs),
                        AppText(status,
                            variant: AppTextVariant.labelSmall,
                            style: AppTypography.buyerMobile.caption
                                .toTextStyle(color: colors.success.shade700)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenS),
                AppText(title,
                    variant: AppTextVariant.headlineMedium,
                    textAlign: TextAlign.start,
                    style: AppTypography.buyerMobile.h2
                        .toTextStyle(color: Colors.white)),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(subtitle,
                    variant: AppTextVariant.bodySmall,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                        color: Colors.white.withValues(alpha: .82))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroAction extends StatelessWidget {
  const _HeroAction(
      {required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Tooltip(
        message: label,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .16),
                border: Border.all(color: Colors.white.withValues(alpha: .45))),
            child: Icon(icon, color: Colors.white, size: 21),
          ),
        ),
      );
}

class _SuccessSummary extends StatelessWidget {
  const _SuccessSummary(
      {required this.title,
      required this.body,
      required this.compensationLabel,
      required this.compensation,
      required this.valueLabel,
      required this.value,
      required this.settlementLabel,
      required this.settlement});
  final String title,
      body,
      compensationLabel,
      compensation,
      valueLabel,
      value,
      settlementLabel,
      settlement;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final entries = <(String, String)>[
      (compensationLabel, compensation),
      (valueLabel, value),
      (settlementLabel, settlement)
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.tokenL),
      decoration: BoxDecoration(
          color: primary.shade700,
          borderRadius: BorderRadius.circular(AppRadius.token2Xl),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withValues(alpha: .14),
                blurRadius: 18,
                offset: const Offset(0, 8))
          ]),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      color: AppColors.primitives.accent01.shade300,
                      borderRadius: BorderRadius.circular(AppRadius.tokenL)),
                  child: Icon(Icons.verified_user_outlined,
                      color: primary.shade900)),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    AppText(title,
                        variant: AppTextVariant.titleMedium,
                        textAlign: TextAlign.start,
                        style: AppTypography.buyerMobile.h6
                            .toTextStyle(color: Colors.white)),
                    const SizedBox(height: AppSpacing.token2Xs),
                    AppText(body,
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                            color: Colors.white.withValues(alpha: .75))),
                  ])),
            ],
          ),
          const SizedBox(height: AppSpacing.tokenL),
          Row(
              children: entries
                  .map((entry) => Expanded(
                          child: Container(
                        margin: const EdgeInsetsDirectional.only(
                            end: AppSpacing.tokenXs),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.tokenS,
                            vertical: AppSpacing.tokenS),
                        decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .13),
                            borderRadius:
                                BorderRadius.circular(AppRadius.tokenL)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              AppText(entry.$1,
                                  variant: AppTextVariant.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.buyerMobile.caption
                                      .toTextStyle(
                                          color: Colors.white
                                              .withValues(alpha: .75))),
                              AppText(entry.$2,
                                  variant: AppTextVariant.titleSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.buyerMobile.label
                                      .toTextStyle(color: Colors.white)),
                            ]),
                      )))
                  .toList()),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => AppText(title,
      variant: AppTextVariant.titleMedium,
      textAlign: TextAlign.start,
      style: AppTypography.buyerMobile.h6
          .toTextStyle(color: AppColors.primitives.neutral.shade900));
}

class _TimelineEntry {
  const _TimelineEntry(this.title, this.subtitle);
  final String title;
  final String subtitle;
}

class _ClaimTimeline extends StatelessWidget {
  const _ClaimTimeline({required this.entries});
  final List<_TimelineEntry> entries;
  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary.shade500;
    return Column(
        children: List<Widget>.generate(entries.length, (index) {
      final entry = entries[index];
      return SizedBox(
        height: 52,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 34,
                child: Stack(alignment: Alignment.topCenter, children: <Widget>[
                  if (index < entries.length - 1)
                    Positioned(
                        top: 16,
                        bottom: 0,
                        child: Container(width: 2, color: primary)),
                  Container(
                      width: 32,
                      height: 32,
                      decoration:
                          BoxDecoration(color: primary, shape: BoxShape.circle),
                      child: const Icon(Icons.check_rounded,
                          color: Colors.white, size: 20)),
                ]),
              ),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    AppText(entry.title,
                        variant: AppTextVariant.titleSmall,
                        textAlign: TextAlign.start,
                        style: AppTypography.buyerMobile.label.toTextStyle(
                            color: AppColors.primitives.neutral.shade900)),
                    AppText(entry.subtitle,
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.start,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                            color: AppColors.primitives.neutral.shade600)),
                  ])),
            ]),
      );
    }));
  }
}

class _EvidenceStrip extends StatelessWidget {
  const _EvidenceStrip({required this.labels});
  final List<String> labels;
  @override
  Widget build(BuildContext context) => Row(
        children: labels
            .map((label) => Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: AppSpacing.tokenS),
                    child: AspectRatio(
                      aspectRatio: .92,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.tokenL),
                        child: Stack(fit: StackFit.expand, children: <Widget>[
                          Image.asset(AppImages.boxFocus,
                              fit: BoxFit.cover, alignment: Alignment.center),
                          ColoredBox(
                              color: Colors.black.withValues(alpha: .12)),
                          if (label == labels[1])
                            const Center(
                                child: Icon(Icons.play_circle_fill_rounded,
                                    color: Colors.white, size: 32)),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  height: 28,
                                  color: Colors.black.withValues(alpha: .62),
                                  alignment: Alignment.center,
                                  child: AppText(label,
                                      variant: AppTextVariant.labelSmall,
                                      style: AppTypography.buyerMobile.caption
                                          .toTextStyle(color: Colors.white)))),
                        ]),
                      ),
                    ),
                  ),
                ))
            .toList(),
      );
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.caption, required this.address});
  final String caption, address;
  @override
  Widget build(BuildContext context) => AppCard(
        padding: const EdgeInsets.all(AppSpacing.tokenL),
        child: Row(children: <Widget>[
          Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: AppColors.primitives.primary.shade100,
                  shape: BoxShape.circle),
              child: Icon(Icons.location_on_outlined,
                  color: AppColors.primitives.primary.shade500)),
          const SizedBox(width: AppSpacing.tokenS),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                AppText(caption,
                    variant: AppTextVariant.bodySmall,
                    textAlign: TextAlign.start,
                    style: AppTypography.buyerMobile.caption.toTextStyle(
                        color: AppColors.primitives.neutral.shade600)),
                AppText(address,
                    variant: AppTextVariant.titleSmall,
                    textAlign: TextAlign.start,
                    style: AppTypography.buyerMobile.label.toTextStyle(
                        color: AppColors.primitives.neutral.shade900)),
              ])),
        ]),
      );
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.title, required this.note});
  final String title, note;
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.tokenL),
        decoration: BoxDecoration(
            color: AppColors.primitives.neutral.shade200,
            borderRadius: BorderRadius.circular(AppRadius.token2Xl)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppText(title,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                      color: AppColors.primitives.neutral.shade600)),
              const SizedBox(height: AppSpacing.tokenXs),
              AppText(note,
                  variant: AppTextVariant.bodyMedium,
                  textAlign: TextAlign.start,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                      color: AppColors.primitives.neutral.shade900)),
            ]),
      );
}

class _DetailRow {
  const _DetailRow(this.label, this.value);
  final String label, value;
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard(
      {required this.rows,
      required this.expanded,
      required this.onToggle,
      required this.seeAll,
      required this.hide});
  final List<_DetailRow> rows;
  final bool expanded;
  final VoidCallback onToggle;
  final String seeAll, hide;
  @override
  Widget build(BuildContext context) => AppCard(
        padding: const EdgeInsetsDirectional.fromSTEB(AppSpacing.tokenL,
            AppSpacing.tokenS, AppSpacing.tokenL, AppSpacing.tokenS),
        child: Column(children: <Widget>[
          ...rows.take(expanded ? rows.length : 4).map((row) => Container(
                constraints: const BoxConstraints(minHeight: 44),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.primitives.neutral.shade200))),
                child: Row(children: <Widget>[
                  AppText(row.label,
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.start,
                      style: AppTypography.buyerMobile.caption.toTextStyle(
                          color: AppColors.primitives.neutral.shade600)),
                  const SizedBox(width: AppSpacing.tokenS),
                  Expanded(
                      child: AppText(row.value,
                          variant: AppTextVariant.titleSmall,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.label.toTextStyle(
                              color: AppColors.primitives.neutral.shade900))),
                ]),
              )),
          TextLinkButton(
            label: expanded ? hide : seeAll,
            onPressed: onToggle,
            foregroundColor: AppColors.primitives.primary.shade500,
          ),
        ]),
      );
}
