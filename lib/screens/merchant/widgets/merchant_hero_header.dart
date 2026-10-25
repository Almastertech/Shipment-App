import 'package:flutter/material.dart';
import 'package:shipments/features/notifications/presentation/notification_bell_button.dart';
import 'package:shipments/screens/shipments/widgets/shipments_dot_marks.dart';

import '../../../components/app_text.dart';
import '../../../components/inputs/app_text_field.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class MerchantHeroHeader extends StatelessWidget {
  const MerchantHeroHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.searchHint,
  });

  final String title;
  final String subtitle;
  final String searchHint;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary.shade700;
    return SizedBox(
      height: 482,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(AppImages.merchantHero, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  primary.withValues(alpha: .63),
                  primary.withValues(alpha: .75),
                  primary.withValues(alpha: .94),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.appPageMargin,
              MediaQuery.paddingOf(context).top + AppSpacing.tokenL,
              AppSpacing.appPageMargin,
              AppSpacing.tokenXl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: Directionality.of(context) == TextDirection.ltr
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .16),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .48),
                      ),
                    ),
                    child: const SizedBox(
                      width: 44,
                      height: 44,
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.white,
                          size: 21,
                        ),
                        child: NotificationBellButton(),
                      ),
                    ),
                  ),
                ),
                const Row(
                  children: <Widget>[
                    ShipmentDotsMark(),
                  ],
                ),
                // Keep the hero copy above the overlapping trust card. A flex
                // spacer pushed it to the bottom of the header, where the card
                // covered the title and subtitle on phone-sized layouts.
                const SizedBox(height: AppSpacing.token4Xl),
                AppText(
                  title,
                  variant: AppTextVariant.headlineLarge,
                  textAlign: TextAlign.start,
                  style: AppTypography.buyerMobile.h1.toTextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  subtitle,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Color(0xFFEAE7FA)),
                  maxLines: 2,
                ),
                const SizedBox(height: AppSpacing.tokenS),
                Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme:
                        Theme.of(context).inputDecorationTheme.copyWith(
                              filled: false,
                              fillColor: Colors.transparent,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.tokenM,
                              ),
                              hintStyle: const TextStyle(color: Colors.white70),
                              prefixIconColor: Colors.white,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                  ),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .19),
                      borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: AppTextField(
                      hintText: searchHint,
                      textInputAction: TextInputAction.search,
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 23,
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
