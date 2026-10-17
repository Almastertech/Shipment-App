import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';

class OtpSuccessScreen extends StatefulWidget {
  const OtpSuccessScreen({super.key, this.onComplete});

  /// Called after the three-second success transition completes.
  final VoidCallback? onComplete;

  @override
  State<OtpSuccessScreen> createState() => _OtpSuccessScreenState();
}

class _OtpSuccessScreenState extends State<OtpSuccessScreen>
    with TickerProviderStateMixin {
  late final AnimationController _circleController;
  late final AnimationController _progressController;
  Timer? _completionTimer;

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    _completionTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _completionTimer?.cancel();
    _circleController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final yellow = AppColors.primitives.accent01.shade300;

    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: primary.shade900,
      body: Stack(
        children: [
          PositionedDirectional(
            top: 80,
            end: 38,
            child: Transform.rotate(
              angle: .785,
              child: Container(width: 18, height: 18, color: primary.shade500),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _circleController,
                    curve: Curves.easeOutBack,
                  ),
                  child: Container(
                    width: 140,
                    height: 140,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: yellow.withValues(alpha: .18),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: yellow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        color: primary.shade900,
                        size: 52,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenL),
                AppText.localized(
                  (l10n) => l10n.otpSuccessTitle,
                  variant: AppTextVariant.headlineMedium,
                  textAlign: TextAlign.center,
                  style: AppTypography.buyerMobile.h2.toTextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenS),
                AppText.localized(
                  (l10n) => l10n.otpSuccessMessage,
                  variant: AppTextVariant.bodyMedium,
                  textAlign: TextAlign.center,
                  style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                    color: AppColors.primitives.neutral.shade300,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenL),
                SizedBox(
                  width: 96,
                  height: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) => LinearProgressIndicator(
                        value: _progressController.value,
                        backgroundColor: AppColors.primitives.neutral.shade700,
                        color: yellow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
