import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shipments/core/config/app_environment.dart';
import 'package:shipments/core/config/app_remote_config.dart';
import 'package:shipments/core/search/search_history_service.dart';
import 'package:shipments/core/storage/local_storage.dart';
import 'package:shipments/data/model/sample_item.dart';
import 'package:shipments/data/repository/sample_feature_repo.dart';
import 'package:shipments/features/notifications/application/in_app_notification_center.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/sample_feature/sample_feature_list_screen.dart';
import 'package:shipments/screens/sample_feature/sample_feature_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('sample feature list renders repository items', (tester) async {
    AppEnvironment.initialize();

    final repository = SampleFeatureRepositoryImpl(_FakeDataSource());
    final notificationCenter = InAppNotificationCenter(
      storage: _MemoryLocalStorage(),
      storageKey: 'notification_test_key',
    );
    await notificationCenter.initialize();
    final searchHistoryService = SearchHistoryService(
      storage: _MemoryLocalStorage(),
      queryStorageKey: 'search_queries',
      recentItemStorageKey: 'search_items',
    );
    await searchHistoryService.initialize();

    final viewModel = SampleFeatureViewModel(
      repository: repository,
      remoteConfig: const AppRemoteConfig(),
      notificationCenter: notificationCenter,
      searchHistoryService: searchHistoryService,
    );
    await viewModel.initialize();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SampleFeatureViewModel>.value(
            value: viewModel,
          ),
          ChangeNotifierProvider<InAppNotificationCenter>.value(
            value: notificationCenter,
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: <Locale>[
            Locale('en'),
            Locale('ar'),
          ],
          home: SampleFeatureListScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Template Item 1'), findsOneWidget);
  });
}

class _FakeDataSource implements SampleFeatureDataSource {
  @override
  Future<PaginatedSampleItems> fetchItems({
    required int page,
    required int pageSize,
    String query = '',
  }) async {
    return const PaginatedSampleItems(
      items: <SampleItem>[
        SampleItem(
          id: '1',
          title: 'Template Item 1',
          subtitle: 'Template subtitle',
          description: 'Template description',
        ),
      ],
      page: 1,
      hasMore: false,
    );
  }

  @override
  Future<SampleItem> fetchItemById(String id) async {
    return const SampleItem(
      id: '1',
      title: 'Template Item 1',
      subtitle: 'Template subtitle',
      description: 'Template description',
    );
  }
}

class _MemoryLocalStorage implements LocalStorage {
  final Map<String, Object> _data = <String, Object>{};

  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }

  @override
  bool? getBool(String key) => _data[key] as bool?;

  @override
  int? getInt(String key) => _data[key] as int?;

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }
}
