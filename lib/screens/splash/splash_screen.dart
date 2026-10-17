import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/screens/splash/widgets/shipments_mark.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/startup/startup_flow.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _logoController;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    _bootstrap();
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(milliseconds: 3500));
    if (!mounted) return;
    context.go(getIt<StartupFlow>().resolveInitialRoute());
  }

  @override
  Widget build(BuildContext context) {
    final purple = AppColors.primitives.primary;
    final yellow = AppColors.primitives.accent01.shade300;
    final l10n = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: AppScaffold(
        backgroundColor: purple.shade900,
        padding: EdgeInsets.zero,
        safeArea: false,
        dismissKeyboardOnTap: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppImages.splash,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    purple.shade900.withValues(alpha: .48),
                    purple.shade900.withValues(alpha: .60),
                    purple.shade900.withValues(alpha: .84),
                  ],
                  stops: const [0, .48, 1],
                ),
              ),
            ),
            SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: Transform.translate(
                      offset: const Offset(0, -12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ShipmentsMark(animation: _logoController),
                          const SizedBox(height: AppSpacing.tokenM),
                          AppText(
                            l10n.splashBrand,
                            variant: AppTextVariant.headlineLarge,
                            textAlign: TextAlign.center,
                            style: AppTypography.buyerMobile.h1.toTextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.tokenM),
                          AppText(
                            l10n.splashTagline,
                            variant: AppTextVariant.bodyMedium,
                            textAlign: TextAlign.center,
                            style: AppTypography.buyerMobile.label.toTextStyle(
                              color: yellow,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.tokenM),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var index = 0; index < 9; index++)
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: AppSpacing.tokenXs,
                                  ),
                                  child: Transform.rotate(
                                    angle: .785,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      color: index.isEven
                                          ? yellow
                                          : AppColors
                                              .primitives.neutral.shade400,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    start: AppSpacing.tokenL,
                    end: AppSpacing.tokenL,
                    bottom: AppSpacing.tokenL,
                    child: FadeTransition(
                      opacity: _logoController,
                      child: AppText(
                        l10n.splashFooter,
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.center,
                        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                          color: AppColors.primitives.neutral.shade200,
                        ),
                      ),
                    ),
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
