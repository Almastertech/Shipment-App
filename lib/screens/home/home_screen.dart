import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../components/app_card.dart';
import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../components/section_title.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../core/session/session_manager.dart';
import '../../data/model/customer_home.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import 'home_view_model.dart';
import 'widgets/home_header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.isLoading = false});

  /// Allows callers to skeletonize the home screen during an outer transition.
  final bool isLoading;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavigationIndex = 0;
  HomeViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    if (getIt.isRegistered<SessionManager>() &&
        getIt<SessionManager>().isAuthenticated &&
        getIt.isRegistered<HomeViewModel>()) {
      _viewModel = getIt<HomeViewModel>()..addListener(_onHomeChanged);
      _viewModel!.load();
    }
  }

  void _onHomeChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _viewModel
      ?..removeListener(_onHomeChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.semantic;
    final home = _viewModel?.home;
    final loading = widget.isLoading || (_viewModel?.loading ?? false);
    final featured = home?.featuredShipment;
    final shipments = (home?.activeShipments ?? const <CustomerHomeShipment>[])
        .where((item) => item.packageId != featured?.packageId)
        .toList(growable: false);

    return IgnorePointer(
      key: const Key('home-screen-loading-interaction-blocker'),
      ignoring: loading,
      child: AppScaffold(
        isLoading: loading,
        padding: EdgeInsets.zero,
        safeArea: false,
        safeAreaBottom: false,
        backgroundColor: colors.background.primary,
        extendBody: true,
        body: RefreshIndicator(
          onRefresh: () async {
            await _viewModel?.load();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HomeHeaderWidget(
                  customerName: home?.customerName,
                  heroState: home?.heroState,
                  featuredShipment: featured,
                  onShipmentTap: featured == null
                      ? null
                      : () => context.go(AppRoutes.shipments),
                ),
                const SizedBox(height: AppSpacing.token4Xl),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.tokenXl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      if (_viewModel?.error != null) ...<Widget>[
                        AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppText(l10n.homeLoadError),
                              const SizedBox(height: AppSpacing.tokenS),
                              TextButton.icon(
                                onPressed: _viewModel!.load,
                                icon: const Icon(Icons.refresh),
                                label: Text(l10n.retry),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.tokenL),
                      ],
                      if (home?.hasRequiredAction == true) ...<Widget>[
                        AppCard(
                          color: AppColors.primitives.warning.shade100,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.info_outline),
                              const SizedBox(width: AppSpacing.tokenS),
                              Expanded(child: AppText(l10n.homeActionRequired)),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.tokenL),
                      ],
                      SectionTitle(
                        title: l10n.homeMoreShipmentsTitle,
                        trailing: _SeeAllLink(
                          label: l10n.homeSeeAll,
                          onTap: () => context.go(AppRoutes.shipments),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.tokenM),
                      if (shipments.isEmpty)
                        AppCard(child: AppText(l10n.homeNoOtherShipments))
                      else
                        ...shipments.map(
                          (shipment) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.tokenS,
                            ),
                            child: _ShipmentCard(
                              shipment: shipment,
                              onTap: () => context.go(AppRoutes.shipments),
                            ),
                          ),
                        ),
                      const SizedBox(height: AppSpacing.tokenL),
                      SectionTitle(
                        title: l10n.homeActiveClaims,
                        trailing: _SeeAllLink(
                          label: l10n.homeSeeAll,
                          onTap: () => context.go(AppRoutes.requests),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.tokenM),
                      if (home?.activeClaims.isNotEmpty != true)
                        AppCard(child: AppText(l10n.homeNoActiveClaims))
                      else
                        ...home!.activeClaims.map(
                          (claim) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.tokenS,
                            ),
                            child: _ClaimCard(claim: claim),
                          ),
                        ),
                      if ((home?.partnerStoresCount ?? 0) > 0) ...<Widget>[
                        const SizedBox(height: AppSpacing.tokenL),
                        AppCard(
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.storefront_outlined),
                              const SizedBox(width: AppSpacing.tokenS),
                              Expanded(
                                child: AppText(
                                  l10n.homePartnerStoreCount(
                                    home!.partnerStoresCount,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.token9Xl),
                      const SizedBox(height: AppSpacing.tokenXl),
                    ],
                  ),
                ),
              ],
            ),
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
                  selectedIndex: _selectedNavigationIndex,
                  onDestinationSelected: (index) {
                    if (index == 1) context.go(AppRoutes.shipments);
                    if (index == 2) context.go(AppRoutes.requests);
                    if (index == 3) context.go(AppRoutes.shops);
                    if (index == 4) context.go(AppRoutes.profile);
                    if (index == 0) {
                      setState(() => _selectedNavigationIndex = 0);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SeeAllLink extends StatelessWidget {
  const _SeeAllLink({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onTap,
        child: Text(label),
      );
}

class _ShipmentCard extends StatelessWidget {
  const _ShipmentCard({required this.shipment, required this.onTap});
  final CustomerHomeShipment shipment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final date = shipment.expectedDeliveryAt;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final tracking = shipment.trackingNumber;
    final details = <String>[
      if (shipment.storeName != null) shipment.storeName!,
      if (shipment.orderNumber != null)
        '${l10n.homeOrderNumber} ${shipment.orderNumber}',
    ].join(' · ');
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.inventory_2_outlined),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(
                child: Text(
                  shipment.productName ?? l10n.homeFeaturedShipment,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.tokenXs),
          Text(details.isEmpty ? l10n.homeNoShipmentDetails : details),
          const SizedBox(height: AppSpacing.tokenS),
          Text(_displayStatus(shipment.status) ?? l10n.homeNoShipmentStatus),
          if (tracking != null) ...<Widget>[
            const SizedBox(height: AppSpacing.tokenXs),
            Text('${l10n.homeTrackingNumber}: $tracking'),
          ],
          if (date != null) ...<Widget>[
            const SizedBox(height: AppSpacing.tokenXs),
            Text(
              '${l10n.homeExpectedDelivery}: ${DateFormat.yMMMd(locale).format(date.toLocal())}',
            ),
          ],
        ],
      ),
    );
  }
}

class _ClaimCard extends StatelessWidget {
  const _ClaimCard({required this.claim});
  final CustomerHomeClaim claim;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final amount = _formatHalalas(claim.claimedAmountHalalas);
    final status = _displayStatus(claim.status);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.assignment_outlined),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(
                child: Text(
                  claim.type ?? l10n.homeClaim,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              if (status != null) Chip(label: Text(status)),
            ],
          ),
          if (claim.ticketNumber != null)
            Text('${l10n.homeTicketNumber}: ${claim.ticketNumber}'),
          if (claim.storeName != null || claim.orderNumber != null)
            Text(
              [
                if (claim.storeName != null) claim.storeName!,
                if (claim.orderNumber != null)
                  '${l10n.homeOrderNumber} ${claim.orderNumber}',
              ].join(' · '),
            ),
          if (amount != null) Text('${l10n.homeClaimedAmount}: $amount'),
        ],
      ),
    );
  }
}

String? _displayStatus(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  return raw
      .trim()
      .replaceAll(RegExp(r'[_-]+'), ' ')
      .split(' ')
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
}

String? _formatHalalas(String? value) {
  final halalas = BigInt.tryParse(value ?? '');
  if (halalas == null) return null;
  final absolute = halalas.abs();
  final whole = absolute ~/ BigInt.from(100);
  final fraction = (absolute % BigInt.from(100)).toString().padLeft(2, '0');
  return '${halalas.isNegative ? '-' : ''}$whole.$fraction';
}
