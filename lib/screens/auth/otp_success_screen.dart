import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
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
  Timer? _completionTimer;

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _completionTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _completionTimer?.cancel();
    _circleController.dispose();
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
          Positioned.fill(
            child: Image.asset(
              AppImages.splash,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Positioned.fill(
            child: ColoredBox(color: primary.shade900.withValues(alpha: .78)),
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
                  child: SizedBox.square(
                    dimension: 176,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 176,
                          height: 176,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .08),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 146,
                          height: 146,
                          decoration: BoxDecoration(
                            color: yellow.withValues(alpha: .2),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 112,
                          height: 112,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: yellow,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: primary.shade900,
                            size: 54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xl),
                AppText.localized(
                  (l10n) => l10n.otpSuccessTitle,
                  variant: AppTextVariant.headlineMedium,
                  textAlign: TextAlign.center,
                  style: AppTypography.buyerMobile.h2.toTextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText.localized(
                  (l10n) => l10n.otpSuccessMessage,
                  variant: AppTextVariant.bodyMedium,
                  textAlign: TextAlign.center,
                  style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                    color: AppColors.primitives.neutral.shade300,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenL),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final color in [
                      yellow,
                      AppColors.primitives.neutral.shade400,
                      yellow,
                      AppColors.primitives.neutral.shade400,
                      yellow,
                      AppColors.primitives.neutral.shade400,
                      yellow,
                    ])
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: AppSpacing.tokenS,
                        ),
                        child: Transform.rotate(
                          angle: .785,
                          child: Container(width: 8, height: 8, color: color),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.token5Xl),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0; index < 3; index++)
                      Container(
                        width: 9,
                        height: 9,
                        margin: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpacing.tokenXs,
                        ),
                        decoration: BoxDecoration(
                          color: index == 0
                              ? yellow
                              : AppColors.primitives.neutral.shade500,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
