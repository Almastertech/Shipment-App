import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../core/camera/camera_capture_service.dart';
import '../../core/permissions/permission_service.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../l10n/app_localizations.dart';

class CameraPermissionPage extends StatefulWidget {
  const CameraPermissionPage({
    super.key,
    required this.cameraCaptureService,
    required this.permissionService,
    this.mediaType = CameraMediaType.photo,
  });

  final CameraCaptureService cameraCaptureService;
  final PermissionService permissionService;
  final CameraMediaType mediaType;

  @override
  State<CameraPermissionPage> createState() => _CameraPermissionPageState();
}

class _CameraPermissionPageState extends State<CameraPermissionPage>
    with WidgetsBindingObserver {
  bool _isOpeningCamera = false;
  bool _cameraPermissionDenied = false;
  bool _cameraUnavailable = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _cameraPermissionDenied) {
      setState(() => _cameraPermissionDenied = false);
    }
  }

  Future<void> _onPrimaryAction() async {
    if (_cameraPermissionDenied) {
      await widget.permissionService.openAppSettings();
      return;
    }

    if (_isOpeningCamera) return;
    setState(() => _isOpeningCamera = true);

    try {
      final granted = await widget.cameraCaptureService.requestCameraAccess();
      if (mounted) context.pop<bool>(granted);
    } on CameraException catch (error) {
      if (!mounted) return;
      setState(() {
        _cameraPermissionDenied = error.code.toLowerCase().contains('denied');
        _cameraUnavailable = !_cameraPermissionDenied;
      });
    } on PlatformException catch (error) {
      if (!mounted) return;
      setState(() {
        _cameraPermissionDenied = error.code.toLowerCase().contains('denied');
        _cameraUnavailable = !_cameraPermissionDenied;
      });
    } catch (_) {
      if (mounted) setState(() => _cameraUnavailable = true);
    } finally {
      if (mounted) setState(() => _isOpeningCamera = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const backgroundColor = Color(0xFF202330);
    const iconTileColor = Color(0xFF2B2E3A);
    const accentColor = Color(0xFFE8F9A7);
    const textColor = Color(0xFFF9FAFA);
    const secondaryTextColor = Color(0xFFB1B2B7);

    final description = _cameraPermissionDenied
        ? l10n.cameraPermissionDeniedDescription
        : _cameraUnavailable
            ? l10n.cameraCaptureFailedDescription
            : l10n.cameraPermissionDescription;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.tokenM,
            AppSpacing.tokenM,
            AppSpacing.tokenM,
            AppSpacing.tokenL,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: iconTileColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppRadius.token2Xl),
                          ),
                        ),
                        child: SizedBox(
                          width: 96,
                          height: 96,
                          child: Icon(
                            Icons.no_photography_outlined,
                            size: 40,
                            color: accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.tokenM),
                      AppText(
                        l10n.cameraPermissionHeading,
                        variant: AppTextVariant.headlineSmall,
                        textAlign: TextAlign.center,
                        style: AppTypography.buyerMobile.h3.toTextStyle(
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.tokenS),
                      AppText(
                        description,
                        variant: AppTextVariant.bodyMedium,
                        textAlign: TextAlign.center,
                        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.token2Xl),
              PrimaryButton(
                label: _cameraPermissionDenied
                    ? l10n.cameraPermissionOpenSettings
                    : l10n.cameraPermissionAllow,
                onPressed: _onPrimaryAction,
                isLoading: _isOpeningCamera,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: backgroundColor,
                  disabledBackgroundColor: accentColor.withValues(alpha: 0.7),
                  elevation: 0,
                  minimumSize: const Size.fromHeight(52),
                  shape: const StadiumBorder(),
                  textStyle: AppTypography.buyerMobile.button.toTextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
