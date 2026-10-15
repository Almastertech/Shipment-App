import 'package:flutter/material.dart';

import '../core/permissions/app_permission.dart';
import '../core/permissions/permission_result.dart';
import '../core/permissions/permission_service.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../injection.dart';
import '../l10n/app_localizations.dart';
import 'ui_kit.dart';

enum _UiStatePreview {
  loading,
  empty,
  error,
  content,
}

enum _StoryViewport {
  adaptive,
  phone,
  tablet,
  desktop,
}

class UiKitShowcaseScreen extends StatefulWidget {
  const UiKitShowcaseScreen({super.key});

  @override
  State<UiKitShowcaseScreen> createState() => _UiKitShowcaseScreenState();
}

class _UiKitShowcaseScreenState extends State<UiKitShowcaseScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _searchController;

  String? _selectedRole = 'user';
  AppPermission _selectedPermission = AppPermission.notification;
  PermissionStatusResult? _permissionStatus;
  StatusBannerType _bannerType = StatusBannerType.info;
  _UiStatePreview _uiStatePreview = _UiStatePreview.content;
  _StoryViewport _storyViewport = _StoryViewport.adaptive;
  double _textScale = 1;
  bool _forceRtlPreview = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showBottomSheetDemo(AppLocalizations l10n) {
    return AppBottomSheet.show<void>(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppText(
            l10n.uiKitBottomSheetTitle,
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppText(
            l10n.uiKitBottomSheetMessage,
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: l10n.close,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialogDemo(AppLocalizations l10n) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.uiKitConfirmActionTitle,
      message: l10n.uiKitConfirmActionMessage,
    );

    if (!mounted) return;
    getIt<ToastService>().info(confirmed ? l10n.confirm : l10n.cancel);
  }

  Future<void> _showSelectionSheetDemo(AppLocalizations l10n) async {
    final selected = await getIt<AppBottomSheetService>().showSelection<String>(
      title: l10n.uiKitSelectionSheetTitle,
      options: <BottomSheetOption<String>>[
        BottomSheetOption<String>(
          label: l10n.uiKitArchiveAction,
          value: 'archive',
          icon: Icons.archive_outlined,
        ),
        BottomSheetOption<String>(
          label: l10n.uiKitPinAction,
          value: 'pin',
          icon: Icons.push_pin_outlined,
        ),
        BottomSheetOption<String>(
          label: l10n.uiKitDeleteAction,
          value: 'delete',
          icon: Icons.delete_outline_rounded,
          destructive: true,
        ),
      ],
    );

    if (!mounted || selected == null) return;
    getIt<ToastService>().info('${l10n.uiKitSelectedPrefix}: $selected');
  }

  Future<void> _showConfirmationSheetDemo(AppLocalizations l10n) async {
    final confirmed = await getIt<AppBottomSheetService>().showConfirmation(
      title: l10n.uiKitDestructiveTitle,
      message: l10n.uiKitDestructiveMessage,
      confirmLabel: l10n.uiKitDeleteAction,
      destructive: true,
    );

    if (!mounted) return;
    if (confirmed == true) {
      getIt<ToastService>().warning(l10n.confirm);
    } else {
      getIt<ToastService>().info(l10n.cancel);
    }
  }

  Future<void> _checkPermission() async {
    final status = await getIt<PermissionService>().check(_selectedPermission);
    if (!mounted) return;

    setState(() {
      _permissionStatus = status;
      _bannerType = switch (status.status) {
        AppPermissionStatus.granted => StatusBannerType.success,
        AppPermissionStatus.denied => StatusBannerType.error,
        AppPermissionStatus.notConfigured => StatusBannerType.warning,
        AppPermissionStatus.unavailable => StatusBannerType.warning,
        AppPermissionStatus.restricted => StatusBannerType.warning,
        AppPermissionStatus.limited => StatusBannerType.info,
      };
    });
  }

  Future<void> _requestPermission(AppLocalizations l10n) async {
    final result =
        await getIt<PermissionService>().request(_selectedPermission);
    if (!mounted) return;

    setState(() {
      _permissionStatus = PermissionStatusResult(
        permission: result.permission,
        status: result.after,
        reason: result.reason,
      );
      _bannerType =
          result.granted ? StatusBannerType.success : StatusBannerType.warning;
    });

    getIt<ToastService>().info(
      '${l10n.uiKitPermissionResultPrefix}: ${result.after.name}',
    );
  }

  double? _storyMaxWidth() {
    return switch (_storyViewport) {
      _StoryViewport.adaptive => null,
      _StoryViewport.phone => 420,
      _StoryViewport.tablet => 760,
      _StoryViewport.desktop => 1180,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final baseDirection = Directionality.of(context);
    final storyDirection = _forceRtlPreview ? TextDirection.rtl : baseDirection;
    final storyMediaQuery = MediaQuery.of(context).copyWith(
      textScaler: TextScaler.linear(_textScale),
    );

    return AppScaffold(
      appBar: AppBar(
        title: AppText(
          l10n.uiKitShowcase,
          variant: AppTextVariant.titleLarge,
        ),
      ),
      scrollable: true,
      body: Directionality(
        textDirection: storyDirection,
        child: MediaQuery(
          data: storyMediaQuery,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: _storyMaxWidth() ?? double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _StorybookControlsCard(
                    viewport: _storyViewport,
                    textScale: _textScale,
                    forceRtlPreview: _forceRtlPreview,
                    viewportLabel: (viewport) => switch (viewport) {
                      _StoryViewport.adaptive => l10n.uiKitViewportAdaptive,
                      _StoryViewport.phone => l10n.uiKitViewportPhone,
                      _StoryViewport.tablet => l10n.uiKitViewportTablet,
                      _StoryViewport.desktop => l10n.uiKitViewportDesktop,
                    },
                    onViewportChanged: (viewport) {
                      setState(() {
                        _storyViewport = viewport;
                      });
                    },
                    onTextScaleChanged: (value) {
                      setState(() {
                        _textScale = value;
                      });
                    },
                    onRtlPreviewChanged: (value) {
                      setState(() {
                        _forceRtlPreview = value;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    title: l10n.uiKitLocaleSectionTitle,
                    subtitle: l10n.uiKitLocaleSectionSubtitle,
                    child: StatusBanner(
                      title: '${l10n.uiKitLocaleLabel}: ${locale.languageCode}',
                      message:
                          '${l10n.uiKitDirectionLabel}: ${storyDirection == TextDirection.rtl ? l10n.uiKitDirectionRtl : l10n.uiKitDirectionLtr}',
                      type: StatusBannerType.info,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    title: l10n.uiKitButtonsSectionTitle,
                    subtitle: l10n.uiKitButtonsSectionSubtitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        PrimaryButton(
                          label: l10n.uiKitPrimaryAction,
                          onPressed: () =>
                              getIt<ToastService>().success(l10n.confirm),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        PrimaryButton(
                          label: l10n.uiKitLoadingAction,
                          isLoading: true,
                          onPressed: null,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SecondaryButton(
                          label: l10n.uiKitSecondaryAction,
                          onPressed: () =>
                              getIt<ToastService>().info(l10n.confirm),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        DangerButton(
                          label: l10n.uiKitDeleteAction,
                          onPressed: () =>
                              getIt<ToastService>().error(l10n.confirm),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: AppSpacing.md,
                          runSpacing: AppSpacing.xs,
                          children: <Widget>[
                            TextLinkButton(
                              label: l10n.uiKitTextLinkAction,
                              onPressed: () =>
                                  getIt<ToastService>().info(l10n.confirm),
                            ),
                            IconCircleButton(
                              icon: Icons.favorite_border_rounded,
                              tooltip: l10n.uiKitLikeTooltip,
                              onPressed: () =>
                                  getIt<ToastService>().success(l10n.confirm),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    title: l10n.uiKitInputsSectionTitle,
                    subtitle: l10n.uiKitInputsSectionSubtitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AppTextField(
                          controller: _nameController,
                          labelText: l10n.uiKitNameLabel,
                          hintText: l10n.uiKitNameHint,
                          textCapitalization: TextCapitalization.words,
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppPasswordField(
                          controller: _passwordController,
                          labelText: l10n.uiKitPasswordLabel,
                          hintText: l10n.uiKitPasswordHint,
                          showPasswordLabel: l10n.uiKitShowPassword,
                          hidePasswordLabel: l10n.uiKitHidePassword,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppSearchField(
                          controller: _searchController,
                          hintText: l10n.searchHint,
                          clearTooltip: l10n.uiKitClearSearch,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppDropDownField<String>(
                          value: _selectedRole,
                          labelText: l10n.uiKitRoleLabel,
                          hintText: l10n.uiKitRoleHint,
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                              value: 'user',
                              child: Text(l10n.uiKitRoleUser),
                            ),
                            DropdownMenuItem(
                              value: 'admin',
                              child: Text(l10n.uiKitRoleAdmin),
                            ),
                            DropdownMenuItem(
                              value: 'reviewer',
                              child: Text(l10n.uiKitRoleReviewer),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    title: l10n.uiKitStatesSectionTitle,
                    subtitle: l10n.uiKitStatesSectionSubtitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Wrap(
                          spacing: AppSpacing.xs,
                          runSpacing: AppSpacing.xs,
                          children: <Widget>[
                            ChoiceChip(
                              label: Text(l10n.uiKitStateLoadingLabel),
                              selected:
                                  _uiStatePreview == _UiStatePreview.loading,
                              onSelected: (_) {
                                setState(() {
                                  _uiStatePreview = _UiStatePreview.loading;
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(l10n.uiKitStateEmptyLabel),
                              selected:
                                  _uiStatePreview == _UiStatePreview.empty,
                              onSelected: (_) {
                                setState(() {
                                  _uiStatePreview = _UiStatePreview.empty;
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(l10n.uiKitStateErrorLabel),
                              selected:
                                  _uiStatePreview == _UiStatePreview.error,
                              onSelected: (_) {
                                setState(() {
                                  _uiStatePreview = _UiStatePreview.error;
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(l10n.uiKitStateContentLabel),
                              selected:
                                  _uiStatePreview == _UiStatePreview.content,
                              onSelected: (_) {
                                setState(() {
                                  _uiStatePreview = _UiStatePreview.content;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          child: _buildStatePatternPreview(l10n),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    title: l10n.uiKitMediaSectionTitle,
                    subtitle: l10n.uiKitMediaSectionSubtitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AppText(
                          l10n.uiKitNetworkImageLabel,
                          variant: AppTextVariant.labelMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        AppNetworkImage(
                          imageUrl:
                              'https://picsum.photos/seed/ui_kit_storybook/1200/720',
                          width: double.infinity,
                          height: 160,
                          memCacheWidth: 1200,
                          memCacheHeight: 720,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppText(
                          l10n.uiKitSkeletonCardLabel,
                          variant: AppTextVariant.labelMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        const AppCardSkeleton(),
                        const SizedBox(height: AppSpacing.md),
                        AppText(
                          l10n.uiKitSkeletonListLabel,
                          variant: AppTextVariant.labelMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        const SizedBox(
                          height: 240,
                          child: AppListSkeleton(itemCount: 3),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppText(
                          l10n.uiKitSkeletonDetailsLabel,
                          variant: AppTextVariant.labelMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        const AppDetailsSkeleton(),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    title: l10n.uiKitLayoutSectionTitle,
                    subtitle: l10n.uiKitLayoutSectionSubtitle,
                    child: Column(
                      children: <Widget>[
                        AppListTile(
                          leading: const Icon(Icons.widgets_outlined),
                          title: AppText(l10n.uiKitListItemTitle),
                          subtitle: AppText(
                            l10n.uiKitListItemSubtitle,
                            variant: AppTextVariant.bodySmall,
                          ),
                          trailing: Icon(
                            Directionality.of(context) == TextDirection.rtl
                                ? Icons.chevron_left_rounded
                                : Icons.chevron_right_rounded,
                          ),
                        ),
                        const AppDivider(),
                        AppListTile(
                          leading: const Icon(Icons.palette_outlined),
                          title: AppText(l10n.uiKitThemeTokensTitle),
                          subtitle: AppText(
                            l10n.uiKitThemeTokensSubtitle,
                            variant: AppTextVariant.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    title: l10n.uiKitFeedbackSectionTitle,
                    subtitle: l10n.uiKitFeedbackSectionSubtitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        PrimaryButton(
                          label: l10n.uiKitShowToastAction,
                          onPressed: () =>
                              getIt<ToastService>().success(l10n.confirm),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SecondaryButton(
                          label: l10n.uiKitShowDialogAction,
                          onPressed: () => _showDialogDemo(l10n),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SecondaryButton(
                          label: l10n.uiKitShowBottomSheetAction,
                          onPressed: () => _showBottomSheetDemo(l10n),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SecondaryButton(
                          label: l10n.uiKitShowSelectionSheetAction,
                          onPressed: () => _showSelectionSheetDemo(l10n),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SecondaryButton(
                          label: l10n.uiKitShowConfirmationSheetAction,
                          onPressed: () => _showConfirmationSheetDemo(l10n),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SecondaryButton(
                          label: l10n.uiKitOpenBottomNavDemoAction,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => _BottomNavPreviewScreen(
                                  homeLabel: l10n.uiKitHomeTab,
                                  ordersLabel: l10n.uiKitOrdersTab,
                                  profileLabel: l10n.uiKitProfileTab,
                                  screenTitle: l10n.uiKitBottomNavTitle,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    title: l10n.uiKitStatusSectionTitle,
                    subtitle: l10n.uiKitStatusSectionSubtitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        StatusBanner(
                          title: l10n.uiKitSuccessTitle,
                          message: l10n.uiKitSuccessMessage,
                          type: StatusBannerType.success,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        StatusBanner(
                          title: l10n.uiKitWarningTitle,
                          message: l10n.uiKitWarningMessage,
                          type: StatusBannerType.warning,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        StatusBanner(
                          title: l10n.uiKitInfoTitle,
                          message: l10n.uiKitInfoMessage,
                          type: StatusBannerType.info,
                          actionLabel: l10n.uiKitLearnMoreAction,
                          onAction: () {
                            getIt<AppBottomSheetService>().showInfo(
                              title: l10n.uiKitInfoTitle,
                              message: l10n.uiKitInfoSheetMessage,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    title: l10n.uiKitPermissionsSectionTitle,
                    subtitle: l10n.uiKitPermissionsSectionSubtitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AppDropDownField<AppPermission>(
                          value: _selectedPermission,
                          labelText: l10n.uiKitPermissionLabel,
                          items: AppPermission.values
                              .map(
                                (permission) => DropdownMenuItem<AppPermission>(
                                  value: permission,
                                  child: Text(permission.name),
                                ),
                              )
                              .toList(growable: false),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedPermission = value;
                            });
                          },
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _checkPermission,
                                child: Text(l10n.uiKitCheckAction),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _requestPermission(l10n),
                                child: Text(l10n.uiKitRequestAction),
                              ),
                            ),
                          ],
                        ),
                        if (_permissionStatus != null) ...<Widget>[
                          const SizedBox(height: AppSpacing.sm),
                          StatusBanner(
                            type: _bannerType,
                            title: _permissionStatus!.status.name,
                            message: _permissionStatus!.reason ??
                                l10n.uiKitNoDetails,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatePatternPreview(AppLocalizations l10n) {
    return SizedBox(
      key: ValueKey<_UiStatePreview>(_uiStatePreview),
      height: 220,
      child: ScreenStateLayout(
        isLoading: _uiStatePreview == _UiStatePreview.loading,
        isEmpty: _uiStatePreview == _UiStatePreview.empty,
        errorMessage: _uiStatePreview == _UiStatePreview.error
            ? l10n.errorGenericMessage
            : null,
        onRetry: () {},
        emptyTitle: l10n.noItemsTitle,
        emptyDescription: l10n.noItemsDescription,
        emptyPrimaryActionLabel: l10n.retry,
        onEmptyPrimaryAction: () {},
        child: Card(
          child: Center(
            child: AppText(
              l10n.uiKitStateContentMessage,
              variant: AppTextVariant.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _StorybookControlsCard extends StatelessWidget {
  const _StorybookControlsCard({
    required this.viewport,
    required this.textScale,
    required this.forceRtlPreview,
    required this.viewportLabel,
    required this.onViewportChanged,
    required this.onTextScaleChanged,
    required this.onRtlPreviewChanged,
  });

  final _StoryViewport viewport;
  final double textScale;
  final bool forceRtlPreview;
  final String Function(_StoryViewport viewport) viewportLabel;
  final ValueChanged<_StoryViewport> onViewportChanged;
  final ValueChanged<double> onTextScaleChanged;
  final ValueChanged<bool> onRtlPreviewChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppSectionCard(
      title: l10n.uiKitStorybookControlsTitle,
      subtitle: l10n.uiKitStorybookControlsSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppText(
            l10n.uiKitViewportLabel,
            variant: AppTextVariant.labelMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: _StoryViewport.values.map((item) {
              return ChoiceChip(
                selected: viewport == item,
                label: Text(viewportLabel(item)),
                onSelected: (_) => onViewportChanged(item),
              );
            }).toList(growable: false),
          ),
          const SizedBox(height: AppSpacing.md),
          AppText(
            '${l10n.uiKitTextScaleLabel}: ${textScale.toStringAsFixed(2)}x',
            variant: AppTextVariant.labelMedium,
          ),
          Slider(
            value: textScale,
            min: 0.9,
            max: 1.4,
            divisions: 5,
            onChanged: onTextScaleChanged,
          ),
          SwitchListTile.adaptive(
            value: forceRtlPreview,
            contentPadding: EdgeInsets.zero,
            onChanged: onRtlPreviewChanged,
            title: AppText(
              l10n.uiKitRtlPreviewLabel,
              variant: AppTextVariant.titleSmall,
            ),
            subtitle: AppText(
              l10n.uiKitRtlPreviewHelp,
              variant: AppTextVariant.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavPreviewScreen extends StatelessWidget {
  const _BottomNavPreviewScreen({
    required this.homeLabel,
    required this.ordersLabel,
    required this.profileLabel,
    required this.screenTitle,
  });

  final String homeLabel;
  final String ordersLabel;
  final String profileLabel;
  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return AppBottomNavTemplate(
      appBar: AppBar(title: Text(screenTitle)),
      items: <BottomNavItem>[
        BottomNavItem(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home_rounded),
          label: homeLabel,
          page: Center(child: Text(homeLabel)),
        ),
        BottomNavItem(
          icon: const Icon(Icons.receipt_long_outlined),
          selectedIcon: const Icon(Icons.receipt_long_rounded),
          label: ordersLabel,
          page: Center(child: Text(ordersLabel)),
        ),
        BottomNavItem(
          icon: const Icon(Icons.person_outline_rounded),
          selectedIcon: const Icon(Icons.person_rounded),
          label: profileLabel,
          page: Center(child: Text(profileLabel)),
        ),
      ],
    );
  }
}
