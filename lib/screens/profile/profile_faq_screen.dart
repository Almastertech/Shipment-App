import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/app_card.dart';
import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/inputs/app_search_field.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/profile_faq_widgets.dart';
import 'widgets/profile_subpage_hero.dart';

enum _FaqCategory { all, shipments, protection, claims }

class _FaqItem {
  const _FaqItem({
    required this.question,
    required this.answer,
    required this.category,
    this.steps = const <String>[],
    this.note,
  });

  final String question;
  final String answer;
  final _FaqCategory category;
  final List<String> steps;
  final String? note;
}

class ProfileFaqScreen extends StatefulWidget {
  const ProfileFaqScreen({super.key});

  @override
  State<ProfileFaqScreen> createState() => _ProfileFaqScreenState();
}

class _ProfileFaqScreenState extends State<ProfileFaqScreen> {
  final TextEditingController _searchController = TextEditingController();
  _FaqCategory _selectedCategory = _FaqCategory.all;
  int? _expandedIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final heroHeight = width * .75 < 280 ? 280.0 : width * .75;
    final items = _items(l10n);
    final query = _searchController.text.trim().toLowerCase();
    final filteredItems = items.where((item) {
      final matchesCategory = _selectedCategory == _FaqCategory.all ||
          item.category == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          item.question.toLowerCase().contains(query) ||
          item.answer.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

    return AppScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.tokenXl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: heroHeight,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ProfileSubpageHero(
                      title: l10n.profileFaqHeroTitle,
                      subtitle: l10n.profileFaqSubtitle,
                      backLabel: l10n.navigationBack,
                      onBack: () => _goBack(context),
                    ),
                  ),
                  PositionedDirectional(
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    bottom: AppSpacing.token2Xl,
                    child: Theme(
                      data: _searchTheme(context),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: AppSearchField(
                          controller: _searchController,
                          hintText: l10n.profileFaqSearchHint,
                          onChanged: (_) => setState(() {}),
                          clearTooltip: l10n.close,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.tokenL,
                AppSpacing.tokenL,
                AppSpacing.tokenL,
                AppSpacing.tokenS,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    for (var index = 0;
                        index < _FaqCategory.values.length;
                        index++) ...<Widget>[
                      if (index > 0) const SizedBox(width: AppSpacing.tokenS),
                      ProfileFaqCategoryChip(
                        label: _categoryLabel(_FaqCategory.values[index], l10n),
                        selected:
                            _selectedCategory == _FaqCategory.values[index],
                        onTap: () => setState(
                          () => _selectedCategory = _FaqCategory.values[index],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.tokenXl,
                AppSpacing.tokenM,
                AppSpacing.tokenXl,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppText(
                    l10n.profileFaqMostAsked,
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
                  if (filteredItems.isEmpty)
                    _EmptyFaqState(message: l10n.profileFaqEmpty)
                  else
                    for (var index = 0;
                        index < filteredItems.length;
                        index++) ...<Widget>[
                      if (index > 0) const SizedBox(height: AppSpacing.tokenS),
                      ProfileFaqQuestionCard(
                        question: filteredItems[index].question,
                        answer: filteredItems[index].answer,
                        steps: filteredItems[index].steps,
                        note: filteredItems[index].note,
                        expanded: _expandedIndex == index,
                        onTap: () => setState(
                          () => _expandedIndex =
                              _expandedIndex == index ? null : index,
                        ),
                      ),
                    ],
                  const SizedBox(height: AppSpacing.tokenL),
                  ProfileFaqSupportCard(
                    title: l10n.profileFaqSupportTitle,
                    description: l10n.profileFaqSupportDescription,
                    buttonLabel: l10n.profileInformationContactSupport,
                    onPressed: () =>
                        context.push(AppRoutes.createSupportTicket),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ThemeData _searchTheme(BuildContext context) {
    const colors = AppColors.primitives;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      borderSide: BorderSide.none,
    );
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        constraints: const BoxConstraints(minHeight: 60),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenL,
          vertical: AppSpacing.tokenM,
        ),
        hintStyle: AppTypography.buyerMobile.bodySmall.toTextStyle(
          color: colors.neutral.shade600,
        ),
        prefixIconColor: colors.neutral.shade800,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }

  List<_FaqItem> _items(AppLocalizations l10n) => <_FaqItem>[
        _FaqItem(
          question: l10n.profileFaqQuestion1,
          answer: l10n.profileFaqAnswer1,
          category: _FaqCategory.claims,
          steps: <String>[
            l10n.profileFaqStep1,
            l10n.profileFaqStep2,
            l10n.profileFaqStep3,
          ],
          note: l10n.profileFaqAnswer1Note,
        ),
        _FaqItem(
          question: l10n.profileFaqQuestion2,
          answer: l10n.profileFaqAnswer2,
          category: _FaqCategory.protection,
        ),
        _FaqItem(
          question: l10n.profileFaqQuestion3,
          answer: l10n.profileFaqAnswer3,
          category: _FaqCategory.shipments,
        ),
        _FaqItem(
          question: l10n.profileFaqQuestion4,
          answer: l10n.profileFaqAnswer4,
          category: _FaqCategory.claims,
        ),
        _FaqItem(
          question: l10n.profileFaqQuestion5,
          answer: l10n.profileFaqAnswer5,
          category: _FaqCategory.claims,
        ),
      ];

  String _categoryLabel(_FaqCategory category, AppLocalizations l10n) {
    return switch (category) {
      _FaqCategory.all => l10n.profileFaqCategoryAll,
      _FaqCategory.shipments => l10n.profileFaqCategoryShipments,
      _FaqCategory.protection => l10n.profileFaqCategoryProtection,
      _FaqCategory.claims => l10n.profileFaqCategoryClaims,
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

class _EmptyFaqState extends StatelessWidget {
  const _EmptyFaqState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.tokenXl),
      color: AppColors.semantic.surface.primary,
      child: AppText(
        message,
        variant: AppTextVariant.bodySmall,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
          color: AppColors.semantic.text.secondary,
        ),
      ),
    );
  }
}
