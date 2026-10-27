import 'package:flutter/material.dart';

import '../../core/storage/local_storage.dart';
import '../../core/utils/app_constants.dart';
import '../../data/datasource/remote/dio/dio_client.dart';
import '../../l10n/app_localizations.dart';

class LocalizationController extends ChangeNotifier
    with WidgetsBindingObserver {
  LocalizationController({
    required LocalStorage storage,
    required DioClient dioClient,
    WidgetsBinding? binding,
  })  : _storage = storage,
        _dioClient = dioClient,
        _binding = binding ?? WidgetsBinding.instance {
    _binding?.addObserver(this);
    _loadSavedLocale();
  }

  final LocalStorage _storage;
  final DioClient _dioClient;
  final WidgetsBinding? _binding;

  Locale _locale = AppConstants.defaultLocale;

  Locale get locale => _locale;

  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  TextDirection get textDirection =>
      _locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  bool get isLtr => textDirection == TextDirection.ltr;

  Future<void> setLanguage(String languageCode) async {
    final normalizedCode = _normalizeSupportedCode(languageCode);
    if (_locale.languageCode == normalizedCode) return;

    _locale = Locale(normalizedCode);
    await _storage.setString(AppConstants.localeStorageKey, normalizedCode);
    _dioClient.updateHeaders(languageCode: normalizedCode);
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final nextLanguage = _locale.languageCode == 'en' ? 'ar' : 'en';
    await setLanguage(nextLanguage);
  }

  /// Handles system locale changes (from device OS settings or DevicePreview).
  void handleSystemLocale(Locale systemLocale) {
    handleSystemLocales(<Locale>[systemLocale]);
  }

  /// Resolves the first supported language candidate from device locales.
  void handleSystemLocales(List<Locale>? locales) {
    final resolved = _resolveSupportedLocale(locales);
    if (_locale.languageCode == resolved.languageCode) return;

    _locale = resolved;
    _storage.setString(AppConstants.localeStorageKey, resolved.languageCode);
    _dioClient.updateHeaders(languageCode: resolved.languageCode);
    notifyListeners();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    handleSystemLocales(locales);
  }

  void _loadSavedLocale() {
    final savedLanguageCode = _storage.getString(AppConstants.localeStorageKey);
    if (savedLanguageCode != null) {
      final isSupported = supportedLocales
          .any((locale) => locale.languageCode == savedLanguageCode);
      if (isSupported) {
        _locale = Locale(savedLanguageCode);
        _dioClient.updateHeaders(languageCode: _locale.languageCode);
        return;
      }
    }

    // Default to Arabic when no preference is saved
    _locale = AppConstants.defaultLocale;
    _dioClient.updateHeaders(languageCode: _locale.languageCode);
  }

  Locale _resolveSupportedLocale(List<Locale>? locales) {
    if (locales != null && locales.isNotEmpty) {
      for (final candidate in locales) {
        final code = candidate.languageCode.toLowerCase();
        if (supportedLocales.any((l) => l.languageCode == code)) {
          return Locale(code);
        }
      }
    }
    return AppConstants.defaultLocale;
  }

  String _normalizeSupportedCode(String code) {
    final lower = code.toLowerCase();
    return supportedLocales.any((l) => l.languageCode == lower)
        ? lower
        : AppConstants.defaultLanguageCode;
  }

  @override
  void dispose() {
    _binding?.removeObserver(this);
    super.dispose();
  }
}
