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

    final initialRoute = getIt<StartupFlow>().resolveInitialRoute();
    context.go(initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.primitives.primary.shade500;
    final foregroundColor = AppColors.primitives.neutral.shade100;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: backgroundColor,
      ),
      child: AppScaffold(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.zero,
        dismissKeyboardOnTap: false,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ShipmentsMark(animation: _logoController),
              const SizedBox(height: AppSpacing.tokenM),
              AnimatedBuilder(
                animation: _logoController,
                builder: (context, child) {
                  final progress = Curves.easeOutCubic.transform(
                    (_logoController.value / 0.2).clamp(0.0, 1.0),
                  );

                  return Transform.translate(
                    offset: Offset(-3 * (1 - progress), 0),
                    child: child,
                  );
                },
                child: AppText(
                  'حصين',
                  variant: AppTextVariant.headlineLarge,
                  style: AppTypography.buyerMobile.display.toTextStyle(
                    color: foregroundColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.tokenS),
              Semantics(
                label: 'منتجاتك.. في أيد أمينة',
                child: FadeTransition(
                  opacity: _logoController,
                  child: AppText(
                    'منتجاتك.. في أيد أمينة',
                    variant: AppTextVariant.bodyLarge,
                    style: AppTypography.buyerMobile.bodyLarge.toTextStyle(
                      color: foregroundColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


