import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/delete_account_actions.dart';
import 'widgets/delete_account_card.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key, this.isLoading = false});

  final bool isLoading;

  static const double _cardTop = 220;
  static const double _cardHorizontalMargin = AppSpacing.tokenXl;
  static const double _actionsHorizontalMargin = AppSpacing.token2Xl;
  static const double _actionsBottomSpacing = AppSpacing.tokenXl;
  static const double _actionHeight = AppSpacing.token6Xl;
  static const double _actionGap = AppSpacing.tokenS;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final heroHeight =
        ProfileHero.heightForWidth(MediaQuery.sizeOf(context).width);
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    const actionsHeight = _actionHeight * 2 + _actionGap;
    final bottomReservedSpace = bottomInset +
        _actionsBottomSpacing +
        actionsHeight +
        AppSpacing.tokenL;

    return AppScaffold(
      isLoading: isLoading,
      loadingLabel: l10n.loading,
      padding: EdgeInsets.zero,
      safeArea: false,
      backgroundColor: AppColors.semantic.background.primary,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            height: heroHeight,
            child: ProfileSubpageHero(
              title: l10n.profileDeleteHeroTitle,
              subtitle: l10n.profileDeleteSubtitle,
              backLabel: l10n.profileDeleteBack,
              onBack: () => _goBack(context),
            ),
          ),
          PositionedDirectional(
            top: _cardTop,
            start: _cardHorizontalMargin,
            end: _cardHorizontalMargin,
            bottom: bottomReservedSpace,
            child: SingleChildScrollView(
              child: DeleteAccountCard(
                title: l10n.profileDeleteTitle,
                message: l10n.profileDeleteMessage,
                nameLabel: l10n.profileDeleteNameLabel,
                name: l10n.homeUserName,
                phoneLabel: l10n.profileDeletePhoneLabel,
                phone: l10n.profilePhone,
              ),
            ),
          ),
          PositionedDirectional(
            start: _actionsHorizontalMargin,
            end: _actionsHorizontalMargin,
            bottom: bottomInset + _actionsBottomSpacing,
            child: DeleteAccountActions(
              confirmLabel: l10n.profileDeleteConfirm,
              cancelLabel: l10n.profileDeleteCancel,
              onConfirm: () => _showDeleteUnavailable(context, l10n),
              onCancel: () => _goBack(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteUnavailable(BuildContext context, AppLocalizations l10n) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.profileDeleteUnavailable)));
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }
}
