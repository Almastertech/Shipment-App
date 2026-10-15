import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/screens/demands/widgets/demand_progress.dart';
import 'package:shipments/screens/demands/widgets/location_illustration.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../core/location/location_service.dart';
import '../../core/permissions/app_permission.dart';
import '../../core/permissions/permission_service.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';

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
  bool _locationDeclined = false;
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

    try {
      final result = await widget.permissionService.request(
        AppPermission.location,
      );
      if (!mounted) return;
      if (result.granted) {
        final servicesEnabled = await _ensureLocationServicesEnabled();
        if (!mounted) return;
        if (!servicesEnabled) {
          setState(() => _locationDeclined = true);
          return;
        }

        final location = await widget.locationService.getCurrentLocation();
        if (!mounted) return;
        await context.push<void>(AppRoutes.demandDetails, extra: location);
      } else {
        setState(() => _locationDeclined = true);
      }
    } catch (_) {
      if (mounted) setState(() => _locationDeclined = true);
    } finally {
      if (mounted) setState(() => _isRequestingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const colors = AppColors.primitives;

    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.semantic.background.primary,
      safeAreaBottom: true,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenM,
              AppSpacing.tokenS,
              AppSpacing.tokenM,
              0,
            ),
            child: SizedBox(
              height: 48,
              child: Row(
                children: <Widget>[
                  Material(
                    color: colors.neutral.shade200,
                    shape: const CircleBorder(),
                    child: IconButton(
                      tooltip: l10n.navigationBack,
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        color: colors.primary.shade500,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.tokenS),
                  AppText(
                    l10n.openDemandsTitle,
                    variant: AppTextVariant.titleLarge,
                    style: AppTypography.buyerMobile.h4.toTextStyle(
                      color: colors.primary.shade500,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenM,
              AppSpacing.tokenM,
              AppSpacing.tokenM,
              0,
            ),
            child: DemandProgress(
              steps: <String>[
                l10n.openDemandsStepLocation,
                l10n.openDemandsStepEvidence,
                l10n.openDemandsStepReview,
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final illustrationSize =
                    (constraints.maxWidth - AppSpacing.token3Xl)
                        .clamp(220.0, 300.0);
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Align(
                          alignment: const Alignment(0, -0.45),
                          child: LocationIllustration(
                            size: illustrationSize.toDouble(),
                            shadowProgress: _shadowProgress,
                            locationDisabled: _locationDeclined,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.tokenM,
                        0,
                        AppSpacing.tokenM,
                        AppSpacing.tokenM,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: _locationDeclined
                                    ? colors.neutral.shade200
                                    : colors.primary.shade200,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.tokenFull,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.tokenS,
                                  vertical: AppSpacing.tokenXs,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      _locationDeclined
                                          ? Icons.location_off_outlined
                                          : Icons.my_location_rounded,
                                      size: 14,
                                      color: _locationDeclined
                                          ? colors.neutral.shade400
                                          : colors.primary.shade500,
                                    ),
                                    const SizedBox(
                                      width: AppSpacing.tokenXs,
                                    ),
                                    AppText(
                                      _locationDeclined
                                          ? l10n
                                              .openDemandsLocationDisabledBadge
                                          : l10n.openDemandsLocationBadge,
                                      variant: AppTextVariant.labelSmall,
                                      style: AppTypography.buyerMobile.caption
                                          .toTextStyle(
                                        color: _locationDeclined
                                            ? colors.neutral.shade400
                                            : colors.primary.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.tokenS),
                          AppText(
                            _locationDeclined
                                ? l10n.openDemandsLocationDeclinedHeading
                                : l10n.openDemandsLocationHeading,
                            variant: AppTextVariant.headlineSmall,
                            textAlign: TextAlign.end,
                            style: AppTypography.buyerMobile.h2.toTextStyle(
                              color: colors.primary.shade500,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.tokenXs),
                          AppText(
                            _locationDeclined
                                ? l10n.openDemandsLocationDeclinedDescription
                                : l10n.openDemandsLocationDescription,
                            variant: AppTextVariant.bodyMedium,
                            textAlign: TextAlign.end,
                            style: AppTypography.buyerMobile.bodySmall
                                .toTextStyle(color: colors.neutral.shade400),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenM,
              0,
              AppSpacing.tokenM,
              AppSpacing.tokenS,
            ),
            child: Column(
              children: <Widget>[
                PrimaryButton(
                  label: l10n.openDemandsAllowLocation,
                  onPressed: _requestLocation,
                  isLoading: _isRequestingLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary.shade500,
                    foregroundColor: colors.neutral.shade100,
                    disabledBackgroundColor: colors.primary.shade400,
                    elevation: 0,
                    minimumSize: const Size.fromHeight(52),
                    shape: const StadiumBorder(),
                    textStyle: AppTypography.buyerMobile.button.toTextStyle(),
                  ),
                ),
                if (_locationDeclined)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.tokenXs),
                    child: PrimaryButton(
                      label: l10n.openDemandsContinueWithoutLocation,
                      onPressed: () => context.push<void>(
                        AppRoutes.demandDetails,
                        extra: true,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.neutral.shade200,
                        foregroundColor: colors.neutral.shade400,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(52),
                        shape: const StadiumBorder(),
                        textStyle:
                            AppTypography.buyerMobile.button.toTextStyle(),
                      ),
                    ),
                  )
                else
                  TextButton(
                    onPressed: () => setState(() => _locationDeclined = true),
                    style: TextButton.styleFrom(
                      foregroundColor: colors.neutral.shade400,
                      textStyle: AppTypography.buyerMobile.label.toTextStyle(),
                    ),
                    child: Text(l10n.openDemandsNotNow),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
