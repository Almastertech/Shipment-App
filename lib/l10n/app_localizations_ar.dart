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
    return 'أرسلنا رمزاً مكوناً من 4 أرقام إلى $contact';
  }

  @override
  String otpPhoneDestination(Object contact) {
    return 'أرسلنا رمزًا من ٤ أرقام إلى جوالك المنتهي بـ $contact';
  }

  @override
  String otpEmailDestination(Object contact) {
    return 'أرسلنا رمزاً من 4 أرقام إلى $contact';
  }

  @override
  String get otpPhoneLengthHint => 'أدخل الرمز المكوّن من 4 أرقام';

  @override
  String get otpEmailLengthHint => 'أدخل الرمز المكوّن من 4 أرقام';

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
  String get otpSubtitle => 'أرسلنا رمزاً مكوناً من 4 أرقام إلى رقمك';

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
  String get homeTitle => 'شحناتك ماشية على خير';

  @override
  String get homeHeroGreeting => 'هلا والله 👋';

  @override
  String get homeUserName => 'عبدالله التميمي';

  @override
  String get homeHeroDescription => 'وحنا معك خطوة خطوة لين توصل باب بيتك';

  @override
  String get homeHeroShipmentDelivery => 'توصلك الجمعة، ١ أكتوبر';

  @override
  String get homeHeroShipmentAction => 'تابعها';

  @override
  String get homeShipmentStatusHeadline => 'حصين: بالطريق لك';

  @override
  String get homeMoreShipmentsTitle => 'شحناتك الثانية';

  @override
  String get homeSeeAll => 'شوف الكل';

  @override
  String get homeActiveShipments => 'شحناتك النشطة';

  @override
  String get myShipmentsSubtitle =>
      'تغطية للتلف والفقدان والتأخير في شحنات التاجر';

  @override
  String get myShipmentsActiveTab => 'نشطة 2';

  @override
  String get myShipmentsDeliveredTab => 'وصلتك 1';

  @override
  String get shipmentsScreenTitle => 'شحناتي';

  @override
  String get shipmentsScreenSubtitle => 'عندك شحنتين بالطريق، وكلها محمية';

  @override
  String get shipmentsDeliveredSubtitle =>
      'شحناتك اللي وصلتك، والمطالبة متاحة لك';

  @override
  String get shipmentDeliveredStatus => '✓ وصلتك';

  @override
  String get shipmentDeliveredAt => 'وصلتك';

  @override
  String get shipmentDeliveredDate => 'الاثنين 27 سبتمبر';

  @override
  String get shipmentDeliveredClaimHint =>
      'لاحظت شي؟ تقدر تفتح مطالبة لين 11 أكتوبر';

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
  String get homeCompactShipmentProduct => 'سماعات لاسلكية';

  @override
  String get homeCompactShipmentMerchant => 'متجر جرير';

  @override
  String get homeCompactShipmentPrice => '٣٢٠ ر.س';

  @override
  String get homeCompactShipmentStatus => 'يتجهز';

  @override
  String get homeCompactShipmentDelivery => 'توصلك الأحد ٥ أكتوبر';

  @override
  String get homeCompactShipmentTrackingLabel => 'تتبع:';

  @override
  String get homeCompactShipmentTrackingNumber => 'HS-3107';

  @override
  String get homeCompactShipment2Product => 'عطر رجالي 100 مل';

  @override
  String get homeCompactShipment2Merchant => 'متجر المجد للعود';

  @override
  String get homeCompactShipment2Price => '٦٥٠ ر.س';

  @override
  String get homeCompactShipment2Status => 'بالطريق';

  @override
  String get homeCompactShipment2Delivery => 'توصلك بكرة';

  @override
  String get homeCompactShipment2TrackingNumber => 'HS-2990';

  @override
  String get shipmentDetailsTitle => 'تفاصيل الشحنة';

  @override
  String get shipmentDetailsInTransitLabel => 'بالطريق لك';

  @override
  String get shipmentDetailsBack => 'رجوع';

  @override
  String get shipmentDetailsShare => 'مشاركة الشحنة';

  @override
  String get shipmentProtectionTitle => 'حصين ماسك ظهرك';

  @override
  String get shipmentProtectionCoveredBy =>
      'شحناتك محمية من التلف والفقدان لين توصلك';

  @override
  String get shipmentProtectionValueLabel => 'قيمة الحماية';

  @override
  String get shipmentProtectionValue => '480 ر.س';

  @override
  String get shipmentProtectionStatusLabel => 'التغطية';

  @override
  String get shipmentProtectionStatus => 'تلف وفقدان';

  @override
  String get shipmentProtectionRemainingLabel => 'المطالبة';

  @override
  String get shipmentProtectionRemaining => 'بعد الاستلام';

  @override
  String get shipmentProtectionClaimAction =>
      'تقدر تفتح مطالبة أول ما توصلك الشحنة';

  @override
  String get shipmentTimelineTitle => 'وين وصلت شحنتك؟';

  @override
  String get shipmentTimelineOrdered => 'تم الطلب';

  @override
  String get shipmentTimelineShipped => 'طلعت من المستودع';

  @override
  String get shipmentTimelineInTransit => 'بالطريق لك';

  @override
  String get shipmentTimelineDelivered => 'توصلك';

  @override
  String get shipmentTimelineOrderDate => '1 أكتوبر';

  @override
  String get shipmentTimelineOrderedDate => 'الثلاثاء 28 سبتمبر';

  @override
  String get shipmentTimelineShippedDate => 'الأربعاء 29 سبتمبر · الرياض';

  @override
  String get shipmentTimelineInTransitDate => 'الحين · المندوب في طريقه إليك';

  @override
  String get shipmentTimelineDeliveryDate => 'الجمعة 1 أكتوبر';

  @override
  String get shipmentDetailsSectionTitle => 'تفاصيل الشحنة';

  @override
  String get shipmentDetailsExpectedDelivery => 'التسليم المتوقع';

  @override
  String get shipmentDetailsExpectedDeliveryValue => 'الجمعة 1 أكتوبر';

  @override
  String get shipmentDetailsMerchant => 'التاجر';

  @override
  String get shipmentDetailsOrderDate => 'تاريخ الطلب';

  @override
  String get shipmentDetailsOrderDateValue => 'الثلاثاء 28 سبتمبر';

  @override
  String get shipmentDetailsProduct => 'المنتج';

  @override
  String get shipmentDetailsProductValue => 'ساعة ذكية – إصدار ذهبي';

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
  String get homeRequestTitle => 'عطر رجالي 100 مل · نيس ون';

  @override
  String get homeRequestDescription =>
      'صوّر المنتج والتغليف بوضوح عشان نكمل مراجعة مطالبتك بسرعة.';

  @override
  String get homeRequestStepReceived => 'استلمناها';

  @override
  String get homeRequestStepReview => 'نراجعها';

  @override
  String get homeRequestStepDecision => 'القرار';

  @override
  String get homeRequestStepCompensation => 'التعويض';

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
      'نراجع الحين صورة وتفاصيل مطالبتك، وما يحتاج منك شيء ثاني.';

  @override
  String get homeSecondaryRequestAmountLabel => 'قيمة الطلب';

  @override
  String get homeSecondaryRequestAction => 'تابع المطالبة';

  @override
  String get requestsScreenTitle => 'مطالباتك';

  @override
  String get requestsOpenSubtitle =>
      'عندك 3 مطالبات مفتوحة، وحدة منها تحتاج خطوة منك';

  @override
  String get requestsClosedSubtitle => 'مطالباتك اللي انتهت، وش صار فيها';

  @override
  String get requestsOpenTab => 'مفتوحة • 3';

  @override
  String get requestsClosedTab => 'مغلقة • 2';

  @override
  String get requestsSecondOpenNumber => 'HS-1931';

  @override
  String get requestsSecondOpenTitle => 'سماعات لاسلكية برو · جرير';

  @override
  String get requestsOpenClaimAmount => '320 ر.س';

  @override
  String get requestsClaimAmountLabel => 'قيمة المطالبة';

  @override
  String get requestsClosedRejectedNumber => 'HS-1874';

  @override
  String get requestsClosedRejectedTitle => 'عطر رجالي · 20 أغسطس';

  @override
  String get requestsClosedAcceptedStatus => 'انقبلت';

  @override
  String get requestsClosedRejectedStatus => 'انرفضت';

  @override
  String get requestsCompensationLabel => 'تعويضات';

  @override
  String get requestsItemValueLabel => 'قيمة السلعة';

  @override
  String get requestsAcceptedCompensation => '65 ر.س';

  @override
  String get requestsRejectedCompensation => '—';

  @override
  String get requestsClosedItemValue => '480 ر.س';

  @override
  String get requestsAcceptedMessage => 'يرجع المبلغ لبطاقتك خلال 3–5 أيام';

  @override
  String get requestsRejectedMessage => 'نبي توضيح أكثر، كلم الدعم';

  @override
  String get requestsDetailsAction => 'التفاصيل';

  @override
  String get requestsDetailsComingSoon => 'تفاصيل المطالبة ستتاح قريبًا.';

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
  String get secondaryBannerTitle => 'وش تغطي حماية حصين؟';

  @override
  String get secondaryBannerDescription =>
      'التلف والفقدان والتأخير في شحنات التاجر المؤهلة.';

  @override
  String get secondaryBannerAction => 'اقرأ أكثر';

  @override
  String get bottomNavHome => 'الرئيسية';

  @override
  String get bottomNavShipments => 'شحناتي';

  @override
  String get bottomNavOrders => 'الطلبات';

  @override
  String get bottomNavClaims => 'المطالبات';

  @override
  String get bottomNavStores => 'التاجر';

  @override
  String get merchantHeroTitle => 'متاجر تثق فيها';

  @override
  String get merchantHeroSubtitle =>
      'تسوق من شركائنا، وشحناتك محمية من الباب للباب.';

  @override
  String get merchantSearchHint => 'دور على متجر...';

  @override
  String get merchantTrustTitle => 'كل متاجرنا محمية بحصين';

  @override
  String get merchantTrustDescription =>
      'تسوق من أي متجر شريك، وخلي حماية شحنتك من صفحة الدفع.';

  @override
  String get merchantMetricPartners => 'متجر شريك';

  @override
  String get merchantMetricCategories => 'أقسام';

  @override
  String get merchantMetricDays => 'لتقديم المطالبة';

  @override
  String get merchantDaysValue => 'يومين';

  @override
  String get merchantProtectionPromise =>
      'تلف، فقدان، أو تأخير مؤهل؟ مطالبتك من التطبيق مباشرة.';

  @override
  String get merchantFeaturedTitle => 'متاجر مميزة';

  @override
  String get merchantSeeAll => 'شوف الكل';

  @override
  String get merchantProtectionAvailable => 'الحماية متاحة';

  @override
  String get merchantFeaturedStore => 'متجر مدار';

  @override
  String get merchantFeaturedCategory => 'إلكترونيات وإكسسوارات';

  @override
  String get merchantShopNow => 'تسوق من مدار';

  @override
  String get merchantAllStores => 'كل المتاجر';

  @override
  String get merchantStoreCount => '+40 متجر';

  @override
  String get merchantFashionStore => 'متجر خطى';

  @override
  String get merchantFashionCategory => 'أزياء ومنتجات يومية';

  @override
  String get merchantPerfumeStore => 'دار العود';

  @override
  String get merchantPerfumeCategory => 'عطور وبخور';

  @override
  String get merchantCafeStore => 'محمصة الديرة';

  @override
  String get merchantCafeCategory => 'قهوة ومحامص مختصة';

  @override
  String get merchantJoinTitle => 'عندك متجر؟ خلّ عملاءك يشترون بثقة';

  @override
  String get merchantJoinDescription =>
      'أضف حصين لتجارتك، وقدّم حماية شحن لعملائك بدون أي تعقيد.';

  @override
  String get merchantJoinAction => 'أضف حصين لمتجرك';

  @override
  String get bottomNavProfile => 'حسابي';

  @override
  String get profileScreenTitle => 'حسابي';

  @override
  String get profileScreenSubtitle => 'معلوماتك وإعداداتك في مكان واحد';

  @override
  String get profilePhone => '+966 55 012 3487';

  @override
  String get profileStatCompensations => 'تعويضاتك';

  @override
  String get profileStatCompensationsValue => '480 ر.س';

  @override
  String get profileStatClaims => 'مطالباتك';

  @override
  String get profileStatClaimsValue => '7';

  @override
  String get profileStatShipments => 'شحناتك';

  @override
  String get profileStatShipmentsValue => '12';

  @override
  String get profileSectionGeneral => 'عام';

  @override
  String get profileActivity => 'نشاطك';

  @override
  String get profileNotifications => 'الإشعارات';

  @override
  String get profileSectionSupport => 'الدعم والمساعدة';

  @override
  String get profileSupportTickets => 'تذاكر الدعم';

  @override
  String get profileBlog => 'المدونة';

  @override
  String get profileFaq => 'الأسئلة الشائعة';

  @override
  String get profileSectionLegal => 'قانوني';

  @override
  String get profileTerms => 'الشروط والأحكام';

  @override
  String get profilePrivacy => 'سياسة الخصوصية';

  @override
  String get profileProtectionTerms => 'شروط الحماية';

  @override
  String get profileSectionAccount => 'الحساب';

  @override
  String get profileLogout => 'سجّل خروجك';

  @override
  String get profileDeleteAccount => 'احذف حسابك';

  @override
  String get profileLogoutTitle => 'تيجي تطلع من حسابك؟';

  @override
  String get profileLogoutMessage =>
      'تقدر ترجع تدخل بأي وقت برقم جوالك أو إيميلك.';

  @override
  String get profileLogoutConfirm => 'إيه، سجّل خروجي';

  @override
  String get profileLogoutCancel => 'لا، خلّني';

  @override
  String get profileDeleteHeroTitle => 'احذف حسابك';

  @override
  String get profileDeleteSubtitle => 'قرار نهائي، فخذ وقتك قبل تأكده';

  @override
  String get profileDeleteTitle => 'متأكد تي تحذف حسابك؟';

  @override
  String get profileDeleteMessage =>
      'بتفقد وصولك لحسابك، وكل شحناتك ومطالباتك بتنشال معه. ما تقدر ترجعها بعدين.';

  @override
  String get profileDeleteNameLabel => 'اسم الحساب';

  @override
  String get profileDeletePhoneLabel => 'رقم الجوال';

  @override
  String get profileDeleteConfirm => 'احذف حسابي نهائياً';

  @override
  String get profileDeleteCancel => 'خلّني، ما أبي أحذفه';

  @override
  String get profileDeleteBack => 'رجوع';

  @override
  String get profileDeleteUnavailable => 'خدمة حذف الحساب غير متاحة حالياً.';

  @override
  String profileVersion(String version) {
    return 'حصين • الإصدار $version';
  }

  @override
  String get profileCredits => 'صُنع بحب 🩶 بواسطة الماستر - AL Master';

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
  String get openDemandsWhyLocationHeading => 'ليش نحتاج موقعك؟';

  @override
  String get openDemandsLocationBenefitOne => 'يوثّق ظروف مطالبتك وقت تقديمها';

  @override
  String get openDemandsLocationBenefitTwo =>
      'يساعد فريق المراجعة يدرس ملفك أسرع';

  @override
  String get openDemandsLocationBenefitThree =>
      'نستخدمه للمطالبة بس، وما نشاركه مع أحد';

  @override
  String get openDemandsStepLocation => 'الموقع';

  @override
  String get openDemandsStepEvidence => 'الأدلة';

  @override
  String get openDemandsStepReview => 'المراجعة';

  @override
  String get openDemandsLocationBadge => 'تفعيل الموقع';

  @override
  String get openDemandsLocationHeading => 'وين أنت الحين؟';

  @override
  String get openDemandsLocationDescription =>
      'نحتاج موقعك الحالي عشان نوثق ظروف مطالبتك';

  @override
  String get openDemandsAllowLocation => 'اسمح بالموقع';

  @override
  String get openDemandsNotNow => 'مو الحين';

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
  String get openDemandsSkippedWarningTitle =>
      'بدون موقعك، ممكن يتأثر تقييم مطالبتك';

  @override
  String get openDemandsSkippedWarningDescription =>
      'الموقع يوضّح ظروف المطالبة لفريق حصين وقت المراجعة. لو كملت بدونه، تقدر تقدم طلبك عادي.';

  @override
  String get openDemandsContinueWithoutLocation => 'كمّل بدون الموقع';

  @override
  String get demandDetailsLocationUnavailable =>
      'ما قدرنا نحدد موقعك، وسجلناه بالطلب';

  @override
  String get demandDetailsLocationAvailable => 'تم تسجيل موقعك في الطلب';

  @override
  String get demandDetailsHeading => 'خلنا نوثق حالة شحنتك';

  @override
  String get demandDetailsDescription =>
      'كم صورة وفيديو قصير يكفون، وحنا نوجهك لقطة لقطة';

  @override
  String get demandDetailsEvidenceQuestion => 'وش بنصور؟';

  @override
  String get demandDetailsEvidenceAdded => 'تم إرفاق الدليل';

  @override
  String get demandDetailsEvidenceDocuments => 'الملصق والمستندات';

  @override
  String get demandDetailsEvidencePackaging => 'التغليف والمنتج';

  @override
  String get demandDetailsEvidenceDamageVideo => 'فيديو قصير للضرر';

  @override
  String get demandDetailsDocumentsHint => 'صورة وحدة للملصق ورقم التتبع';

  @override
  String get demandDetailsPackagingHint => 'صورة وحدة توضح الضرر';

  @override
  String get demandDetailsVideoHint => 'حوالي 10 ثواني';

  @override
  String get demandDetailsOnePhoto => 'صورة واحدة';

  @override
  String get demandDetailsAboutTenSeconds => 'حوالي ١٠ ثوانٍ';

  @override
  String get demandDetailsOptionalImages => 'صور إضافية (اختياري)';

  @override
  String get demandDetailsAddImage => 'إضافة صورة';

  @override
  String get demandDetailsStartDocumentation => 'يلا نبدأ التوثيق';

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
  String get demandReviewHeading => 'راجع مطالبتك وارسلها';

  @override
  String get demandReviewDescription =>
      'تأكد من التفاصيل، وبعدها فريق حصين يستلمها';

  @override
  String get demandReviewLocationTitle => 'موقعك';

  @override
  String get demandReviewLocationMissing => 'ما فعلت الموقع';

  @override
  String get demandReviewLocationMissingDescription =>
      'ممكن يأثر على تقييم مطالبتك';

  @override
  String get demandReviewLocationCurrent => 'موقعك الحالي';

  @override
  String get demandReviewLocationEnable => 'فعّله';

  @override
  String get demandReviewEvidenceTitle => 'الأدلة';

  @override
  String demandReviewFileCount(int count) {
    return '$count ملفات ✓';
  }

  @override
  String get demandReviewLabelPhoto => 'للتلف';

  @override
  String get demandReviewPackagingPhoto => 'التغليف';

  @override
  String get demandReviewVideo => 'فيديو';

  @override
  String get demandReviewAdditionalPhoto => 'إضافية';

  @override
  String get demandReviewDescriptionTitle => 'وش صار للمنتج؟';

  @override
  String get demandReviewDescriptionHint =>
      'اوصف الضرر هنا... مثلاً: الشاشة فيها شخ';

  @override
  String demandReviewCharacterCount(int count) {
    return '$count/300';
  }

  @override
  String get demandReviewSubmit => 'أرسل المطالبة';

  @override
  String get demandReviewSubmitComingSoon =>
      'إرسال المطالبة سيتاح عند تفعيل خدمة المطالبات.';

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
  String get cameraPermissionNotNow => 'مو الحين';

  @override
  String get cameraGuideTitle => 'صوّر الملصق والمستندات';

  @override
  String get cameraGuideQuestion => 'ماذا تصوّر؟';

  @override
  String get cameraGuidePhotoHint =>
      'لقطة وحدة واضحة تكفي، تأكد إن الكلام مقروء';

  @override
  String get cameraGuideShippingLabel => 'ملصق الشحن';

  @override
  String get cameraGuideTrackingNumber => 'رقم التتبع';

  @override
  String get cameraGuideIncludedDocuments => 'أي مستندات جت مع الطرد';

  @override
  String get cameraHelp => 'مساعدة الكاميرا';

  @override
  String get cameraGuideDocuments =>
      'ملصق الشحنة، رقم التتبع وأي مستندات مرفقة';

  @override
  String get cameraGuidePackaging => 'التغليف والمنتج من زوايا واضحة';

  @override
  String get cameraGuideDamage => 'فيديو قصير يوضح مناطق الضرر';

  @override
  String get cameraGuideReady => 'جاهز، يلا نصوّر';

  @override
  String get cameraCapture => 'التقاط';

  @override
  String get cameraPhotoModeLabel => 'صورة';

  @override
  String get cameraVideoModeLabel => 'فيديو';

  @override
  String get cameraFramingHint => 'قرّب شوي، وخَلّ الملصق كله داخل الإطار';

  @override
  String get cameraVideoFramingHint => 'لف حول الطرد ببطء، وركّز على الضرر';

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
  String get cameraUsePhoto => 'استخدم الصورة';

  @override
  String get cameraRetakePhoto => 'صوّر من جديد';

  @override
  String get cameraExitTitle => 'متأكد تبي تطلع؟';

  @override
  String get cameraExitDescription =>
      'ما راح نحفظ الأدلة اللي أضفتها، وبتحتاج تبدأ المطالبة من جديد.';

  @override
  String get cameraContinueClaim => 'كمّل المطالبة';

  @override
  String get cameraExitClaim => 'اطلع';

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

  @override
  String get profileEditTitle => 'عدّل ملفك';

  @override
  String get profileEditSubtitle => 'خلّ معلوماتك دايماً محدّثة';

  @override
  String get profileEditPhoto => 'غيّر صورتك';

  @override
  String get profileEditFullNameLabel => 'الاسم الكامل';

  @override
  String get profileEditFullName => 'عبدالله العتيبي';

  @override
  String get profileEditPhoneLabel => 'رقم الجوال';

  @override
  String get profileEditPhoneHelper =>
      'لو غيرت رقمك، بنرسل رمز تحقق للرقم الجديد';

  @override
  String get profileEditEmailLabel => 'الإيميل (اختياري)';

  @override
  String get profileEditEmailHint => 'اكتب ايميلك';

  @override
  String get profileEditSave => 'احفظ التعديلات';

  @override
  String get profileEditSaveUnavailable => 'حفظ التعديلات غير متاح حالياً.';

  @override
  String get profileEditPhotoUnavailable => 'تعذر فتح الصور حالياً.';

  @override
  String get notificationSettingsTitle => 'الإشعارات';

  @override
  String get notificationSettingsSubtitle => 'اختار وش يوصلك منا';

  @override
  String get notificationPermissionTitle => 'السماح بالإشعارات';

  @override
  String get notificationPermissionDescription =>
      'فعلها عشان ما يفوتك أي تحديث';

  @override
  String get notificationShipmentTitle => 'تحديثات الشحنات';

  @override
  String get notificationShipmentDescription => 'وين وصلت شحنتك ومتى توصلك';

  @override
  String get notificationClaimTitle => 'تحديثات المطالبات';

  @override
  String get notificationClaimDescription => 'أي جديد في مطالباتك أو تعويضك';

  @override
  String get notificationOffersTitle => 'عروض المتاجر';

  @override
  String get notificationOffersDescription => 'عروض وخصومات من المتاجر الشريكة';

  @override
  String get notificationSettingsNote =>
      'تقدر تغير هالإعدادات بأي وقت، وما راح يفوتك أي شي يخص مطالباتك.';

  @override
  String get activityTitle => 'نشاطك';

  @override
  String get activitySubtitle => 'كل اللي صار في شحناتك ومطالباتك';

  @override
  String get activityFilterAll => 'الكل';

  @override
  String get activityFilterShipments => 'الشحنات';

  @override
  String get activityFilterClaims => 'المطالبات';

  @override
  String get activityLatestFirst => 'الأحدث أولاً';

  @override
  String get activityOldestFirst => 'الأقدم أولاً';

  @override
  String get activityToday => 'اليوم، 6 أكتوبر';

  @override
  String get activityYesterday => 'أمس، 5 أكتوبر';

  @override
  String get activityOctoberThird => '3 أكتوبر';

  @override
  String get activityOctoberSecond => '2 أكتوبر';

  @override
  String get activityOctoberFirst => '1 أكتوبر';

  @override
  String get activityTime1040 => '10:40 ص';

  @override
  String get activityTime0915 => '9:15 ص';

  @override
  String get activityTime0420 => '4:20 م';

  @override
  String get activityTime0210 => '2:10 م';

  @override
  String get activityTime1130 => '11:30 ص';

  @override
  String get activityTime0805 => '8:05 ص';

  @override
  String get activityShipmentOutTitle => 'شحنتك طلعت للتوصيل';

  @override
  String get activityShipmentOutDescription => 'متجر نون • ساعة ذكية • HS-2048';

  @override
  String get activityClaimReviewTitle => 'مطالبتك قيد المراجعة';

  @override
  String get activityClaimReviewDescription => 'نيس ون • عطر رجالي • HS-1874';

  @override
  String get activityCompensationTitle => 'وصلك تعويضك 🎉';

  @override
  String get activityCompensationDescription => '180 ر.س • مطالبة HS-2039';

  @override
  String get activityClaimSubmittedTitle => 'استلمنا مطالبتك';

  @override
  String get activityClaimSubmittedDescription =>
      'نيس ون • عطر رجالي • HS-1874';

  @override
  String get activityShipmentDeliveredTitle => 'تم تسليم شحنتك';

  @override
  String get activityShowOlder => 'شوف النشاط الأقدم';

  @override
  String get activityShowLess => 'إخفاء النشاط الأقدم';

  @override
  String get supportTicketsTitle => 'تذاكر الدعم';

  @override
  String get supportTicketsSubtitle => 'حنا هنا لأي سالفة، وقهوتك علينا ☕';

  @override
  String get supportTicketsStatAll => 'كل التذاكر';

  @override
  String get supportTicketsStatOpen => 'المفتوحة';

  @override
  String get supportTicketsStatResolved => 'المحلولة';

  @override
  String get supportTicketsNewButton => 'افتح تذكرة جديدة';

  @override
  String get supportTicketsFilterAll => 'الكل';

  @override
  String get supportTicketsFilterShipments => 'الشحنات';

  @override
  String get supportTicketsFilterCompensations => 'التعويضات';

  @override
  String get supportTicketsStatusInProgress => 'قيد المعالجة';

  @override
  String get supportTicketsStatusWaiting => 'بانتظار ردّك';

  @override
  String get supportTicketsCompensationTitle => 'تأخر التعويض';

  @override
  String get supportTicketsCompensationSubtitle => '6 أكتوبر 2026 • ST-1052';

  @override
  String get supportTicketsShipmentTitle => 'تحديث بيانات الشحنة';

  @override
  String get supportTicketsShipmentSubtitle => '5 أكتوبر 2026 • ST-1048';

  @override
  String get supportTicketsLastUpdate => 'آخر تحديث';

  @override
  String get supportTicketsUpdateTwoHoursAgo => 'قبل ساعتين';

  @override
  String get supportTicketsUpdateYesterday => 'أمس، 4:30 م';

  @override
  String get supportTicketsCategory => 'التصنيف';

  @override
  String get supportTicketsCompensationCategory => 'التعويضات';

  @override
  String get supportTicketsShipmentCategory => 'الشحنات';

  @override
  String get supportTicketsViewTicket => 'شوف التذكرة';

  @override
  String get supportTicketsViewReply => 'شوف ردّك';

  @override
  String get supportTicketsCreateUnavailable =>
      'فتح تذكرة جديدة غير متاح حالياً.';

  @override
  String get supportTicketsDetailsUnavailable =>
      'عرض تفاصيل التذكرة غير متاح حالياً.';

  @override
  String get supportTicketConversationTitle => 'المحادثة';

  @override
  String supportTicketMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count رسائل',
      two: 'رسالتين',
      one: 'رسالة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get supportTicketConversationDate => '6 أكتوبر 2026';

  @override
  String get supportTicketCustomerMessage =>
      'السلام عليكم، للحين ما وصلني التعويض. وش آخر الأخبار؟';

  @override
  String get supportTicketCustomerMetadata => 'عبدالله • 9:15 ص';

  @override
  String get supportTicketTeamName => 'فريق حصين';

  @override
  String get supportTicketTeamMessage =>
      'وعليكم السلام عبدالله، شكراً على تواصلك. نراجع طلب التعويض مع الفريق المختص، وبنعلمك بكل جديد هنا.';

  @override
  String get supportTicketReplySla => 'فريق حصين يرد عادة خلال 24 ساعة';

  @override
  String get supportTicketReplyHint => 'اكتب ردك هنا...';

  @override
  String get supportTicketAttachFile => 'إرفاق ملف';

  @override
  String get supportTicketSendReply => 'إرسال الرد';

  @override
  String get supportTicketReplyUnavailable => 'إرسال الردود غير متاح حالياً.';

  @override
  String get createSupportTicketTitle => 'تذكرة جديدة';

  @override
  String get createSupportTicketSubtitle =>
      'قول لنا وش صار، ونرد عليك بأسرع وقت';

  @override
  String get createSupportTicketRequiredNote =>
      'الحقول اللي عليها * لازم تتعبّى';

  @override
  String get createSupportTicketCategoryLabel => 'التصنيف *';

  @override
  String get createSupportTicketClaims => 'المطالبات';

  @override
  String get createSupportTicketShipments => 'الشحنات';

  @override
  String get createSupportTicketAccount => 'حسابي';

  @override
  String get createSupportTicketSubjectLabel => 'الموضوع *';

  @override
  String get createSupportTicketSubjectHint => 'مثلاً: تأخر وصول الشحنة';

  @override
  String get createSupportTicketDescriptionLabel => 'وش المشكلة؟ *';

  @override
  String get createSupportTicketDescriptionHint =>
      'اشرح لنا وش صار ومتى، ووش تحتاج نساعدك فيه.';

  @override
  String createSupportTicketCharacterCount(int count, int max) {
    return '$count من $max';
  }

  @override
  String get createSupportTicketShipmentLabel => 'رقم الشحنة (اختياري)';

  @override
  String get createSupportTicketShipmentHint => 'اكتب رقم الشحنة';

  @override
  String get createSupportTicketShipmentHelper =>
      'تلقاه في تفاصيل الشحنة، ويساعدنا نخدمك أسرع';

  @override
  String get createSupportTicketAttachmentsLabel => 'المرفقات (اختياري)';

  @override
  String get createSupportTicketUploadTitle => 'أضف صور أو ملفات';

  @override
  String get createSupportTicketUploadDescription =>
      'لين 5 ملفات، 10 م.ب للملف • JPG, PNG, PDF';

  @override
  String get createSupportTicketRemoveAttachment => 'إزالة الملف';

  @override
  String get createSupportTicketAttachmentLimit =>
      'تقدر ترفق 5 ملفات كحد أقصى.';

  @override
  String get createSupportTicketAttachmentSizeLimit =>
      'حجم الملف الواحد لازم يكون 10 م.ب أو أقل.';

  @override
  String get createSupportTicketPickerError => 'تعذر فتح الملفات حالياً.';

  @override
  String get createSupportTicketRequiredError => 'الحقل مطلوب.';

  @override
  String get createSupportTicketSubmit => 'أرسل التذكرة';

  @override
  String get createSupportTicketSubmitUnavailable =>
      'إرسال التذاكر غير متاح حالياً.';

  @override
  String get claimDetailsTitle => 'مطالبة HS-2048';

  @override
  String get claimDetailsProduct => 'ساعة ذكية – إصدار ذهبي · 12 سبتمبر';

  @override
  String get claimDetailsAccepted => 'انقبلت';

  @override
  String get claimDetailsSuccessTitle => 'أبشر، انقبلت مطالبتك';

  @override
  String get claimDetailsSuccessBody =>
      'حوّلنا تعويضك لبطاقتك، وبوصلك خلال 3–5 أيام';

  @override
  String get claimDetailsSettlement => 'التحويل';

  @override
  String get claimDetailsTimelineTitle => 'مشوار مطالبتك';

  @override
  String get claimDetailsSubmitted => 'أرسلت المطالبة';

  @override
  String get claimDetailsReviewed => 'راجعناها';

  @override
  String get claimDetailsDecision => 'انقبلت 🎉';

  @override
  String get claimDetailsCompensation => 'حوّلنا تعويضك';

  @override
  String get claimDetailsSep6 => '6 سبتمبر';

  @override
  String get claimDetailsSep7 => '7 سبتمبر';

  @override
  String get claimDetailsEvidenceTitle => 'الأدلة اللي أرسلتها';

  @override
  String get claimDetailsAttachment => 'إضافية';

  @override
  String get claimDetailsVideo => 'فيديو';

  @override
  String get claimDetailsPackaging => 'التغليف';

  @override
  String get claimDetailsLabel => 'الملصق';

  @override
  String get claimDetailsLocationTitle => 'موقعك وكلامك';

  @override
  String get claimDetailsLocationCaption => 'موقعك وقت المطالبة';

  @override
  String get claimDetailsLocation => '2415 شارع وادي الساحل، حي الرمال، الرياض';

  @override
  String get claimDetailsNoteTitle => 'وش كتبت لنا';

  @override
  String get claimDetailsNote =>
      '«شاشة الساعة فيها شرخ واضح، والكرتون كان مضغوط من الزاوية.»';

  @override
  String get claimDetailsDetailsTitle => 'تفاصيل المطالبة';

  @override
  String get claimDetailsClaimNumber => 'رقم المطالبة';

  @override
  String get claimDetailsProductLabel => 'المنتج';

  @override
  String get claimDetailsProductName => 'ساعة ذكية – إصدار ذهبي';

  @override
  String get claimDetailsItemPrice => 'سعر المنتج';

  @override
  String get claimDetailsClaimValue => 'قيمة المطالبة';

  @override
  String get claimDetailsShipment => 'الشحنة المرتبطة';

  @override
  String get claimDetailsStore => 'المتجر';

  @override
  String get claimDetailsSubmittedDate => 'تاريخ الإرسال';

  @override
  String get claimDetailsDecisionDate => 'تاريخ القرار';

  @override
  String get claimDetailsTransferDate => 'تاريخ التحويل';

  @override
  String get claimDetailsSubmittedDateValue => '6 سبتمبر 2026';

  @override
  String get claimDetailsDecisionDateValue => '7 سبتمبر 2026';

  @override
  String get claimDetailsTransferDateValue => '7 سبتمبر 2026';

  @override
  String get claimDetailsStoreName => 'متجر نون';

  @override
  String get claimDetailsSeeAll => 'شوف كل التفاصيل';

  @override
  String get claimDetailsHide => 'اخف التفاصيل';
}
