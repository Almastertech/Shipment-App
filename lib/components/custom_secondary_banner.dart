import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_text.dart';
import 'buttons/primary_button.dart';

class CustomSecondaryBanner extends StatelessWidget {
  const CustomSecondaryBanner({
    super.key,
    required this.onBlogTap,
    this.eyebrow = 'كيف تعمل الحماية؟',
    this.title = 'تعرف على حماية حصين',
    this.description = 'تغطية للتلف والفقدان والتأخير في شحنات التاجر المؤهلة.',
    this.blogLabel = 'زيارة المدونة',
  });

  final VoidCallback onBlogTap;
  final String eyebrow;
  final String title;
  final String description;
  final String blogLabel;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.primitives.accent01.shade500;
    final white = AppColors.semantic.text.inverse;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height =
            (constraints.maxWidth * 0.45).clamp(180.0, 220.0).toDouble();

        return ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.token2Xl),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  AppImages.secondaryBannerBackground,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.high,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.centerEnd,
                      end: AlignmentDirectional.centerStart,
                      colors: <Color>[
                        Colors.black.withValues(alpha: 0.12),
                        Colors.black.withValues(alpha: 0.30),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.tokenM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppText(
                        eyebrow,
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                          color: accent,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.tokenXs),
                      AppText(
                        title,
                        variant: AppTextVariant.titleLarge,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.h4.toTextStyle(
                          color: white,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.tokenXs),
                      AppText(
                        description,
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                          color: white.withValues(alpha: 0.78),
                        ),
                      ),
                      const Spacer(),
                      PrimaryButton(
                        label: blogLabel,
                        onPressed: onBlogTap,
                        fullWidth: false,
                        iconOnTrailing: true,
                        icon: Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: accent,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: accent,
                          disabledBackgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
