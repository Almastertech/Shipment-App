import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/app_text.dart';
import '../../components/error_ui_mapper.dart';
import '../../components/feedback/status_banner.dart';
import '../../components/feedback/toast_service.dart';
import '../../components/images/app_network_image.dart';
import '../../components/inputs/custom_text_field_normal.dart';
import '../../components/layout/adaptive_page.dart';
import '../../components/layout/adaptive_two_pane.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../components/screen_state_layout.dart';
import '../../components/skeleton/app_list_skeleton.dart';
import '../../core/config/app_environment.dart';
import '../../core/refresh/pull_to_refresh_contract.dart';
import '../../core/resources/app_icon_size.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../core/session/auth_action_guard.dart';
import '../../core/session/session_manager.dart';
import '../../data/model/sample_item.dart';
import '../../features/notifications/presentation/notification_bell_button.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../../localization/controllers/localization_controller.dart';
import '../../themes/theme_controller.dart';
import 'sample_feature_view_model.dart';

class SampleFeatureListScreen extends StatefulWidget {
  const SampleFeatureListScreen({super.key});

  @override
  State<SampleFeatureListScreen> createState() =>
      _SampleFeatureListScreenState();
}

class _SampleFeatureListScreenState extends State<SampleFeatureListScreen> {
  late final ScrollController _scrollController;
  int _selectedNavigationIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final viewModel = context.read<SampleFeatureViewModel>();
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;

    if (viewModel.shouldLoadMore(
      currentPixels: current,
      maxScrollExtent: maxScroll,
    )) {
      viewModel.loadMore();
    }
  }

  Future<void> _onProtectedAction(
    BuildContext context,
    AppLocalizations l10n,
    SampleFeatureViewModel viewModel,
  ) async {
    final decision = getIt<AuthActionGuard>().requireAuthenticated();
    if (decision == AuthActionGuardDecision.requiresLogin) {
      getIt<ToastService>().warning(l10n.authRequiredAction);
      context.push(AppRoutes.login);
      return;
    }

    await viewModel.showInfoNotification(
      title: l10n.protectedAction,
      message: l10n.protectedActionCompleted('demo_item'),
    );
    getIt<ToastService>().success(l10n.protectedActionCompleted('demo_item'));
  }

  Future<void> _onRefresh(
    AppLocalizations l10n,
    SampleFeatureViewModel viewModel,
  ) async {
    final decision = await PullToRefreshContract.run(
      isInitialLoading: viewModel.isLoading,
      isLoadingMore: viewModel.isLoadingMore,
      refreshAction: viewModel.refresh,
    );

    if (!decision.shouldRun) {
      getIt<ToastService>().info(l10n.refreshSkippedWhileLoadingMore);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final viewModel = context.watch<SampleFeatureViewModel>();

    final isSkeleton = viewModel.isLoading && viewModel.items.isEmpty;

    final listSection = _buildListSection(
      l10n: l10n,
      viewModel: viewModel,
      isSkeleton: isSkeleton,
    );

    return Scaffold(
      appBar: AppBar(
        title: AppText.localized(
          (l10n) => l10n.sampleFeatureTitle,
          variant: AppTextVariant.titleLarge,
        ),
        actions: <Widget>[
          const NotificationBellButton(),
          IconButton(
            tooltip: l10n.changeTheme,
            onPressed: () => context.read<ThemeController>().toggleTheme(),
            icon: const Icon(Icons.brightness_6_outlined),
          ),
          IconButton(
            tooltip: l10n.switchLanguage,
            onPressed: () =>
                context.read<LocalizationController>().toggleLanguage(),
            icon: const Icon(Icons.language_outlined),
          ),
          IconButton(
            tooltip: l10n.protectedAction,
            onPressed: () => _onProtectedAction(context, l10n, viewModel),
            icon: const Icon(Icons.shopping_cart_checkout_rounded),
          ),
          IconButton(
            tooltip: l10n.uiKitShowcase,
            onPressed: () => context.push(AppRoutes.uiKitShowcase),
            icon: const Icon(Icons.widgets_outlined),
          ),
          if (AppEnvironment.instance.flavor != AppFlavor.prod)
            IconButton(
              tooltip: l10n.apiMonitor,
              onPressed: () => context.push(AppRoutes.debugApiMonitor),
              icon: const Icon(Icons.monitor_heart_outlined),
            ),
          IconButton(
            tooltip: l10n.logout,
            onPressed: () async {
              await getIt<SessionManager>().clearTokens();
              if (!context.mounted) return;
              context.go(AppRoutes.login);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: AdaptivePage(
        builder: (context, adaptive) {
          final controlsSection = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _FeatureIntroCard(
                title: l10n.sampleFeatureTitle,
                subtitle: l10n.sampleFeatureSubtitle,
              ),
              const SizedBox(height: AppSpacing.p12),
              _PromoBanner(message: l10n.promoBannerMessage),
              const SizedBox(height: AppSpacing.p16),
              CustomTextFieldNormal(
                controller: viewModel.searchController,
                hintText: l10n.searchHint,
                prefixIcon: const Icon(Icons.search),
                textInputAction: TextInputAction.search,
                onChanged: viewModel.onSearchChanged,
              ),
              if (viewModel.recentQueries.isNotEmpty) ...<Widget>[
                const SizedBox(height: AppSpacing.p8),
                Wrap(
                  spacing: AppSpacing.p8,
                  runSpacing: AppSpacing.p8,
                  children: <Widget>[
                    ...viewModel.recentQueries.take(6).map((query) {
                      return ActionChip(
                        label: Text(query),
                        onPressed: () => viewModel.useRecentQuery(query),
                      );
                    }),
                    ActionChip(
                      label: Text(l10n.clearSearchHistory),
                      onPressed: viewModel.clearSearchHistory,
                    ),
                  ],
                ),
              ],
              if (viewModel.recentItemIds.isNotEmpty) ...<Widget>[
                const SizedBox(height: AppSpacing.p8),
                StatusBanner(
                  type: StatusBannerType.info,
                  title: l10n.recentlyViewedTitle,
                  message: viewModel.recentItemIds.take(3).join(', '),
                ),
              ],
            ],
          );

          if (!adaptive.prefersTwoPane) {
            return Column(
              children: <Widget>[
                controlsSection,
                const SizedBox(height: AppSpacing.p12),
                Expanded(child: listSection),
              ],
            );
          }

          return AdaptiveTwoPane(
            firstFlex: 4,
            secondFlex: 6,
            firstPane: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  controlsSection,
                  const SizedBox(height: AppSpacing.p12),
                  _WideInfoCard(
                    title: l10n.sampleFeatureTitle,
                    subtitle: l10n.noItemsDescription,
                  ),
                ],
              ),
            ),
            secondPane: listSection,
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedNavigationIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedNavigationIndex = index);
        },
      ),
      floatingActionButton: viewModel.hasMore &&
              !viewModel.isLoading &&
              !viewModel.isLoadingMore &&
              viewModel.items.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: viewModel.loadMore,
              icon: const Icon(Icons.expand_more),
              label: AppText(
                l10n.loadMore,
                variant: AppTextVariant.labelMedium,
              ),
            )
          : null,
    );
  }

  Widget _buildListSection({
    required AppLocalizations l10n,
    required SampleFeatureViewModel viewModel,
    required bool isSkeleton,
  }) {
    if (isSkeleton) {
      return const AppListSkeleton();
    }

    return ScreenStateLayout(
      isEmpty: viewModel.isEmpty,
      errorUiModel: viewModel.hasError
          ? ErrorUiMapper.fromApiError(viewModel.lastError, l10n)
          : null,
      onRetry: viewModel.loadInitial,
      retryLabel: l10n.retry,
      emptyTitle: l10n.noItemsTitle,
      emptyDescription: l10n.noItemsDescription,
      emptyPrimaryActionLabel: viewModel.searchController.text.trim().isNotEmpty
          ? l10n.clearSearchHistory
          : null,
      onEmptyPrimaryAction: viewModel.searchController.text.trim().isNotEmpty
          ? () {
              viewModel.searchController.clear();
              viewModel.onSearchChanged('');
            }
          : null,
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(l10n, viewModel),
        child: ListView.separated(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.items.length + (viewModel.isLoadingMore ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.p10),
          itemBuilder: (context, index) {
            if (index >= viewModel.items.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSpacing.p12,
                ),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final item = viewModel.items[index];
            return _SampleItemTile(
              item: item,
              onTap: () {
                viewModel.recordItemViewed(item.id);
                context.push(AppRoutes.sampleDetailsPath(item.id));
              },
            );
          },
        ),
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.p12),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.local_offer_outlined,
            color: colorScheme.onTertiaryContainer,
          ),
          const SizedBox(width: AppSpacing.p8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onTertiaryContainer,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureIntroCard extends StatelessWidget {
  const _FeatureIntroCard({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.p16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: <Color>[
              colorScheme.primary.withValues(alpha: .12),
              colorScheme.secondary.withValues(alpha: .08),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppText(
              title,
              variant: AppTextVariant.titleLarge,
            ),
            const SizedBox(height: AppSpacing.p8),
            AppText(
              subtitle,
              variant: AppTextVariant.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _WideInfoCard extends StatelessWidget {
  const _WideInfoCard({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.p16),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 18,
              backgroundColor: colorScheme.secondary.withValues(alpha: .2),
              child: Icon(
                Icons.dashboard_customize_outlined,
                color: colorScheme.secondary,
                size: AppIconSize.iconS,
              ),
            ),
            const SizedBox(width: AppSpacing.p10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppText(
                    title,
                    variant: AppTextVariant.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.p4),
                  AppText(
                    subtitle,
                    variant: AppTextVariant.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SampleItemTile extends StatelessWidget {
  const _SampleItemTile({
    required this.item,
    required this.onTap,
  });

  final SampleItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        minTileHeight: 76,
        leading: _SampleItemAvatar(item: item),
        title: AppText(
          item.title,
          variant: AppTextVariant.titleSmall,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.p4),
          child: AppText(
            item.subtitle,
            variant: AppTextVariant.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Icon(
          Directionality.of(context) == TextDirection.rtl
              ? Icons.chevron_left_rounded
              : Icons.chevron_right_rounded,
          color: colorScheme.primary,
        ),
        onTap: onTap,
      ),
    );
  }
}

class _SampleItemAvatar extends StatelessWidget {
  const _SampleItemAvatar({required this.item});

  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final imageUrl = item.imageUrl;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return AppNetworkImage(
        imageUrl: imageUrl,
        width: 40,
        height: 40,
        memCacheWidth: 80,
        memCacheHeight: 80,
        borderRadius: BorderRadius.circular(100),
        error: (_) => CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.errorContainer,
          child: Icon(
            Icons.broken_image_outlined,
            size: 18,
            color: colorScheme.onErrorContainer,
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 20,
      backgroundColor: colorScheme.primary.withValues(alpha: .14),
      child: AppText(
        item.id,
        variant: AppTextVariant.labelMedium,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colorScheme.primary,
            ),
      ),
    );
  }
}
