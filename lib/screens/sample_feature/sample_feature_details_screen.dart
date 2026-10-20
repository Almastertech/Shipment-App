import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_text.dart';
import '../../components/buttons/custom_button.dart';
import '../../components/error_ui_mapper.dart';
import '../../components/images/app_network_image.dart';
import '../../components/layout/adaptive_page.dart';
import '../../components/layout/adaptive_two_pane.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../components/screen_state_layout.dart';
import '../../components/skeleton/app_details_skeleton.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/screen_utils_helper.dart';
import '../../core/routing/app_routes.dart';
import '../../data/model/sample_item.dart';
import '../../l10n/app_localizations.dart';
import 'sample_feature_details_view_model.dart';

class SampleFeatureDetailsScreen extends StatefulWidget {
  const SampleFeatureDetailsScreen({
    required this.viewModel,
    super.key,
  });

  final SampleFeatureDetailsViewModel viewModel;

  @override
  State<SampleFeatureDetailsScreen> createState() =>
      _SampleFeatureDetailsScreenState();
}

class _SampleFeatureDetailsScreenState
    extends State<SampleFeatureDetailsScreen> {
  late final SampleFeatureDetailsViewModel _viewModel;
  int _selectedNavigationIndex = 1;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    unawaited(_viewModel.load());
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: AppText.localized(
          (l10n) => l10n.detailsTitle,
          variant: AppTextVariant.titleLarge,
        ),
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) {
            return const AppDetailsSkeleton();
          }

          final item = _viewModel.item;
          return ScreenStateLayout(
            errorUiModel: _viewModel.error == null
                ? null
                : ErrorUiMapper.fromApiError(_viewModel.error, l10n),
            onRetry: _viewModel.load,
            retryLabel: l10n.retry,
            child: item != null
                ? _DetailsContent(item: item, l10n: l10n)
                : const SizedBox.shrink(),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedNavigationIndex,
        onDestinationSelected: (index) {
          if (index == 2) {
            context.go(AppRoutes.requests);
            return;
          }
          setState(() => _selectedNavigationIndex = index);
        },
      ),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({required this.item, required this.l10n});

  final SampleItem item;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return AdaptivePage(
      builder: (context, adaptive) {
        final detailsContent = adaptive.prefersTwoPane
            ? AdaptiveTwoPane(
                firstFlex: 4,
                secondFlex: 6,
                firstPane: _SummaryCard(item: item),
                secondPane: SingleChildScrollView(
                  child: _DescriptionCard(item: item),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _SummaryCard(item: item),
                    const SizedBox(height: AppSpacing.p12),
                    _DescriptionCard(item: item),
                  ],
                ),
              );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: detailsContent),
            const SizedBox(height: AppSpacing.p12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SizedBox(
                width: adaptive.prefersTwoPane ? 220 : double.infinity,
                child: CustomButton(
                  label: l10n.itemDetails,
                  onPressed: context.pop,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.item});

  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.p20),
        child: Row(
          children: <Widget>[
            _DetailsHeaderVisual(item: item),
            const SizedBox(width: AppSpacing.p12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppText(
                    item.title,
                    variant: AppTextVariant.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.p4),
                  AppText(
                    item.subtitle,
                    variant: AppTextVariant.bodyMedium,
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

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard({required this.item});

  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.p20),
        child: AppText(
          item.description,
          variant: AppTextVariant.bodyLarge,
        ),
      ),
    );
  }
}

class _DetailsHeaderVisual extends StatelessWidget {
  const _DetailsHeaderVisual({required this.item});

  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final imageUrl = item.imageUrl;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return AppNetworkImage(
        imageUrl: imageUrl,
        width: ScreenUtilsHelper.width(context, 64),
        height: ScreenUtilsHelper.height(context, 64),
        memCacheWidth: 128,
        memCacheHeight: 128,
        borderRadius: BorderRadius.circular(
          ScreenUtilsHelper.radius(context, AppRadius.r12),
        ),
        error: (context) => Container(
          width: ScreenUtilsHelper.width(context, 64),
          height: ScreenUtilsHelper.height(context, 64),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(
              ScreenUtilsHelper.radius(context, AppRadius.r12),
            ),
          ),
          child: Icon(
            Icons.broken_image_outlined,
            color: colorScheme.onErrorContainer,
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: ScreenUtilsHelper.radius(context, 24),
      backgroundColor: colorScheme.primary.withValues(
        alpha: .14,
      ),
      child: AppText(
        item.id,
        variant: AppTextVariant.labelLarge,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
            ),
      ),
    );
  }
}
