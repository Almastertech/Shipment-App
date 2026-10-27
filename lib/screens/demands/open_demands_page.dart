import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/layout/app_bottom_sheet.dart';
import '../../core/location/location_service.dart';
import '../../core/permissions/app_permission.dart';
import '../../core/permissions/permission_service.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/claim_location_header.dart';
import 'widgets/demand_loading_state.dart';
import 'widgets/location_benefits_section.dart';
import 'widgets/location_bottom_actions.dart';
import 'widgets/location_illustration.dart';
import 'widgets/skipped_location_warning_sheet.dart';

class OpenDemandsPage extends StatefulWidget {
  const OpenDemandsPage({
    super.key,
    required this.permissionService,
    required this.locationService,
  });

  final PermissionService permissionService;
  final LocationService locationService;

  @override
  State<OpenDemandsPage> createState() => _OpenDemandsPageState();
}

class _OpenDemandsPageState extends State<OpenDemandsPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _shadowController;
  late final Animation<double> _shadowProgress;
  bool _isRequestingLocation = false;
  Completer<void>? _settingsResumeCompleter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _shadowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _shadowProgress = CurvedAnimation(
      parent: _shadowController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    final resumeCompleter = _settingsResumeCompleter;
    if (resumeCompleter != null && !resumeCompleter.isCompleted) {
      resumeCompleter.complete();
    }
    _shadowController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final completer = _settingsResumeCompleter;
      _settingsResumeCompleter = null;
      if (completer != null && !completer.isCompleted) {
        completer.complete();
      }
    }
  }

  Future<bool> _ensureLocationServicesEnabled() async {
    if (await widget.locationService.isLocationServiceEnabled()) return true;

    final resumeCompleter = Completer<void>();
    _settingsResumeCompleter = resumeCompleter;
    final opened = await widget.locationService.openLocationSettings();
    if (!opened) {
      _settingsResumeCompleter = null;
      return false;
    }

    await resumeCompleter.future;
    return widget.locationService.isLocationServiceEnabled();
  }

  Future<void> _requestLocation() async {
    if (_isRequestingLocation) return;
    setState(() => _isRequestingLocation = true);
    var shouldShowSkippedWarning = false;

    try {
      final result = await widget.permissionService.request(
        AppPermission.location,
      );
      if (!mounted) return;
      if (result.granted) {
        final servicesEnabled = await _ensureLocationServicesEnabled();
        if (!mounted) return;
        if (!servicesEnabled) {
          shouldShowSkippedWarning = true;
        } else {
          final location = await widget.locationService.getCurrentLocation();
          if (!mounted) return;
          await context.push<void>(AppRoutes.demandDetails, extra: location);
        }
      } else {
        shouldShowSkippedWarning = true;
      }
    } catch (_) {
      shouldShowSkippedWarning = true;
    } finally {
      if (mounted) setState(() => _isRequestingLocation = false);
    }

    if (shouldShowSkippedWarning && mounted) {
      await _showSkippedLocationWarning();
    }
  }

  Future<void> _showSkippedLocationWarning() async {
    final l10n = AppLocalizations.of(context)!;
    const colors = AppColors.primitives;
    final action = await AppBottomSheet.show<_SkippedLocationAction>(
      context,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.tokenXl,
        AppSpacing.tokenM,
        AppSpacing.tokenXl,
        AppSpacing.tokenL,
      ),
      child: SkippedLocationWarningSheet(
        title: l10n.openDemandsSkippedWarningTitle,
        description: l10n.openDemandsSkippedWarningDescription,
        allowLocationLabel: l10n.openDemandsAllowLocation,
        continueWithoutLocationLabel: l10n.openDemandsContinueWithoutLocation,
        onAllowLocation: () => Navigator.of(context).pop(
          _SkippedLocationAction.allowLocation,
        ),
        onContinueWithoutLocation: () => Navigator.of(context).pop(
          _SkippedLocationAction.continueWithoutLocation,
        ),
        colors: colors,
      ),
    );

    if (!mounted) return;
    if (action == _SkippedLocationAction.allowLocation) {
      await _requestLocation();
    } else if (action == _SkippedLocationAction.continueWithoutLocation) {
      await context.push<void>(AppRoutes.demandDetails, extra: true);
    }
  }

  void _onBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.shipments);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final heroHeight = (width * .8).clamp(300.0, 350.0);
    const locationCardHeight = 205.0;
    const locationCardOverlap = 24.0;
    final introHeight = heroHeight + locationCardHeight - locationCardOverlap;

    final content = AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.semantic.background.primary,
      safeArea: false,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: introHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        PositionedDirectional(
                          top: 0,
                          start: 0,
                          end: 0,
                          height: heroHeight,
                          child: ClaimLocationHeader(
                            title: l10n.openDemandsTitle,
                            heading: l10n.openDemandsLocationHeading,
                            description: l10n.openDemandsLocationDescription,
                            steps: <String>[
                              l10n.openDemandsStepLocation,
                              l10n.openDemandsStepEvidence,
                              l10n.openDemandsStepReview,
                            ],
                            onBack: _onBack,
                            backTooltip: l10n.navigationBack,
                          ),
                        ),
                        PositionedDirectional(
                          top: heroHeight - locationCardOverlap,
                          start: AppSpacing.tokenM,
                          end: AppSpacing.tokenM,
                          height: locationCardHeight,
                          child: LocationIllustration(
                            shadowProgress: _shadowProgress,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.tokenXl,
                      AppSpacing.tokenL,
                      AppSpacing.tokenXl,
                      AppSpacing.tokenM,
                    ),
                    child: LocationBenefitsSection(
                      heading: l10n.openDemandsWhyLocationHeading,
                      benefits: <String>[
                        l10n.openDemandsLocationBenefitOne,
                        l10n.openDemandsLocationBenefitTwo,
                        l10n.openDemandsLocationBenefitThree,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          LocationBottomActions(
            allowLocationLabel: l10n.openDemandsAllowLocation,
            notNowLabel: l10n.openDemandsNotNow,
            onAllowLocation: _requestLocation,
            onNotNow: _showSkippedLocationWarning,
            isLoading: _isRequestingLocation,
          ),
        ],
      ),
    );

    return DemandLoadingState(
      isLoading: _isRequestingLocation,
      loadingLabel: l10n.loading,
      child: content,
    );
  }
}

enum _SkippedLocationAction { allowLocation, continueWithoutLocation }
