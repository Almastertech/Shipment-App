// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Shipments';

  @override
  String get splashBrand => 'حصين';

  @override
  String get splashTagline => 'منتجاتك.. في أيدٍ أمينة';

  @override
  String get splashFooter => 'حماية شحنتك من المتجر لين باب بيتك';

  @override
  String get onboardingProtectionLead => 'قفل';

  @override
  String get onboardingProtectionHighlight => 'الحماية';

  @override
  String get onboardingProtectionTail => 'أثناء عملية الشراء';

  @override
  String get onboardingProtectionSubtitle =>
      'اختر حماية حصين وقت الدفع، وشحنتك بأمان من أول لحظة.';

  @override
  String get onboardingTrackingLead => 'تابع';

  @override
  String get onboardingTrackingHighlight => 'شحنتك';

  @override
  String get onboardingTrackingTail => 'لين توصل بابك';

  @override
  String get onboardingTrackingSubtitle =>
      'تابع شحنتك خطوة بخطوة واعرف موعد وصولها حتى بابك.';

  @override
  String get onboardingClaimTitle => 'حصّن معاك';

  @override
  String get onboardingClaimSubtitle =>
      'إذا صار أي شيء لشحنتك، نساعدك بخطوات مطالبة واضحة وسهلة.';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingSkip => 'تخطي المقدمة';

  @override
  String get onboardingStart => 'ابدأ الآن';

  @override
  String get loginMethodHelp => 'تحتاج إلى المساعدة؟';

  @override
  String get loginMethodHelpMessage =>
      'تواصل مع فريق الدعم لمساعدتك في تسجيل الدخول.';

  @override
  String get loginMethodTitle => 'كيف تبي تدخل؟';

  @override
  String get loginMethodSubtitle =>
      'استخدم نفس الجوال أو الإيميل اللي حطيته وقت ما فعّلت الحماية.';

  @override
  String get loginMethodChooseTitle => 'اختر طريقة الدخول';

  @override
  String get authPrivacyNotice => 'بالمتابعة توافق على الشروط وسياسة الخصوصية';

  @override
  String get loginSendCode => 'إرسال رمز';

  @override
  String get loginMethodPhone => 'رقم الجوال';

  @override
  String get loginMethodPhoneDescription =>
      'سنرسل رمز تحقق إلى رقم الجوال المرتبط بحسابك.';

  @override
  String get loginMethodEmail => 'البريد الإلكتروني';

  @override
  String get loginMethodEmailDescription =>
      'سنرسل رمز تحقق إلى البريد الإلكتروني المرتبط بحسابك.';

  @override
  String get loginMethodContinue => 'كمل';

  @override
  String get loginPhoneTitle => 'وش رقم جوالك؟';

  @override
  String get loginPhoneSubtitle => 'الرقم اللي استخدمته وقت ما اشتريت الحماية';

  @override
  String get loginPhoneFieldLabel => 'رقم الجوال';

  @override
  String get loginPhoneFieldHint => '5X XXX XXXX';

  @override
  String get loginPhoneFieldHelper => 'سيصلك رمز تحقق لمرة واحدة على رقمك.';

  @override
  String get loginEmailTitle => 'وش إيميلك؟';

  @override
  String get loginEmailSubtitle =>
      'الإيميل اللي استخدمته وقت ما اشتريت الحماية';

  @override
  String get loginEmailFieldLabel => 'البريد الإلكتروني';

  @override
  String get loginEmailFieldHint => 'name@example.com';

  @override
  String get loginEmailFieldHelper =>
      'سيصلك رمز تحقق لمرة واحدة على بريدك الإلكتروني.';

  @override
  String get loginPhoneInvalid => 'أدخل رقم جوال صحيحًا لهذا البلد.';

  @override
  String otpDestination(String contact) {
    return 'أرسلنا رمزاً مكوناً من 6 أرقام إلى $contact';
  }

  @override
  String otpPhoneDestination(Object contact) {
    return 'أرسلنا رمزًا من ٦ أرقام إلى جوالك المنتهي بـ $contact';
  }

  @override
  String otpEmailDestination(Object contact) {
    return 'أرسلنا رمزاً من 6 أرقام إلى $contact';
  }

  @override
  String get otpPhoneLengthHint => 'أدخل الرمز المكوّن من 4 أرقام';

  @override
  String get otpEmailLengthHint => 'أدخل الرمز المكوّن من 6 أرقام';

  @override
  String get countryPickerTitle => 'اختر رمز الدولة';

  @override
  String get countryPickerSearchHint => 'ابحث عن دولة أو رمز اتصال';

  @override
  String get countryPickerEmpty => 'لا توجد دول مطابقة';

  @override
  String get sampleFeatureTitle => 'ميزة تجريبية';

  @override
  String get sampleFeatureSubtitle =>
      'قائمة وتفاصيل وإدارة حالة قابلة لإعادة الاستخدام';

  @override
  String get searchHint => 'ابحث في العناصر';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noItemsTitle => 'لا توجد عناصر';

  @override
  String get noItemsDescription => 'جرّب تغيير كلمة البحث أو اسحب للتحديث.';

  @override
  String get genericError => 'حدث خطأ. حاول مرة أخرى.';

  @override
  String get detailsTitle => 'التفاصيل';

  @override
  String get changeTheme => 'تغيير الثيم';

  @override
  String get switchLanguage => 'تغيير اللغة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get loginSubtitle =>
      'هذه شاشة دخول ابتدائية. استبدلها بتدفق المصادقة الخاص بمشروعك.';

  @override
  String get signInDemo => 'الدخول بحساب تجريبي';

  @override
  String get openOtpDemo => 'فتح تجربة رمز التحقق';

  @override
  String get otpTitle => 'اكتب رمز التحقق';

  @override
  String get otpVerify => 'تحقق';

  @override
  String get otpSubtitle => 'أرسلنا رمزاً مكوناً من 6 أرقام إلى رقمك';

  @override
  String get otpHint => 'رمز التحقق';

  @override
  String get otpResend => 'إعادة إرسال الرمز';

  @override
  String otpResendCountdown(String time) {
    return 'تقدر تطلب رمز جديد بعد $time';
  }

  @override
  String get otpVerificationFailed => 'الرمز غير صحيح. حاول مرة أخرى.';

  @override
  String get otpSuccessTitle => 'تم التحقق!';

  @override
  String get otpSuccessMessage => 'لحظات ونوديك لشحنتك';

  @override
  String get welcomeTitle => 'هلا والله، عبدالله 👋';

  @override
  String get welcomeDescription =>
      'لقينا حماية شحنتك. تقدر الحين تتابعها، ولو صار شي تقدم مطالبتك من هنا.';

  @override
  String get welcomeContinue => 'ادخل حصين';

  @override
  String get welcomeProductTitle => 'ساعة ذكية — إصدار ذهبي';

  @override
  String get welcomeProtectionActive => 'حماية حصين';

  @override
  String get accountNotFoundTitle => 'ما لقينا حماية ببياناتك';

  @override
  String get accountNotFoundBody =>
      'تأكد أنك تستخدم نفس الجوال أو الإيميل اللي حطيته وقت الشراء من التاجر.';

  @override
  String get accountNotFoundPhone => 'رقم الجوال المستخدم عند الشراء';

  @override
  String get accountNotFoundEmail => 'الإيميل المستخدم عند الشراء';

  @override
  String get accountNotFoundCheckEmail => 'شيك على رسالة تأكيد الطلب من التاجر';

  @override
  String get accountNotFoundTryOtherMethod =>
      'جرب الطريقة الثانية (جوال أو إيميل)';

  @override
  String get accountNotFoundTryAgain => 'جرب بيانات ثانية';

  @override
  String get accountNotFoundSupport => 'كلم الدعم';

  @override
  String homeGreeting(String name) {
    return 'مساء الخير، $name 👋';
  }

  @override
  String get homeTitle => 'تتبع شحناتك اليوم';

  @override
  String get homeActiveShipments => 'شحناتك النشطة';

  @override
  String get myShipmentsSubtitle =>
      'تغطية للتلف والفقدان والتأخير في شحنات التاجر';

  @override
  String get myShipmentsActiveTab => 'نشطة 2';

  @override
  String get myShipmentsDeliveredTab => 'تم التسليم 1';

  @override
  String get homeActiveClaims => 'مطالباتك النشطة';

  @override
  String get homeSeeAllShipments => 'عرض الكل';

  @override
  String get homeShipmentMerchant => 'متجر نون';

  @override
  String get homeShipmentProduct => 'ساعة ذكية - إصدار ذهبي';

  @override
  String get homeShipmentPrice => '480 ر.س';

  @override
  String get homeShipmentTitle => 'شحنتك في الطريق';

  @override
  String get homeShipmentStepOrdered => 'تم الطلب';

  @override
  String get homeShipmentStepInTransit => 'في الطريق';

  @override
  String get homeShipmentStepDelivered => 'تم التسليم';

  @override
  String get homeShipmentView => 'عرض الشحنة';

  @override
  String get homeShipmentProtection => 'محمية بواسطة حصين';

  @override
  String get homeShipmentDeliveryStatus => 'قيد التوصيل';

  @override
  String get homeShipmentExpectedDelivery => 'التسليم المتوقع';

  @override
  String get homeShipmentExpectedDate => 'الاثنين ١ أكتوبر';

  @override
  String get homeShipmentTrackingLabel => 'رقم التتبع';

  @override
  String get homeShipmentTrackingNumber => '#HS-2048';

  @override
  String get homeShipmentDetails => 'عرض التفاصيل';

  @override
  String get shipmentDetailsTitle => 'تفاصيل الشحنة';

  @override
  String get shipmentProtectionTitle => 'حماية الشحنة';

  @override
  String get shipmentProtectionCoveredBy => 'محمية بواسطة حصين';

  @override
  String get shipmentProtectionValueLabel => 'القيمة المحمية';

  @override
  String get shipmentProtectionValue => '480 ر.س';

  @override
  String get shipmentProtectionStatusLabel => 'الحالة';

  @override
  String get shipmentProtectionStatus => 'فعالة';

  @override
  String get shipmentProtectionRemainingLabel => 'المطالبة (12 يوم)';

  @override
  String get shipmentProtectionRemaining => 'لم يتم تفعيلها';

  @override
  String get shipmentProtectionClaimAction => 'فتح مطالبة';

  @override
  String get shipmentTimelineTitle => 'مسار الشحنة';

  @override
  String get shipmentTimelineOrdered => 'تم الطلب';

  @override
  String get shipmentTimelineShipped => 'تم الشحن';

  @override
  String get shipmentTimelineInTransit => 'قيد التوصيل';

  @override
  String get shipmentTimelineDelivered => 'تم التسليم';

  @override
  String get shipmentTimelineOrderDate => '1 أكتوبر';

  @override
  String get shipmentDetailsSectionTitle => 'تفاصيل الشحنة';

  @override
  String get shipmentDetailsExpectedDelivery => 'التسليم المتوقع';

  @override
  String get shipmentDetailsExpectedDeliveryValue => 'متجر نون';

  @override
  String get shipmentDetailsOrderDate => 'تاريخ الطلب';

  @override
  String get shipmentDetailsOrderDateValue => 'الجمعة - 1 أكتوبر';

  @override
  String get shipmentDetailsProduct => 'المنتج';

  @override
  String get shipmentDetailsProductValue => 'سماعات لاسلكية برو';

  @override
  String get shipmentDetailsAddress => 'عنوان التسليم';

  @override
  String get shipmentDetailsAddressValue => 'حي الياسمين، الرياض';

  @override
  String get shipmentDetailsQuantity => 'الكمية';

  @override
  String get shipmentDetailsQuantityValue => '1';

  @override
  String get homeQuickGuide => 'دليل سريع';

  @override
  String get homeQuickGuideAction => 'كيف تعمل الحماية؟';

  @override
  String get homeRequestNumber => 'HS-2048';

  @override
  String get homeRequestType => 'مطالبة';

  @override
  String get homeRequestRemainingTime => 'مطلوب منك';

  @override
  String get homeRequestTitle => 'عطر رجالي بقيمة ١٠٠ ر.س من نيس ون';

  @override
  String get homeRequestDescription =>
      'صوّر المنتج والتغليف بوضوح عشان نكمل مراجعة مطالبتك بسرعة.';

  @override
  String get homeRequestStepReceived => 'استلام الطلب';

  @override
  String get homeRequestStepReview => 'مراجعة الطلب';

  @override
  String get homeRequestStepDecision => 'إصدار قرار';

  @override
  String get homeRequestStepCompensation => 'تعويض';

  @override
  String get homeRequestAmountLabel => 'قيمة الوثيقة';

  @override
  String get homeRequestAmount => '480 ر.س';

  @override
  String get homeRequestAction => 'كمل المطالبة';

  @override
  String get homeSecondaryRequestEta => 'خلال ٢-٣ أيام';

  @override
  String get homeSecondaryRequestDescription =>
      'نتابع صورة وتفاصيل مطالبتك، وسنخبرك بأي تحديث قريبًا.';

  @override
  String get homeSecondaryRequestAmountLabel => 'قيمة الطلب';

  @override
  String get homeSecondaryRequestAction => 'تابع المطالبة';

  @override
  String get homeHowItWorks => 'كيف يبدأ الأمر';

  @override
  String get mainBannerGreeting => 'مرحباً بك في حصين 👋';

  @override
  String get mainBannerTitle => 'مشترياتك بأمان مع حصين';

  @override
  String get mainBannerDescription =>
      'اشترِ من متاجرنا الشريكة، واستمتع بشحن آمن وحماية من لحظة الطلب حتى باب بيتك.';

  @override
  String get mainBannerAction => 'اكتشف المتاجر الشريكة';

  @override
  String get mainBannerPartnerCount => '+40 متجر شريك';

  @override
  String get homeStepOneLabel => 'الخطوة الأولى';

  @override
  String get homeStepOneTitle => 'تسوّق من متجر شريك';

  @override
  String get homeStepOneDescription => 'اختر شارة حصين عند عملية الدفع.';

  @override
  String get homeStepTwoLabel => 'الخطوة الثانية';

  @override
  String get homeStepTwoTitle => 'تُحمى شحنتك تلقائيًا';

  @override
  String get homeStepTwoDescription => 'تظهر هنا مع حالتها لحظة بلحظة.';

  @override
  String get homeStepThreeLabel => 'الخطوة الثالثة';

  @override
  String get homeStepThreeTitle => 'مطالبة بخطوات بسيطة';

  @override
  String get homeStepThreeDescription => 'إن حدث تلف أو فقدان، نعوضك بسرعة.';

  @override
  String get secondaryBannerEyebrow => 'كيف تعمل الحماية؟';

  @override
  String get secondaryBannerTitle => 'تعرف على حماية حصين';

  @override
  String get secondaryBannerDescription =>
      'تغطية للتلف والفقدان والتأخير في شحنات التاجر المؤهلة.';

  @override
  String get secondaryBannerAction => 'زيارة المدونة';

  @override
  String get bottomNavHome => 'الرئيسية';

  @override
  String get bottomNavShipments => 'شحناتي';

  @override
  String get bottomNavOrders => 'الطلبات';

  @override
  String get bottomNavStores => 'التاجر';

  @override
  String get bottomNavProfile => 'حسابي';

  @override
  String get otpPrivacyNotice =>
      'لا تشارك الرمز مع أي أحد، حتى لو قال إنه من حصين.';

  @override
  String get otpChangePhone => 'غيّر رقم الجوال';

  @override
  String get otpChangeEmail => 'تغيير البريد الإلكتروني';

  @override
  String get startAutofill => 'بدء التعبئة التلقائية';

  @override
  String get verifyOtp => 'تأكيد الرمز';

  @override
  String get otpInvalid => 'يرجى إدخال رمز صحيح';

  @override
  String get otpVerifiedMessage => 'تم التقاط الرمز بنجاح.';

  @override
  String get otpAutofillUnavailable =>
      'التعبئة التلقائية غير متاحة على هذا الجهاز.';

  @override
  String get itemDetails => 'رجوع';

  @override
  String get loadMore => 'تحميل المزيد';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get continueAsGuest => 'المتابعة كضيف';

  @override
  String get offlineBanner => 'أنت غير متصل بالإنترنت';

  @override
  String get protectedAction => 'إجراء محمي';

  @override
  String get authRequiredAction => 'يرجى تسجيل الدخول لإكمال هذا الإجراء.';

  @override
  String protectedActionCompleted(String itemId) {
    return 'تم تنفيذ الإجراء المحمي للعنصر $itemId.';
  }

  @override
  String get promoBannerMessage => 'عرض محدود: توصيل مجاني للطلبات المؤهلة.';

  @override
  String get clearSearchHistory => 'مسح السجل';

  @override
  String get recentlyViewedTitle => 'آخر العناصر التي تمت مشاهدتها';

  @override
  String get refreshSkippedWhileLoadingMore =>
      'تم تعطيل التحديث مؤقتًا أثناء تحميل المزيد.';

  @override
  String get uiKitShowcase => 'استعراض مكونات الواجهة';

  @override
  String get apiMonitor => 'مراقبة الشبكة';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsMarkAllRead => 'تعيين الكل كمقروء';

  @override
  String get notificationsEmpty => 'لا توجد إشعارات حتى الآن.';

  @override
  String get apiMonitorTitle => 'مراقبة الشبكة';

  @override
  String get apiMonitorRecentRequests => 'أحدث الطلبات';

  @override
  String get apiMonitorSlowestRequests => 'أبطأ الطلبات';

  @override
  String get apiMonitorFailedRequests => 'الطلبات الفاشلة';

  @override
  String get apiMonitorNoRecords => 'لا توجد سجلات بعد.';

  @override
  String get navigationErrorTitle => 'خطأ في التنقل';

  @override
  String get routeMissingItemId => 'معرّف العنصر مفقود في المسار.';

  @override
  String get errorOfflineTitle => 'لا يوجد اتصال بالإنترنت';

  @override
  String get errorOfflineMessage => 'تحقق من الاتصال وحاول مرة أخرى.';

  @override
  String get errorUnauthorizedTitle => 'مطلوب تسجيل الدخول';

  @override
  String get errorUnauthorizedMessage => 'يرجى تسجيل الدخول للمتابعة.';

  @override
  String get errorForbiddenTitle => 'الوصول غير مسموح';

  @override
  String get errorForbiddenMessage => 'لا تملك صلاحية لهذا الإجراء.';

  @override
  String get errorNotFoundTitle => 'غير موجود';

  @override
  String get errorNotFoundMessage => 'لم يتم العثور على البيانات المطلوبة.';

  @override
  String get errorValidationTitle => 'بيانات غير صحيحة';

  @override
  String get errorValidationMessage => 'يرجى مراجعة البيانات والمحاولة مجددًا.';

  @override
  String get errorServerTitle => 'الخادم غير متاح';

  @override
  String get errorServerMessage => 'هناك مشكلة في الخادم الآن. حاول لاحقًا.';

  @override
  String get errorGenericTitle => 'حدث خطأ';

  @override
  String get errorGenericMessage => 'يرجى المحاولة مرة أخرى.';

  @override
  String get validationRequired => 'هذا الحقل مطلوب.';

  @override
  String get validationEmail => 'يرجى إدخال بريد إلكتروني صحيح.';

  @override
  String get validationPasswordWeak =>
      'يجب أن تحتوي كلمة المرور على أحرف كبيرة وصغيرة وأرقام.';

  @override
  String validationMinLength(int min) {
    return 'يجب ألا يقل الطول عن $min أحرف.';
  }

  @override
  String validationMaxLength(int max) {
    return 'يجب ألا يزيد الطول عن $max أحرف.';
  }

  @override
  String get validationPhone => 'يرجى إدخال رقم هاتف صحيح.';

  @override
  String validationNumericRange(String min, String max) {
    return 'يجب أن تكون القيمة بين $min و $max.';
  }

  @override
  String get validationMismatch => 'القيم غير متطابقة.';

  @override
  String get uiKitLocaleSectionTitle => 'اللغة واتجاه النص';

  @override
  String get uiKitLocaleSectionSubtitle => 'معاينة سلوك اللغة واتجاه الكتابة';

  @override
  String get uiKitLocaleLabel => 'اللغة';

  @override
  String get uiKitDirectionLabel => 'الاتجاه';

  @override
  String get uiKitDirectionRtl => 'يمين إلى يسار';

  @override
  String get uiKitDirectionLtr => 'يسار إلى يمين';

  @override
  String get uiKitStorybookControlsTitle => 'أدوات Storybook';

  @override
  String get uiKitStorybookControlsSubtitle =>
      'عاين المكونات تحت أحجام شاشة واتجاهات نص مختلفة';

  @override
  String get uiKitViewportLabel => 'حجم العرض';

  @override
  String get uiKitViewportAdaptive => 'تلقائي';

  @override
  String get uiKitViewportPhone => 'هاتف';

  @override
  String get uiKitViewportTablet => 'جهاز لوحي';

  @override
  String get uiKitViewportDesktop => 'سطح المكتب';

  @override
  String get uiKitTextScaleLabel => 'مقياس النص';

  @override
  String get uiKitRtlPreviewLabel => 'فرض معاينة RTL';

  @override
  String get uiKitRtlPreviewHelp =>
      'استخدم هذا لاختبار التخطيطات المعكوسة بدون تغيير لغة التطبيق';

  @override
  String get uiKitButtonsSectionTitle => 'الأزرار';

  @override
  String get uiKitButtonsSectionSubtitle =>
      'أزرار أساسية وثانوية وخطرة ورابط وأيقونة';

  @override
  String get uiKitPrimaryAction => 'أساسي';

  @override
  String get uiKitLoadingAction => 'جارٍ التحميل';

  @override
  String get uiKitSecondaryAction => 'ثانوي';

  @override
  String get uiKitTextLinkAction => 'رابط نصي';

  @override
  String get uiKitLikeTooltip => 'إعجاب';

  @override
  String get uiKitInputsSectionTitle => 'حقول الإدخال';

  @override
  String get uiKitInputsSectionSubtitle => 'نص وكلمة مرور وبحث وقائمة منسدلة';

  @override
  String get uiKitNameLabel => 'الاسم';

  @override
  String get uiKitNameHint => 'أدخل اسمك';

  @override
  String get uiKitPasswordLabel => 'كلمة المرور';

  @override
  String get uiKitPasswordHint => 'أدخل كلمة المرور';

  @override
  String get uiKitShowPassword => 'إظهار كلمة المرور';

  @override
  String get uiKitHidePassword => 'إخفاء كلمة المرور';

  @override
  String get uiKitClearSearch => 'مسح البحث';

  @override
  String get uiKitRoleLabel => 'الدور';

  @override
  String get uiKitRoleHint => 'اختر الدور';

  @override
  String get uiKitRoleUser => 'مستخدم';

  @override
  String get uiKitRoleAdmin => 'مشرف';

  @override
  String get uiKitRoleReviewer => 'مراجع';

  @override
  String get uiKitStatesSectionTitle => 'حالات الواجهة';

  @override
  String get uiKitStatesSectionSubtitle =>
      'معاينة حالات التحميل والفراغ والخطأ والمحتوى';

  @override
  String get uiKitStateLoadingLabel => 'تحميل';

  @override
  String get uiKitStateEmptyLabel => 'فارغ';

  @override
  String get uiKitStateErrorLabel => 'خطأ';

  @override
  String get uiKitStateContentLabel => 'محتوى';

  @override
  String get uiKitStateContentTitle => 'حالة المحتوى';

  @override
  String get uiKitStateContentMessage => 'هذه هي حالة العرض الطبيعية للمحتوى.';

  @override
  String get uiKitMediaSectionTitle => 'الوسائط والهياكل الوهمية';

  @override
  String get uiKitMediaSectionSubtitle =>
      'مكوّن صور الشبكة والعناصر النائبة أثناء التحميل';

  @override
  String get uiKitNetworkImageLabel => 'AppNetworkImage';

  @override
  String get uiKitSkeletonCardLabel => 'هيكل بطاقة';

  @override
  String get uiKitSkeletonListLabel => 'هيكل قائمة';

  @override
  String get uiKitSkeletonDetailsLabel => 'هيكل تفاصيل';

  @override
  String get uiKitLayoutSectionTitle => 'مكونات التخطيط';

  @override
  String get uiKitLayoutSectionSubtitle => 'أنماط البطاقات والعناصر والفواصل';

  @override
  String get uiKitListItemTitle => 'عنصر AppListTile';

  @override
  String get uiKitListItemSubtitle =>
      'عنصر قائمة قابل لإعادة الاستخدام بإعدادات الثيم';

  @override
  String get uiKitThemeTokensTitle => 'تطبيق توكنات الثيم';

  @override
  String get uiKitThemeTokensSubtitle =>
      'المسافات والانحناءات من توكنات مركزية';

  @override
  String get uiKitFeedbackSectionTitle => 'التغذية الراجعة والتنقل';

  @override
  String get uiKitFeedbackSectionSubtitle =>
      'حوارات وصفائح وتوست ونموذج تنقل سفلي';

  @override
  String get uiKitShowToastAction => 'عرض توست';

  @override
  String get uiKitShowDialogAction => 'عرض حوار تأكيد';

  @override
  String get uiKitShowBottomSheetAction => 'عرض Bottom Sheet';

  @override
  String get uiKitShowSelectionSheetAction => 'عرض شيت اختيار';

  @override
  String get uiKitShowConfirmationSheetAction => 'عرض شيت تأكيد';

  @override
  String get uiKitOpenBottomNavDemoAction => 'فتح تجربة التنقل السفلي';

  @override
  String get uiKitBottomNavTitle => 'قالب التنقل السفلي';

  @override
  String get uiKitHomeTab => 'الرئيسية';

  @override
  String get uiKitOrdersTab => 'الطلبات';

  @override
  String get uiKitProfileTab => 'الملف الشخصي';

  @override
  String get uiKitStatusSectionTitle => 'لافتات الحالة';

  @override
  String get uiKitStatusSectionSubtitle =>
      'لافتات مضمنة للنجاح والتحذير والمعلومات';

  @override
  String get uiKitSuccessTitle => 'نجاح';

  @override
  String get uiKitSuccessMessage => 'تم تحديث الملف الشخصي بنجاح.';

  @override
  String get uiKitWarningTitle => 'تحذير';

  @override
  String get uiKitWarningMessage =>
      'يتم استخدام بيانات مخزنة مؤقتًا أثناء عدم الاتصال.';

  @override
  String get uiKitInfoTitle => 'معلومة';

  @override
  String get uiKitInfoMessage => 'اضغط الإجراء لفتح شيت معلومات.';

  @override
  String get uiKitLearnMoreAction => 'اعرف المزيد';

  @override
  String get uiKitInfoSheetMessage =>
      'هذه لافتة حالة مضمنة قابلة لإعادة الاستخدام.';

  @override
  String get uiKitPermissionsSectionTitle => 'الصلاحيات';

  @override
  String get uiKitPermissionsSectionSubtitle =>
      'سلوك آمن عند عدم تهيئة مزودات الصلاحيات';

  @override
  String get uiKitPermissionLabel => 'الصلاحية';

  @override
  String get uiKitCheckAction => 'تحقق';

  @override
  String get uiKitRequestAction => 'طلب';

  @override
  String get uiKitNoDetails => 'لا توجد تفاصيل.';

  @override
  String get uiKitPermissionResultPrefix => 'نتيجة الصلاحية';

  @override
  String get uiKitBottomSheetTitle => 'عنوان Bottom Sheet';

  @override
  String get uiKitBottomSheetMessage =>
      'هذا غلاف Bottom Sheet قابل لإعادة الاستخدام.';

  @override
  String get uiKitConfirmActionTitle => 'تأكيد الإجراء';

  @override
  String get uiKitConfirmActionMessage => 'هذا الحوار جزء من UI Kit المشتركة.';

  @override
  String get uiKitSelectionSheetTitle => 'اختر إجراءً واحدًا';

  @override
  String get uiKitArchiveAction => 'أرشفة';

  @override
  String get uiKitPinAction => 'تثبيت';

  @override
  String get uiKitDeleteAction => 'حذف';

  @override
  String get uiKitSelectedPrefix => 'تم الاختيار';

  @override
  String get uiKitDestructiveTitle => 'تأكيد إجراء حذفي';

  @override
  String get uiKitDestructiveMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get openDemandsTitle => 'فتح مطالبة';

  @override
  String get openDemandsStepLocation => 'الموقع';

  @override
  String get openDemandsStepEvidence => 'الأدلة';

  @override
  String get openDemandsStepReview => 'المراجعة';

  @override
  String get openDemandsLocationBadge => 'تفعيل الموقع';

  @override
  String get openDemandsLocationHeading => 'نحتاج موقعك الحالي';

  @override
  String get openDemandsLocationDescription =>
      'يساعدنا موقعك وقت تقديم المطالبة على توثيق ظروفها، ويدعم فريق المراجعة عند دراسة ملفك. نستخدمه لهذه المطالبة فقط.';

  @override
  String get openDemandsAllowLocation => 'السماح بالموقع';

  @override
  String get openDemandsNotNow => 'ليس الآن';

  @override
  String get openDemandsLocationGranted => 'تم السماح بالوصول إلى الموقع.';

  @override
  String get openDemandsLocationDenied => 'لم يتم السماح بالوصول إلى الموقع.';

  @override
  String get openDemandsLocationUnavailable =>
      'الوصول إلى الموقع غير مهيأ على هذا الجهاز حاليًا.';

  @override
  String get openDemandsLocationDisabledBadge => 'الموقع غير مفعل';

  @override
  String get openDemandsLocationDeclinedHeading =>
      'عدم مشاركة موقعك قد يؤثر على تقييم مطالبتك';

  @override
  String get openDemandsLocationDeclinedDescription =>
      'معلومة الموقع تساعد في توضيح ظروف المطالبة. إذا تابعت بدونها، لن تكون متاحة لفريق حصين أثناء المراجعة، ويمكنك مع ذلك إكمال طلبك بشكل طبيعي.';

  @override
  String get openDemandsContinueWithoutLocation => 'المتابعة بدون الموقع';

  @override
  String get demandDetailsLocationUnavailable =>
      'الموقع غير متاح، تم تسجيل ذلك في الطلب';

  @override
  String get demandDetailsLocationAvailable => 'تم تسجيل موقعك في الطلب';

  @override
  String get demandDetailsHeading => 'خلّنا نوثّق حالة الشحنة';

  @override
  String get demandDetailsDescription =>
      'بعض الصور وفيديو قصير تكفي لتوثيق حالة الشحنة بوضوح. نرشدك في كل خطوة.';

  @override
  String get demandDetailsEvidenceDocuments => 'الملصق والمستندات';

  @override
  String get demandDetailsEvidencePackaging => 'التغليف والمنتج';

  @override
  String get demandDetailsEvidenceDamageVideo => 'فيديو قصير يوضح مناطق الضرر';

  @override
  String get demandDetailsOnePhoto => 'صورة واحدة';

  @override
  String get demandDetailsAboutTenSeconds => 'حوالي ١٠ ثوانٍ';

  @override
  String get demandDetailsOptionalImages => 'صور إضافية (اختياري*)';

  @override
  String get demandDetailsAddImage => 'إضافة صورة';

  @override
  String get demandDetailsStartDocumentation => 'ابدأ التوثيق';

  @override
  String get demandDetailsContinueDocumentation => 'استكمال التوثيق';

  @override
  String get demandDetailsNextReview => 'التالي: مراجعة الطلب';

  @override
  String get demandDetailsRetake => 'إعادة التصوير';

  @override
  String get demandDetailsReviewComingSoon =>
      'مراجعة الطلب ستتاح عند تفعيل مسار المطالبات.';

  @override
  String get demandDetailsUploadComingSoon =>
      'إرفاق الصور سيتاح عند تفعيل خدمة المطالبات.';

  @override
  String get cameraPermissionHeading => 'نحتاج إذن الكاميرا';

  @override
  String get cameraPermissionDescription =>
      'نستخدم الكاميرا فقط لتوثيق حالة الشحنة داخل ملف مطالبتك. فعّل الإذن من إعدادات التطبيق أو الجهاز، ثم حاول مرة أخرى.';

  @override
  String get cameraPermissionDeniedDescription =>
      'تم رفض إذن الكاميرا. افتح إعدادات التطبيق لتفعيله، ثم ارجع وحاول مرة أخرى.';

  @override
  String get cameraCaptureFailedDescription =>
      'تعذر فتح الكاميرا. تحقق من توفرها وحاول مرة أخرى.';

  @override
  String get cameraPermissionAllow => 'السماح بالكاميرا';

  @override
  String get cameraPermissionOpenSettings => 'فتح الإعدادات';

  @override
  String get cameraGuideTitle => 'صوّر الملصق والمستندات';

  @override
  String get cameraGuideQuestion => 'ماذا تصوّر؟';

  @override
  String get cameraGuideDocuments =>
      'ملصق الشحنة، رقم التتبع وأي مستندات مرفقة';

  @override
  String get cameraGuidePackaging => 'التغليف والمنتج من زوايا واضحة';

  @override
  String get cameraGuideDamage => 'فيديو قصير يوضح مناطق الضرر';

  @override
  String get cameraGuideReady => 'جاهز';

  @override
  String get cameraCapture => 'التقاط';

  @override
  String get cameraFlash => 'الفلاش';

  @override
  String get cameraSwitch => 'تبديل الكاميرا';

  @override
  String get cameraRecording => 'جارٍ التسجيل';

  @override
  String get cameraCaptureError =>
      'تعذر تشغيل الكاميرا. تحقق من الإذن وحاول مرة أخرى.';

  @override
  String get cameraRetry => 'إعادة المحاولة';

  @override
  String get cameraPhotoLooksClear => 'الصورة واضحة ✓';

  @override
  String get cameraUsePhoto => 'استخدام الصورة';

  @override
  String get cameraRetakePhoto => 'إعادة التصوير';

  @override
  String get cameraExitTitle => 'هل تريد الخروج؟';

  @override
  String get cameraExitDescription =>
      'لن يتم حفظ الأدلة أو المعلومات التي أضفتها في هذه المطالبة، وستحتاج للبدء من جديد لاحقًا.';

  @override
  String get cameraContinueClaim => 'متابعة المطالبة';

  @override
  String get cameraExitClaim => 'الخروج';

  @override
  String get cameraVideoLooksClear => 'الفيديو واضح ✓';

  @override
  String get cameraUseVideo => 'استخدام الفيديو';

  @override
  String get cameraRetakeVideo => 'إعادة التصوير';

  @override
  String get cameraPhotoCaptured => 'تم التقاط الصورة وإضافتها للمطالبة.';

  @override
  String get navigationBack => 'رجوع';

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get close => 'إغلاق';
}
