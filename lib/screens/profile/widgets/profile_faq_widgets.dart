import 'package:flutter/material.dart';

import '../../../components/app_card.dart';
import '../../../components/app_text.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ProfileFaqCategoryChip extends StatelessWidget {
  const ProfileFaqCategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Material(
      color: selected ? colors.accent01.shade300 : Colors.white,
      shape: StadiumBorder(
        side: BorderSide(
          color: selected ? Colors.transparent : colors.neutral.shade300,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.tokenL,
            vertical: AppSpacing.tokenS,
          ),
          child: AppText(
            label,
            variant: AppTextVariant.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: AppTypography.buyerMobile.labelSmall
                .toTextStyle(
                  color: colors.neutral.shade900,
                )
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class ProfileFaqQuestionCard extends StatelessWidget {
  const ProfileFaqQuestionCard({
    super.key,
    required this.question,
    required this.answer,
    required this.steps,
    this.note,
    required this.expanded,
    required this.onTap,
  });

  final String question;
  final String answer;
  final List<String> steps;
  final String? note;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Stack(
      children: <Widget>[
        AppCard(
          padding: EdgeInsets.zero,
          color: AppColors.semantic.surface.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.tokenL),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: colors.neutral.shade200,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          expanded ? Icons.remove_rounded : Icons.add_rounded,
                          color: expanded
                              ? colors.primary.shade500
                              : colors.neutral.shade700,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenM),
                      Expanded(
                        child: AppText(
                          question,
                          variant: AppTextVariant.bodyMedium,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: AppTypography.buyerMobile.bodyMedium
                              .toTextStyle(
                                color: colors.neutral.shade900,
                              )
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (expanded)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.tokenL,
                    AppSpacing.tokenS,
                    AppSpacing.tokenL,
                    AppSpacing.tokenL,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AppText(
                        answer,
                        variant: AppTextVariant.bodySmall,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                          color: colors.neutral.shade700,
                        ),
                      ),
                      if (steps.isNotEmpty) ...<Widget>[
                        const SizedBox(height: AppSpacing.tokenS),
                        for (var index = 0; index < steps.length; index++)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.tokenXs,
                            ),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: colors.accent01.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                  child: AppText(
                                    '${index + 1}',
                                    variant: AppTextVariant.labelSmall,
                                    style: AppTypography.buyerMobile.caption
                                        .toTextStyle(
                                          color: colors.neutral.shade900,
                                        )
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.tokenS),
                                Expanded(
                                  child: AppText(
                                    steps[index],
                                    variant: AppTextVariant.bodySmall,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: AppTypography.buyerMobile.bodySmall
                                        .toTextStyle(
                                          color: colors.neutral.shade900,
                                        )
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                      if (note != null) ...<Widget>[
                        const SizedBox(height: AppSpacing.tokenS),
                        AppText(
                          note!,
                          variant: AppTextVariant.bodySmall,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style:
                              AppTypography.buyerMobile.bodySmall.toTextStyle(
                            color: colors.neutral.shade700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (expanded)
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: colors.primary.shade500, width: 1.5),
                  borderRadius: BorderRadius.circular(AppRadius.token2Xl),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ProfileFaqSupportCard extends StatelessWidget {
  const ProfileFaqSupportCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.tokenL),
      color: colors.primary.shade700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppText(
            title,
            variant: AppTextVariant.titleSmall,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: AppTypography.buyerMobile.h6
                .toTextStyle(
                  color: Colors.white,
                )
                .copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.tokenXs),
          AppText(
            description,
            variant: AppTextVariant.bodySmall,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: AppTypography.buyerMobile.bodySmall.toTextStyle(
              color: Colors.white.withValues(alpha: .72),
            ),
          ),
          const SizedBox(height: AppSpacing.tokenM),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: PrimaryButton(
              label: buttonLabel,
              onPressed: onPressed,
              icon: const Icon(Icons.chevron_left_rounded, size: 20),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 44),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.tokenL,
                ),
                backgroundColor: colors.accent01.shade300,
                foregroundColor: colors.neutral.shade900,
                shape: const StadiumBorder(),
                textStyle: AppTypography.buyerMobile.button
                    .toTextStyle(
                      color: colors.neutral.shade900,
                    )
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              fullWidth: false,
            ),
          ),
        ],
      ),
    );
  }
}
