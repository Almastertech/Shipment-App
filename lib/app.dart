import 'package:country_picker/country_picker.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'components/connectivity_banner.dart';
import 'core/utils/app_constants.dart';
import 'injection.dart';
import 'l10n/app_localizations.dart';
import 'localization/controllers/localization_controller.dart';
import 'themes/app_themes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _lastDevicePreviewLocale;

  void _syncWithDevicePreview(
    BuildContext context,
    LocalizationController localizationController,
  ) {
    final previewLocale = DevicePreview.locale(context);
    if (previewLocale == null) return;

    if (_lastDevicePreviewLocale == null) {
      _lastDevicePreviewLocale = previewLocale;
    } else if (_lastDevicePreviewLocale != previewLocale) {
      _lastDevicePreviewLocale = previewLocale;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        localizationController.handleSystemLocale(previewLocale);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationController = context.watch<LocalizationController>();
    final router = getIt<GoRouter>();

    _syncWithDevicePreview(context, localizationController);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          locale: localizationController.locale,
          supportedLocales: localizationController.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale != null) {
              for (final supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
            }
            return AppConstants.defaultLocale;
          },
          localizationsDelegates: const [
            AppLocalizations.delegate,
            CountryLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          themeMode: ThemeMode.light,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          builder: (context, child) {
            return DevicePreview.appBuilder(
              context,
              ConnectivityBanner(
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
        );
      },
    );
  }
}
