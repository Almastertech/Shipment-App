import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/screens/splash/widgets/shipments_mark.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/startup/startup_flow.dart';
import '../../injection.dart';

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
    const foreground = Color(0xFFFFFFFF);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: purple.shade900,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: purple.shade900,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: AppScaffold(
        backgroundColor: purple.shade900,
        padding: EdgeInsets.zero,
        dismissKeyboardOnTap: false,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [purple.shade800, purple.shade900],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShipmentsMark(animation: _logoController),
                const SizedBox(height: AppSpacing.tokenM),
                AppText(
                  'حصين',
                  variant: AppTextVariant.headlineLarge,
                  style: AppTypography.buyerMobile.display.toTextStyle(
                    color: foreground,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.tokenS),
                FadeTransition(
                  opacity: _logoController,
                  child: AppText(
                    'منتجاتك.. في أيدٍ آمنة',
                    variant: AppTextVariant.bodyLarge,
                    style: AppTypography.buyerMobile.bodyLarge.toTextStyle(
                      color: foreground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
