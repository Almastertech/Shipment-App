import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/secondary_button.dart';
import '../../core/camera/camera_capture_service.dart';
import '../../core/permissions/permission_service.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../l10n/app_localizations.dart';

/// Kept as a route fallback. The demand flow opens [CameraPermissionSheet]
/// over the evidence page so the permission prompt feels attached to the action.
class CameraPermissionPage extends StatelessWidget {
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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.tokenL),
              child: CameraPermissionSheet(
                cameraCaptureService: cameraCaptureService,
                permissionService: permissionService,
              ),
            ),
          ),
        ),
      );
}

class CameraPermissionSheet extends StatefulWidget {
  const CameraPermissionSheet({
    super.key,
    required this.cameraCaptureService,
    required this.permissionService,
  });

  final CameraCaptureService cameraCaptureService;
  final PermissionService permissionService;

  @override
  State<CameraPermissionSheet> createState() => _CameraPermissionSheetState();
}

class _CameraPermissionSheetState extends State<CameraPermissionSheet>
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
      if (mounted) Navigator.of(context).pop<bool>(granted);
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
    final colors = AppColors.semantic;
    final description = _cameraPermissionDenied
        ? l10n.cameraPermissionDeniedDescription
        : _cameraUnavailable
            ? l10n.cameraCaptureFailedDescription
            : l10n.cameraPermissionDescription;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primitives.primary.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 32,
              color: AppColors.primitives.primary.shade500,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.tokenM),
        AppText(
          l10n.cameraPermissionHeading,
          variant: AppTextVariant.headlineSmall,
          textAlign: TextAlign.center,
          style: AppTypography.buyerMobile.h3.toTextStyle(
            color: colors.text.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.tokenS),
        AppText(
          description,
          variant: AppTextVariant.bodyMedium,
          textAlign: TextAlign.center,
          style: AppTypography.buyerMobile.bodySmall.toTextStyle(
            color: colors.text.secondary,
          ),
        ),
        const SizedBox(height: AppSpacing.tokenXl),
        PrimaryButton(
          label: _cameraPermissionDenied
              ? l10n.cameraPermissionOpenSettings
              : l10n.cameraPermissionAllow,
          onPressed: _onPrimaryAction,
          isLoading: _isOpeningCamera,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: const StadiumBorder(),
            textStyle: AppTypography.buyerMobile.button.toTextStyle(),
          ),
        ),
        const SizedBox(height: AppSpacing.tokenS),
        SecondaryButton(
          label: l10n.cameraPermissionNotNow,
          onPressed: () => Navigator.of(context).pop<bool>(false),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            foregroundColor: colors.text.primary,
            side: BorderSide(color: colors.border.secondary),
            shape: const StadiumBorder(),
            textStyle: AppTypography.buyerMobile.button.toTextStyle(),
          ),
        ),
      ],
    );
  }
}
