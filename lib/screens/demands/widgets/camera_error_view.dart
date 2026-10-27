import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class CameraErrorView extends StatelessWidget {
  const CameraErrorView({
    super.key,
    required this.error,
    required this.onRetry,
    required this.onOpenSettings,
    this.accentColor = const Color(0xFFFFD34D),
    this.backgroundColor = const Color(0xFF202330),
  });

  final String? error;
  final VoidCallback onRetry;
  final VoidCallback onOpenSettings;
  final Color accentColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final denied = error?.toLowerCase().contains('denied') ?? false;

    return ColoredBox(
      color: backgroundColor.withValues(alpha: 0.96),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.no_photography_outlined,
                color: accentColor,
                size: 48,
              ),
              const SizedBox(height: 20),
              Text(
                denied
                    ? l10n.cameraPermissionDeniedDescription
                    : l10n.cameraCaptureError,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, height: 1.5),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: denied ? onOpenSettings : onRetry,
                child: Text(
                  denied
                      ? l10n.cameraPermissionOpenSettings
                      : l10n.cameraRetry,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
