import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/notification_preferences_card.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  static const Map<String, bool> _defaultPreferences = <String, bool>{
    'notifications_allowed': true,
    'shipment_updates': true,
    'claim_updates': true,
    'store_offers': false,
  };

  late Map<String, bool> _preferences =
      Map<String, bool>.of(_defaultPreferences);

  @override
  void initState() {
    super.initState();
    unawaited(_loadPreferences());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final heroHeight = ProfileHero.heightForWidth(width);

    final preferenceItems = <(String, String, String)>[
      (
        'notifications_allowed',
        l10n.notificationPermissionTitle,
        l10n.notificationPermissionDescription,
      ),
      (
        'shipment_updates',
        l10n.notificationShipmentTitle,
        l10n.notificationShipmentDescription,
      ),
      (
        'claim_updates',
        l10n.notificationClaimTitle,
        l10n.notificationClaimDescription,
      ),
      (
        'store_offers',
        l10n.notificationOffersTitle,
        l10n.notificationOffersDescription,
      ),
    ];

    return AppScaffold(
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
              title: l10n.notificationSettingsTitle,
              subtitle: l10n.notificationSettingsSubtitle,
              backLabel: l10n.navigationBack,
              titleSubtitleSpacing: AppSpacing.tokenS,
              onBack: () => _goBack(context),
            ),
          ),
          PositionedDirectional(
            top: heroHeight -  AppSpacing.tokenXl,
            start: AppSpacing.tokenXl,
            end: AppSpacing.tokenXl,
            bottom: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: AppSpacing.token3Xl),
              child: Column(
                children: <Widget>[
                  NotificationPreferencesCard(
                    preferences: <NotificationPreference>[
                      for (final item in preferenceItems)
                        NotificationPreference(
                          title: item.$2,
                          description: item.$3,
                          value: _preferences[item.$1] ?? false,
                          onChanged: (value) => _setPreference(item.$1, value),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.token2Xl),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.token2Xs,
                    ),
                    child: AppText(
                      l10n.notificationSettingsNote,
                      variant: AppTextVariant.bodySmall,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                        color: AppColors.primitives.neutral.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadPreferences() async {
    try {
      final storage = await SharedPreferences.getInstance();
      final preferences = <String, bool>{
        for (final entry in _defaultPreferences.entries)
          entry.key: storage.getBool(entry.key) ?? entry.value,
      };
      if (mounted) setState(() => _preferences = preferences);
    } catch (_) {
      // Keep the reference defaults available when local storage is unavailable.
    }
  }

  Future<void> _setPreference(String key, bool value) async {
    setState(() => _preferences = <String, bool>{..._preferences, key: value});
    try {
      final storage = await SharedPreferences.getInstance();
      await storage.setBool(key, value);
    } catch (_) {
      // The setting remains active for the current screen session.
    }
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }
}
