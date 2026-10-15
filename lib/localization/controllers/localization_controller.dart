import 'package:flutter/material.dart';

import '../../core/storage/local_storage.dart';
import '../../core/utils/app_constants.dart';
import '../../data/datasource/remote/dio/dio_client.dart';
import '../../l10n/app_localizations.dart';

class LocalizationController extends ChangeNotifier {
  LocalizationController({
    required LocalStorage storage,
    required DioClient dioClient,
  })  : _storage = storage,
        _dioClient = dioClient {
    _loadSavedLocale();
  }

  final LocalStorage _storage;
  final DioClient _dioClient;

  late Locale _locale;

  Locale get locale => _locale;

  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  TextDirection get textDirection =>
      _locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  bool get isLtr => textDirection == TextDirection.ltr;

  Future<void> setLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) return;

    _locale = Locale(languageCode);
    await _storage.setString(AppConstants.localeStorageKey, languageCode);
    _dioClient.updateHeaders(languageCode: languageCode);
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final nextLanguage = _locale.languageCode == 'en' ? 'ar' : 'en';
    await setLanguage(nextLanguage);
  }

  void _loadSavedLocale() {
    final savedLanguageCode =
        _storage.getString(AppConstants.localeStorageKey) ?? 'en';

    final isSupported = AppLocalizations.supportedLocales
        .any((locale) => locale.languageCode == savedLanguageCode);

    _locale = Locale(isSupported ? savedLanguageCode : 'en');
    _dioClient.updateHeaders(languageCode: _locale.languageCode);
  }
}
