import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'components/layout/bottom_sheet_service.dart';
import 'core/monitoring/in_memory_api_monitoring_service.dart';
import 'features/notifications/application/in_app_notification_center.dart';
import 'injection.dart';
import 'localization/controllers/localization_controller.dart';
import 'themes/theme_controller.dart';

class GenerateMultiProvider extends StatelessWidget {
  const GenerateMultiProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>.value(
          value: getIt<ThemeController>(),
        ),
        ChangeNotifierProvider<LocalizationController>.value(
          value: getIt<LocalizationController>(),
        ),
        ChangeNotifierProvider<InAppNotificationCenter>.value(
          value: getIt<InAppNotificationCenter>(),
        ),
        ChangeNotifierProvider<InMemoryApiMonitoringService>.value(
          value: getIt<InMemoryApiMonitoringService>(),
        ),
        Provider<AppBottomSheetService>.value(
          value: getIt<AppBottomSheetService>(),
        ),
      ],
      child: child,
    );
  }
}
