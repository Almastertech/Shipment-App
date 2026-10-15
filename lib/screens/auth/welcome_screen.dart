import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../core/session/session_manager.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.semantic;
    final primary = AppColors.primitives.primary;

    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: colors.background.primary,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.tokenM,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset(
                      AppImages.svg('Logo.svg'),
                      width: 100,
                      height: 100,
                      semanticsLabel: l10n.appTitle,
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    AppText.localized(
                      (strings) => strings.welcomeTitle,
                      variant: AppTextVariant.headlineMedium,
                      textAlign: TextAlign.center,
                      style: AppTypography.buyerMobile.h2.toTextStyle(
                        color: primary.shade500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenM),
                    AppText.localized(
                      (strings) => strings.welcomeDescription,
                      variant: AppTextVariant.bodyLarge,
                      textAlign: TextAlign.center,
                      style: AppTypography.buyerMobile.bodyLarge.toTextStyle(
                        color: colors.text.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.tokenM,
              AppSpacing.tokenM,
              AppSpacing.tokenM,
              AppSpacing.tokenM,
            ),
            child: PrimaryButton(
              label: l10n.welcomeContinue,
              onPressed: () async {
                await getIt<SessionManager>().startGuestSession();
                if (context.mounted) context.go(AppRoutes.home);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: primary.shade500,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                ),
                textStyle: AppTypography.buyerMobile.button.toTextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
