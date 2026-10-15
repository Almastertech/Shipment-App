# دليل العمل على التمبلت (AR)

> آخر تحديث: النسخة المبسطة (تم إزالة offline queue / feature flags / remote config / event bus / CI-git hooks)

هذا الملف خريطة تشغيل سريعة لفهم التمبلت.

## 1) المعمارية الأساسية

التدفق المعتمد:

`UI -> ViewModel -> Repository -> DataSource -> DioClient -> API`

الستاك الأساسي:
- إدارة الحالة: `Provider + ChangeNotifier`
- DI: `GetIt`
- Routing: `go_router`
- Networking: `Dio` interceptors

## 2) أول ملفات تقرأها

- `lib/main.dart`
- `lib/app.dart`
- `lib/injection.dart`
- `lib/providers.dart`
- `lib/core/routing/app_router.dart`
- `lib/core/session/session_manager.dart`
- `lib/components/ui_kit.dart`
- `lib/components/ui_kit_showcase_screen.dart`

## 3) Startup و Session

ترتيب التشغيل:
1. `AppEnvironment.initialize()`
2. `injection.init()`
3. `MaterialApp.router`
4. `StartupFlow` يحدد البداية

حالات السيشن:
- `unauthenticated`
- `guest`
- `authenticated`

Guest mode متاح دائمًا في هذه النسخة.

## 4) Session Purge

`SessionManager.clearTokens()` يمسح بيانات المستخدم المرتبطة بالجلسة:
- auth/refresh/guest markers
- search history + recent items
- in-app notifications
- user cache

ويحافظ على:
- theme
- locale

## 5) Routing + Guards

أنواع الـ guards:
- `none`
- `authOnly`
- `authOrGuest`
- `guestOnly`

أي route غير معروف يتم التعامل معه fail-closed.

## 6) الشبكة

ترتيب الـ interceptors:
1. `ApiMonitoringInterceptor`
2. `AuthInterceptor`
3. `RateLimitInterceptor`
4. `RetryInterceptor`
5. `LoggingInterceptor`

## 7) الكاش والحدود

- الاستراتيجية: stale-while-revalidate
- حد cache memory الافتراضي: `300`
- حد in-app notifications: `100`

## 8) UI Foundation

المكونات المشتركة في `lib/components/`.
صفحة `/ui-kit` لمراجعة حالات المكونات (loading/empty/error/content) مع RTL و text-scale و viewport presets.

## 9) أوامر يومية

```bash
flutter pub get
flutter gen-l10n
dart run tool/architecture_lint.dart
flutter analyze
flutter test
flutter test integration_test -d linux
flutter run --dart-define=ENV=dev
```

## 10) Checklist قبل الشحن

1. ضبط package IDs واسم التطبيق.
2. ضبط `ENV` و `API_BASE_URL`.
3. إعداد release signing (Android/iOS).
4. التأكد من `INTERNET` permission في Android manifest.
5. استبدال push noop provider لو مطلوب push حقيقي.
6. مراجعة route guards لأي route جديد.
7. اختبار purge behavior بعد logout/expiry.
8. مراجعة `/ui-kit`.
9. التأكد أن analyze/tests ناجحة.

## 11) ما تم حذفه من النسخة هذه

- Offline action queue/replay
- Feature flags
- Remote config service
- Event bus
- Crash/analytics abstractions
- GitHub workflow + git hooks setup scripts

## 12) قاعدة مصدر الحقيقة

لو في فرق بين الدوكيومنت والكود:
1. الكود أولًا
2. `README.md`
3. onboarding guides
