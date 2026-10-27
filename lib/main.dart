import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'core/config/app_environment.dart';
import 'injection.dart' as injection;
import 'providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  AppEnvironment.initialize();
  await injection.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      data: const DevicePreviewData(locale: 'ar'),
      builder: (context) => const GenerateMultiProvider(child: MyApp()),
    ),
  );
}
