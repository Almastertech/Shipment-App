import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/text_link_button.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/profile_legal_widgets.dart';
import 'widgets/profile_subpage_hero.dart';

enum _ProfileLegalPageKind { terms, privacy, protection }

class ProfileLegalPageScreen extends StatelessWidget {
  const ProfileLegalPageScreen.terms({super.key})
      : _kind = _ProfileLegalPageKind.terms;

  const ProfileLegalPageScreen.privacy({super.key})
      : _kind = _ProfileLegalPageKind.privacy;

  const ProfileLegalPageScreen.protection({super.key})
      : _kind = _ProfileLegalPageKind.protection;

  final _ProfileLegalPageKind _kind;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final heroHeight = math
        .max(
          280.0,
          MediaQuery.sizeOf(context).width * .75,
        )
        .toDouble();
    final page = _content(l10n);

    return AppScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.tokenXl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: heroHeight + AppSpacing.tokenL,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    height: heroHeight,
                    child: ProfileSubpageHero(
                      title: page.title,
                      subtitle: page.subtitle,
                      backLabel: l10n.navigationBack,
                      onBack: () => _goBack(context),
                    ),
                  ),
                  PositionedDirectional(
                    top: heroHeight - 87,
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    child: ProfileDocumentSummaryCard(items: page.summary),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.tokenXl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppText(
                    l10n.profileInformationDetails,
                    variant: AppTextVariant.titleSmall,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppTypography.buyerMobile.h6
                        .toTextStyle(
                          color: AppColors.semantic.text.primary,
                        )
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  for (var index = 0;
                      index < page.sections.length;
                      index++) ...<Widget>[
                    if (index > 0) const SizedBox(height: AppSpacing.tokenM),
                    ProfileNumberedInfoCard(
                      number: index + 1,
                      title: page.sections[index].title,
                      description: page.sections[index].description,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.tokenM),
                  Center(
                    child: TextLinkButton(
                      label: l10n.profileInformationSupportQuestion,
                      onPressed: () =>
                          context.push(AppRoutes.createSupportTicket),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                      iconOnTrailing: true,
                      foregroundColor: AppColors.primitives.primary.shade500,
                      textStyle: AppTypography.buyerMobile.label
                          .toTextStyle(
                            color: AppColors.primitives.primary.shade500,
                          )
                          .copyWith(fontWeight: FontWeight.w700),
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

  _ProfileLegalContent _content(AppLocalizations l10n) {
    return switch (_kind) {
      _ProfileLegalPageKind.terms => _ProfileLegalContent(
          title: l10n.profileTerms,
          subtitle: l10n.profileTermsSubtitle,
          summary: <ProfileSummaryItem>[
            ProfileSummaryItem(
              label: l10n.profileInformationVersion,
              value: l10n.profileInformationCurrentVersion,
            ),
            ProfileSummaryItem(
              label: l10n.profileInformationReadingTime,
              value: l10n.profileInformationMinutes4,
            ),
          ],
          sections: <_ProfileLegalSection>[
            _ProfileLegalSection(
                l10n.profileTermsSection1Title, l10n.profileTermsSection1Body,),
            _ProfileLegalSection(
                l10n.profileTermsSection2Title, l10n.profileTermsSection2Body,),
            _ProfileLegalSection(
                l10n.profileTermsSection3Title, l10n.profileTermsSection3Body,),
            _ProfileLegalSection(
                l10n.profileTermsSection4Title, l10n.profileTermsSection4Body,),
            _ProfileLegalSection(
                l10n.profileTermsSection5Title, l10n.profileTermsSection5Body,),
          ],
        ),
      _ProfileLegalPageKind.privacy => _ProfileLegalContent(
          title: l10n.profilePrivacy,
          subtitle: l10n.profilePrivacySubtitle,
          summary: <ProfileSummaryItem>[
            ProfileSummaryItem(
              label: l10n.profileInformationScope,
              value: l10n.profileInformationProtectionScope,
            ),
            ProfileSummaryItem(
              label: l10n.profileInformationLanguage,
              value: l10n.profileInformationArabic,
            ),
            ProfileSummaryItem(
              label: l10n.profileInformationReadingTime,
              value: l10n.profileInformationMinutes3,
            ),
          ],
          sections: <_ProfileLegalSection>[
            _ProfileLegalSection(l10n.profilePrivacySection1Title,
                l10n.profilePrivacySection1Body,),
            _ProfileLegalSection(l10n.profilePrivacySection2Title,
                l10n.profilePrivacySection2Body,),
            _ProfileLegalSection(l10n.profilePrivacySection3Title,
                l10n.profilePrivacySection3Body,),
            _ProfileLegalSection(l10n.profilePrivacySection4Title,
                l10n.profilePrivacySection4Body,),
            _ProfileLegalSection(l10n.profilePrivacySection5Title,
                l10n.profilePrivacySection5Body,),
            _ProfileLegalSection(l10n.profilePrivacySection6Title,
                l10n.profilePrivacySection6Body,),
          ],
        ),
      _ProfileLegalPageKind.protection => _ProfileLegalContent(
          title: l10n.profileProtectionTerms,
          subtitle: l10n.profileProtectionSubtitle,
          summary: <ProfileSummaryItem>[
            ProfileSummaryItem(
              label: l10n.profileInformationProtectionIncludes,
              value: l10n.profileInformationLossDamage,
            ),
            ProfileSummaryItem(
              label: l10n.profileInformationClaimPeriod,
              value: l10n.profileInformationTwoDays,
            ),
          ],
          sections: <_ProfileLegalSection>[
            _ProfileLegalSection(l10n.profileProtectionSection1Title,
                l10n.profileProtectionSection1Body,),
            _ProfileLegalSection(l10n.profileProtectionSection2Title,
                l10n.profileProtectionSection2Body,),
            _ProfileLegalSection(l10n.profileProtectionSection3Title,
                l10n.profileProtectionSection3Body,),
            _ProfileLegalSection(l10n.profileProtectionSection4Title,
                l10n.profileProtectionSection4Body,),
            _ProfileLegalSection(l10n.profileProtectionSection5Title,
                l10n.profileProtectionSection5Body,),
          ],
        ),
    };
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }
}

class _ProfileLegalContent {
  const _ProfileLegalContent({
    required this.title,
    required this.subtitle,
    required this.summary,
    required this.sections,
  });

  final String title;
  final String subtitle;
  final List<ProfileSummaryItem> summary;
  final List<_ProfileLegalSection> sections;
}

class _ProfileLegalSection {
  const _ProfileLegalSection(this.title, this.description);

  final String title;
  final String description;
}
