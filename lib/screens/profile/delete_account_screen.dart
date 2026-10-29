import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../core/session/session_manager.dart';
import '../../data/model/response/base/api_response.dart';
import '../../data/repository/auth_repository.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/delete_account_actions.dart';
import 'widgets/delete_account_card.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _deleting = false;
  String? _idempotencyKey;

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
    final bottomReservedSpace =
        bottomInset + _actionsBottomSpacing + actionsHeight + AppSpacing.tokenL;

    return AppScaffold(
      isLoading: widget.isLoading || _deleting,
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
              onConfirm: _deleteAccount,
              onCancel: () => _goBack(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount() async {
    if (_deleting) return;
    setState(() => _deleting = true);
    try {
      final key = _idempotencyKey ??= _newIdempotencyKey();
      final result = await getIt<AuthRepository>().deleteAccount(
        idempotencyKey: key,
      );
      if (result is ApiFailure<void>) {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(result.error.message)));
        return;
      }

      await getIt<SessionManager>().clearTokens();
      if (mounted) context.go(AppRoutes.login);
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  String _newIdempotencyKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex =
        bytes.map((value) => value.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-'
        '${hex.substring(20)}';
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }
}
