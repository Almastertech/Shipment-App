// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shipments';

  @override
  String get splashBrand => 'Haseen';

  @override
  String get splashTagline => 'Your products, in safe hands.';

  @override
  String get splashFooter =>
      'Protect your shipment from the store to your door.';

  @override
  String get onboardingProtectionLead => 'Enable';

  @override
  String get onboardingProtectionHighlight => 'shipment protection';

  @override
  String get onboardingProtectionTail => 'before checkout';

  @override
  String get onboardingProtectionSubtitle =>
      'Choose Haseen protection at checkout and ship with peace of mind.';

  @override
  String get onboardingTrackingLead => 'Track your';

  @override
  String get onboardingTrackingHighlight => 'shipment';

  @override
  String get onboardingTrackingTail => 'from dispatch to delivery';

  @override
  String get onboardingTrackingSubtitle =>
      'Follow your shipment step by step and know when it will arrive.';

  @override
  String get onboardingClaimTitle => 'Protection that stays with you';

  @override
  String get onboardingClaimSubtitle =>
      'If something goes wrong, we will guide you through a simple claim.';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingSkip => 'Skip intro';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get loginMethodHelp => 'Need help?';

  @override
  String get loginMethodHelpMessage =>
      'Contact our support team for help signing in.';

  @override
  String get loginMethodTitle => 'How would you like to sign in?';

  @override
  String get loginMethodSubtitle =>
      'Use the same phone or email you entered when you activated protection.';

  @override
  String get loginMethodChooseTitle => 'Choose a sign-in method';

  @override
  String get authPrivacyNotice =>
      'By continuing, you agree to our Terms and Privacy Policy';

  @override
  String get loginSendCode => 'Send code';

  @override
  String get loginMethodPhone => 'Phone number';

  @override
  String get loginMethodPhoneDescription =>
      'We’ll send a verification code to the phone number linked to your account.';

  @override
  String get loginMethodEmail => 'Email address';

  @override
  String get loginMethodEmailDescription =>
      'We’ll send a verification code to the email linked to your account.';

  @override
  String get loginMethodContinue => 'Continue';

  @override
  String get loginPhoneTitle => 'Enter your phone number';

  @override
  String get loginPhoneSubtitle =>
      'Use the phone number you entered when you purchased shipment protection.';

  @override
  String get loginPhoneFieldLabel => 'Phone number';

  @override
  String get loginPhoneFieldHint => '5X XXX XXXX';

  @override
  String get loginPhoneFieldHelper =>
      'We’ll send a one-time verification code to your number.';

  @override
  String get loginEmailTitle => 'Enter your email address';

  @override
  String get loginEmailSubtitle =>
      'Use the email address you entered when you purchased shipment protection.';

  @override
  String get loginEmailFieldLabel => 'Email address';

  @override
  String get loginEmailFieldHint => 'name@example.com';

  @override
  String get loginEmailFieldHelper =>
      'We’ll send a one-time verification code to your email.';

  @override
  String get loginPhoneInvalid =>
      'Enter a valid phone number for this country.';

  @override
  String otpDestination(String contact) {
    return 'We sent a 4-digit code to $contact';
  }

  @override
  String otpPhoneDestination(Object contact) {
    return 'We sent a 4-digit code to your number ending in $contact';
  }

  @override
  String otpEmailDestination(Object contact) {
    return 'We sent a 4-digit code to $contact';
  }

  @override
  String get otpPhoneLengthHint => 'Enter the 4-digit code';

  @override
  String get otpEmailLengthHint => 'Enter the 4-digit code';

  @override
  String get countryPickerTitle => 'Choose a country code';

  @override
  String get countryPickerSearchHint => 'Search by country or calling code';

  @override
  String get countryPickerEmpty => 'No countries found';

  @override
  String get sampleFeatureTitle => 'Sample Feature';

  @override
  String get sampleFeatureSubtitle =>
      'Reusable list, details, and state handling';

  @override
  String get searchHint => 'Search items';

  @override
  String get retry => 'Retry';

  @override
  String get noItemsTitle => 'No items found';

  @override
  String get noItemsDescription =>
      'Try changing the search query or pull to refresh.';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get detailsTitle => 'Details';

  @override
  String get changeTheme => 'Toggle theme';

  @override
  String get switchLanguage => 'Switch language';

  @override
  String get logout => 'Logout';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle =>
      'This is a starter login screen. Replace it with your domain auth flow.';

  @override
  String get signInDemo => 'Sign in with demo account';

  @override
  String get openOtpDemo => 'Open OTP demo';

  @override
  String get otpTitle => 'Enter verification code';

  @override
  String get otpVerify => 'Verify';

  @override
  String get otpSubtitle => 'We sent a 4-digit code to your number';

  @override
  String get otpHint => 'Verification code';

  @override
  String get otpResend => 'Resend code';

  @override
  String otpResendCountdown(String time) {
    return 'You can request a new code in $time';
  }

  @override
  String get otpVerificationFailed => 'The code is incorrect. Try again.';

  @override
  String get otpSuccessTitle => 'Verified!';

  @override
  String get otpSuccessMessage =>
      'Just a moment while we take you to your shipment.';

  @override
  String get welcomeTitle => 'Welcome back, Abdullah 👋';

  @override
  String get welcomeDescription =>
      'Your shipment is protected. Track it here, and submit a claim if anything happens.';

  @override
  String get welcomeContinue => 'Enter Haseen';

  @override
  String get welcomeProductTitle => 'Smart watch — Gold edition';

  @override
  String get welcomeProtectionActive => 'Haseen protection';

  @override
  String get accountNotFoundTitle => 'No protection found for these details';

  @override
  String get accountNotFoundBody =>
      'Check that you used the same phone number or email address that you entered when placing your order.';

  @override
  String get accountNotFoundPhone => 'Phone used at purchase';

  @override
  String get accountNotFoundEmail => 'Email used at purchase';

  @override
  String get accountNotFoundCheckEmail =>
      'Check the order confirmation email from the store';

  @override
  String get accountNotFoundTryOtherMethod =>
      'Try the other method (phone or email)';

  @override
  String get accountNotFoundTryAgain => 'Try different details';

  @override
  String get accountNotFoundSupport => 'Contact support';

  @override
  String homeGreeting(String name) {
    return 'Good evening, $name 👋';
  }

  @override
  String get homeTitle => 'Your shipment is in good hands';

  @override
  String get homeHeroGreeting => 'Hello there 👋';

  @override
  String get homeUserName => 'Abdullah Al Tamimi';

  @override
  String get homeHeroDescription =>
      'We are with you every step of the way until it reaches your door.';

  @override
  String get homeHeroShipmentDelivery => 'Arrives Friday, October 1';

  @override
  String get homeHeroShipmentAction => 'Track it';

  @override
  String get homeShipmentStatusHeadline => 'Haseen is on the way with you';

  @override
  String get homeMoreShipmentsTitle => 'Your other shipments';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get homeActiveShipments => 'Your active shipments';

  @override
  String get myShipmentsSubtitle =>
      'Coverage for damage, loss and delays on shipments from partner stores';

  @override
  String get myShipmentsActiveTab => 'Active 2';

  @override
  String get myShipmentsDeliveredTab => 'Delivered 1';

  @override
  String get shipmentsScreenTitle => 'My shipments';

  @override
  String get shipmentsScreenSubtitle =>
      'Two shipments on the way, both protected';

  @override
  String get shipmentsDeliveredSubtitle =>
      'Your delivered shipment, with time to make a claim';

  @override
  String get shipmentDeliveredStatus => '✓ Delivered';

  @override
  String get shipmentDeliveredAt => 'Delivered';

  @override
  String get shipmentDeliveredDate => 'Monday, September 27';

  @override
  String get shipmentDeliveredClaimHint =>
      'Notice an issue? You can file a claim until October 11';

  @override
  String get homeActiveClaims => 'Your active claims';

  @override
  String get homeSeeAllShipments => 'See all';

  @override
  String get homeShipmentStore => 'Noon store';

  @override
  String get homeShipmentProduct => 'Smart watch - Gold Edition';

  @override
  String get homeShipmentPrice => 'SAR 480';

  @override
  String get homeShipmentTitle => 'Your shipment is on its way';

  @override
  String get homeShipmentStepOrdered => 'Order placed';

  @override
  String get homeShipmentStepInTransit => 'In transit';

  @override
  String get homeShipmentStepDelivered => 'Delivered';

  @override
  String get homeShipmentView => 'View shipment';

  @override
  String get homeShipmentProtection => 'Protected by Haseen';

  @override
  String get homeShipmentDeliveryStatus => 'In transit';

  @override
  String get homeShipmentExpectedDelivery => 'Estimated delivery';

  @override
  String get homeShipmentExpectedDate => 'Monday, October 1';

  @override
  String get homeShipmentTrackingLabel => 'Tracking number';

  @override
  String get homeShipmentTrackingNumber => '#HS-2048';

  @override
  String get homeShipmentDetails => 'View details';

  @override
  String get homeCompactShipmentProduct => 'Wireless headphones';

  @override
  String get homeCompactShipmentStore => 'Jarir store';

  @override
  String get homeCompactShipmentPrice => 'SAR 320';

  @override
  String get homeCompactShipmentStatus => 'Preparing';

  @override
  String get homeCompactShipmentDelivery => 'Arrives Sunday, October 5';

  @override
  String get homeCompactShipmentTrackingLabel => 'Tracking:';

  @override
  String get homeCompactShipmentTrackingNumber => 'HS-3107';

  @override
  String get homeCompactShipment2Product => 'Men\'s fragrance, 100 ml';

  @override
  String get homeCompactShipment2Store => 'Al Majd Oud store';

  @override
  String get homeCompactShipment2Price => 'SAR 650';

  @override
  String get homeCompactShipment2Status => 'In transit';

  @override
  String get homeCompactShipment2Delivery => 'Arrives tomorrow';

  @override
  String get homeCompactShipment2TrackingNumber => 'HS-2990';

  @override
  String get shipmentDetailsTitle => 'Shipment details';

  @override
  String get shipmentDetailsInTransitLabel => 'On its way to you';

  @override
  String get shipmentDetailsBack => 'Back';

  @override
  String get shipmentDetailsShare => 'Share shipment';

  @override
  String get shipmentProtectionTitle => 'Haseen has your back';

  @override
  String get shipmentProtectionCoveredBy =>
      'Your shipment is protected from damage and loss until it arrives';

  @override
  String get shipmentProtectionValueLabel => 'Protection value';

  @override
  String get shipmentProtectionValue => 'SAR 480';

  @override
  String get shipmentProtectionStatusLabel => 'Coverage';

  @override
  String get shipmentProtectionStatus => 'Damage and loss';

  @override
  String get shipmentProtectionRemainingLabel => 'Claim';

  @override
  String get shipmentProtectionRemaining => 'After delivery';

  @override
  String get shipmentProtectionClaimAction =>
      'You can file a claim once your shipment arrives';

  @override
  String get shipmentTimelineTitle => 'Where is your shipment?';

  @override
  String get shipmentTimelineOrdered => 'Order placed';

  @override
  String get shipmentTimelineShipped => 'Left the warehouse';

  @override
  String get shipmentTimelineInTransit => 'On its way to you';

  @override
  String get shipmentTimelineDelivered => 'Delivered';

  @override
  String get shipmentTimelineOrderDate => 'October 1';

  @override
  String get shipmentTimelineOrderedDate => 'Tuesday, September 28';

  @override
  String get shipmentTimelineShippedDate => 'Wednesday, September 29 · Riyadh';

  @override
  String get shipmentTimelineInTransitDate =>
      'Now · Your courier is on the way';

  @override
  String get shipmentTimelineDeliveryDate => 'Friday, October 1';

  @override
  String get shipmentDetailsSectionTitle => 'Shipment information';

  @override
  String get shipmentDetailsExpectedDelivery => 'Estimated delivery';

  @override
  String get shipmentDetailsExpectedDeliveryValue => 'Friday, October 1';

  @override
  String get shipmentDetailsStore => 'Store';

  @override
  String get shipmentDetailsOrderDate => 'Order date';

  @override
  String get shipmentDetailsOrderDateValue => 'Tuesday, September 28';

  @override
  String get shipmentDetailsProduct => 'Product';

  @override
  String get shipmentDetailsProductValue => 'Smart watch – Gold Edition';

  @override
  String get shipmentDetailsAddress => 'Delivery address';

  @override
  String get shipmentDetailsAddressValue => 'Al Yasmin District, Riyadh';

  @override
  String get shipmentDetailsQuantity => 'Quantity';

  @override
  String get shipmentDetailsQuantityValue => '1';

  @override
  String get homeQuickGuide => 'Quick guide';

  @override
  String get homeQuickGuideAction => 'How does protection work?';

  @override
  String get homeRequestNumber => 'HS-2048';

  @override
  String get homeRequestType => 'Claim';

  @override
  String get homeRequestRemainingTime => 'Action required';

  @override
  String get homeRequestTitle => 'Men\'s fragrance, 100 ml · Nice One';

  @override
  String get homeRequestDescription =>
      'Please capture the product and packaging clearly so we can review your claim quickly.';

  @override
  String get homeRequestStepReceived => 'Received';

  @override
  String get homeRequestStepReview => 'Under review';

  @override
  String get homeRequestStepDecision => 'Decision';

  @override
  String get homeRequestStepCompensation => 'Compensation';

  @override
  String get homeRequestAmountLabel => 'Shipment value';

  @override
  String get homeRequestAmount => 'SAR 480';

  @override
  String get homeRequestAction => 'Continue claim';

  @override
  String get homeSecondaryRequestEta => 'Within 2–3 days';

  @override
  String get homeSecondaryRequestDescription =>
      'We are reviewing your claim details. No further action is needed right now.';

  @override
  String get homeSecondaryRequestAmountLabel => 'Claim value';

  @override
  String get homeSecondaryRequestAction => 'Track claim';

  @override
  String get requestsScreenTitle => 'Your claims';

  @override
  String get requestsOpenSubtitle =>
      'You have 3 open claims; one needs your attention';

  @override
  String get requestsClosedSubtitle =>
      'Your completed claims and their outcomes';

  @override
  String get requestsOpenTab => 'Open · 3';

  @override
  String get requestsClosedTab => 'Closed · 2';

  @override
  String get requestsSecondOpenNumber => 'HS-1931';

  @override
  String get requestsSecondOpenTitle => 'Wireless headphones Pro · Jarir';

  @override
  String get requestsOpenClaimAmount => 'SAR 320';

  @override
  String get requestsClaimAmountLabel => 'Claim value';

  @override
  String get requestsClosedRejectedNumber => 'HS-1874';

  @override
  String get requestsClosedRejectedTitle => 'Men\'s fragrance · Aug 20';

  @override
  String get requestsClosedAcceptedStatus => 'Accepted';

  @override
  String get requestsClosedRejectedStatus => 'Declined';

  @override
  String get requestsCompensationLabel => 'Compensation';

  @override
  String get requestsItemValueLabel => 'Item value';

  @override
  String get requestsAcceptedCompensation => 'SAR 65';

  @override
  String get requestsRejectedCompensation => '—';

  @override
  String get requestsClosedItemValue => 'SAR 480';

  @override
  String get requestsAcceptedMessage =>
      'Refund returns to your card within 3–5 days';

  @override
  String get requestsRejectedMessage => 'We need more details. Contact support';

  @override
  String get requestsDetailsAction => 'Details';

  @override
  String get requestsDetailsComingSoon =>
      'Claim details will be available soon.';

  @override
  String get homeHowItWorks => 'How it works';

  @override
  String get mainBannerGreeting => 'Welcome to Haseen 👋';

  @override
  String get mainBannerTitle => 'Shop with Haseen protection';

  @override
  String get mainBannerDescription =>
      'Shop with our trusted partners and enjoy safe delivery with protection from checkout to your door.';

  @override
  String get mainBannerAction => 'Discover partner stores';

  @override
  String get mainBannerPartnerCount => '40+ partner stores';

  @override
  String get homeStepOneLabel => 'Step one';

  @override
  String get homeStepOneTitle => 'Shop from a partner store';

  @override
  String get homeStepOneDescription => 'Choose Haseen protection at checkout.';

  @override
  String get homeStepTwoLabel => 'Step two';

  @override
  String get homeStepTwoTitle => 'Your shipment is protected automatically';

  @override
  String get homeStepTwoDescription =>
      'Track its status here, moment by moment.';

  @override
  String get homeStepThreeLabel => 'Step three';

  @override
  String get homeStepThreeTitle => 'Make a claim in a few steps';

  @override
  String get homeStepThreeDescription =>
      'If it is damaged or lost, we will help quickly.';

  @override
  String get secondaryBannerEyebrow => 'How does protection work?';

  @override
  String get secondaryBannerTitle => 'What does Haseen protection cover?';

  @override
  String get secondaryBannerDescription =>
      'Damage, loss, and delays on eligible shipments from partner stores.';

  @override
  String get secondaryBannerAction => 'Read more';

  @override
  String get bottomNavHome => 'Home';

  @override
  String get bottomNavShipments => 'My shipments';

  @override
  String get bottomNavOrders => 'Orders';

  @override
  String get bottomNavClaims => 'Claims';

  @override
  String get bottomNavStores => 'Shops';

  @override
  String get shopsHeroTitle => 'Stores you can trust';

  @override
  String get shopsHeroSubtitle =>
      'Shop from our partners with shipment protection from door to door.';

  @override
  String get shopsSearchHint => 'Search for a store...';

  @override
  String get shopsTrustTitle => 'Every store is protected by Haseen';

  @override
  String get shopsTrustDescription =>
      'Shop from trusted stores and get shipment protection from checkout to delivery.';

  @override
  String get shopsMetricPartners => 'Partner stores';

  @override
  String get shopsMetricCategories => 'Categories';

  @override
  String get shopsMetricDays => 'To file a claim';

  @override
  String get shopsDaysValue => '2 days';

  @override
  String get shopsProtectionPromise =>
      'Lost, damaged, or delayed? File a claim right in the app.';

  @override
  String get shopsFeaturedTitle => 'Featured stores';

  @override
  String get shopsSeeAll => 'See all';

  @override
  String get shopsProtectionAvailable => 'Protection available';

  @override
  String get shopsFeaturedStore => 'Madar Store';

  @override
  String get shopsFeaturedCategory => 'Electronics and accessories';

  @override
  String get shopsShopNow => 'Shop Madar';

  @override
  String get shopsOptionsHeroTitle => 'Madar Store';

  @override
  String get shopsOptionsCategory => 'Electronics and accessories • Riyadh';

  @override
  String get shopsOptionsProtection => 'Protection';

  @override
  String get shopsOptionsAvailable => 'Available ✓';

  @override
  String get shopsOptionsDelivery => 'Delivery';

  @override
  String get shopsOptionsDeliveryValue => '2–4 days';

  @override
  String get shopsOptionsReturn => 'Returns';

  @override
  String get shopsOptionsReturnValue => 'Within 7 days';

  @override
  String get shopsOptionsQuestion =>
      'How would you like your shipment protected?';

  @override
  String get shopsOptionsSubtitle =>
      'Choose protection before paying at the store';

  @override
  String get shopsOptionsProtectedTitle => 'With Haseen protection';

  @override
  String get shopsOptionsProtectedDescription =>
      'Damage or loss during transit, subject to protection terms';

  @override
  String get shopsOptionsUnprotectedTitle => 'Without protection';

  @override
  String get shopsOptionsUnprotectedDescription =>
      'You are responsible for any damage to the shipment';

  @override
  String get shopsOptionsDisclaimer =>
      'Details are illustrative and do not indicate an actual partnership or insurance with the store.';

  @override
  String get shopsAllStores => 'All stores';

  @override
  String get shopsStoreCount => '+40 stores';

  @override
  String get shopsFashionStore => 'Style Store';

  @override
  String get shopsFashionCategory => 'Fashion and everyday items';

  @override
  String get shopsPerfumeStore => 'Dar Al Oud';

  @override
  String get shopsPerfumeCategory => 'Perfumes and incense';

  @override
  String get shopsCafeStore => 'Al Deera Roastery';

  @override
  String get shopsCafeCategory => 'Coffee and specialty roasts';

  @override
  String get shopsJoinTitle =>
      'Have a store? Let your customers shop with confidence.';

  @override
  String get shopsJoinDescription =>
      'Add your store to Haseen and offer shipment protection with every order.';

  @override
  String get shopsJoinAction => 'Add your store to Haseen';

  @override
  String get bottomNavProfile => 'Profile';

  @override
  String get profileScreenTitle => 'My account';

  @override
  String get profileScreenSubtitle =>
      'Your information and settings in one place';

  @override
  String get profilePhone => '+966 55 012 3487';

  @override
  String get profileStatCompensations => 'Compensations';

  @override
  String get profileStatCompensationsValue => 'SAR 480';

  @override
  String get profileStatClaims => 'Claims';

  @override
  String get profileStatClaimsValue => '7';

  @override
  String get profileStatShipments => 'Shipments';

  @override
  String get profileStatShipmentsValue => '12';

  @override
  String get profileSectionGeneral => 'General';

  @override
  String get profileActivity => 'Activity';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileLanguageArabic => 'العربية';

  @override
  String get profileLanguageEnglish => 'English';

  @override
  String get profileLanguageAr => 'عربي';

  @override
  String get profileLanguageEn => 'EN';

  @override
  String get profileSectionSupport => 'Help & support';

  @override
  String get profileSupportTickets => 'Support tickets';

  @override
  String get profileBlog => 'Blog';

  @override
  String get profileFaq => 'FAQ';

  @override
  String get profileSectionLegal => 'Legal';

  @override
  String get profileTerms => 'Terms and conditions';

  @override
  String get profilePrivacy => 'Privacy policy';

  @override
  String get profileProtectionTerms => 'Protection terms';

  @override
  String get profileTermsSubtitle =>
      'Your rights and responsibilities, clearly explained';

  @override
  String get profilePrivacySubtitle =>
      'Your privacy matters. Here is how we handle your data';

  @override
  String get profileProtectionSubtitle =>
      'Clear information about your shipment protection';

  @override
  String get profileFaqSubtitle =>
      'Answers to the questions we hear most often';

  @override
  String get profileFaqHeroTitle => 'Have a question?';

  @override
  String get profileInformationDetails => 'Details';

  @override
  String get profileInformationVersion => 'Version';

  @override
  String get profileInformationCurrentVersion => 'October 2026';

  @override
  String get profileInformationReadingTime => 'Reading time';

  @override
  String get profileInformationScope => 'Scope';

  @override
  String get profileInformationLanguage => 'Language';

  @override
  String get profileInformationArabic => 'Arabic';

  @override
  String get profileInformationMinutes4 => '4 minutes';

  @override
  String get profileInformationMinutes3 => '3 minutes';

  @override
  String get profileInformationProtectionScope => 'Shipping and protection';

  @override
  String get profileInformationProtectionIncludes => 'Includes';

  @override
  String get profileInformationClaimPeriod => 'Claim window';

  @override
  String get profileInformationLossDamage => 'Loss and damage';

  @override
  String get profileInformationTwoDays => 'Within two days';

  @override
  String get profileInformationSupportQuestion =>
      'Have a question about this topic?';

  @override
  String get profileInformationContactSupport => 'Contact support';

  @override
  String get profileTermsSection1Title => 'Your account and responsibility';

  @override
  String get profileTermsSection1Body =>
      'Provide accurate details and update them when needed. Keep your sign-in details private and tell us if you notice unusual activity.';

  @override
  String get profileTermsSection2Title => 'Shipment protection';

  @override
  String get profileTermsSection2Body =>
      'Protection applies to shipments for which you selected Haseen protection at checkout with a partner store, according to the plan linked to your order.';

  @override
  String get profileTermsSection3Title => 'Orders and compensation';

  @override
  String get profileTermsSection3Body =>
      'You can submit a claim within the stated period after delivery. We review the evidence and share our decision. Approved compensation is sent using the original payment method.';

  @override
  String get profileTermsSection4Title => 'Acceptable use';

  @override
  String get profileTermsSection4Body =>
      'You may not use the app for unlawful activity, infringe ownership rights, or submit false details or evidence.';

  @override
  String get profileTermsSection5Title => 'Changes to these terms';

  @override
  String get profileTermsSection5Body =>
      'We may update these terms from time to time and will notify you before a material change affects you.';

  @override
  String get profilePrivacySection1Title => 'Data we collect';

  @override
  String get profilePrivacySection1Body =>
      'Your name, phone number, email, partner-store order details, claim evidence you upload, and your location if you allow access.';

  @override
  String get profilePrivacySection2Title => 'How we use it';

  @override
  String get profilePrivacySection2Body =>
      'We use it to activate shipment protection, track delivery, review claims, issue compensation, and improve your app experience.';

  @override
  String get profilePrivacySection3Title => 'Who we share it with';

  @override
  String get profilePrivacySection3Body =>
      'We share only what is needed with the store, carrier, and insurance partner to serve your request. We do not sell your data.';

  @override
  String get profilePrivacySection4Title => 'How we protect it';

  @override
  String get profilePrivacySection4Body =>
      'We store your data using encryption and limit which team members can access it.';

  @override
  String get profilePrivacySection5Title => 'Your rights and choices';

  @override
  String get profilePrivacySection5Body =>
      'You can view, update, or request deletion of your data. You can also turn off location sharing in settings at any time.';

  @override
  String get profilePrivacySection6Title => 'Contact us';

  @override
  String get profilePrivacySection6Body =>
      'For privacy questions, open a support ticket from your account.';

  @override
  String get profileProtectionSection1Title => 'Protection coverage';

  @override
  String get profileProtectionSection1Body =>
      'Protection covers shipment loss or damage during transit according to the plan selected for your order. See each shipment page for its specific coverage.';

  @override
  String get profileProtectionSection2Title => 'What is not covered';

  @override
  String get profileProtectionSection2Body =>
      'Misuse after delivery, manufacturing defects, and damage unrelated to transportation are not covered.';

  @override
  String get profileProtectionSection3Title => 'When to submit a claim';

  @override
  String get profileProtectionSection3Body =>
      'After delivery, submit within two days of receipt. For a missing shipment, you can submit after the estimated delivery date.';

  @override
  String get profileProtectionSection4Title => 'Required evidence';

  @override
  String get profileProtectionSection4Body =>
      'A photo of the package and tracking number, photos of the packaging and item, and a short video showing the damage.';

  @override
  String get profileProtectionSection5Title => 'Compensation';

  @override
  String get profileProtectionSection5Body =>
      'If your claim is approved, compensation is returned to the original payment method within 3–5 business days.';

  @override
  String get profileFaqSearchHint => 'Search for a question...';

  @override
  String get profileFaqCategoryAll => 'All';

  @override
  String get profileFaqCategoryShipments => 'Shipments';

  @override
  String get profileFaqCategoryProtection => 'Protection';

  @override
  String get profileFaqCategoryClaims => 'Claims';

  @override
  String get profileFaqMostAsked => 'Most asked';

  @override
  String get profileFaqQuestion1 =>
      'How do I claim for a damaged or missing shipment?';

  @override
  String get profileFaqAnswer1 =>
      'If your shipment has Haseen protection, you can submit a claim in a few steps:';

  @override
  String get profileFaqStep1 =>
      'Open My shipments and select the affected shipment.';

  @override
  String get profileFaqStep2 => 'Tap Submit a claim and choose what happened.';

  @override
  String get profileFaqStep3 =>
      'Photograph the label and item, add a short video, and send your request.';

  @override
  String get profileFaqAnswer1Note =>
      'Track your claim under Claims. Compensation follows the protection terms for your shipment.';

  @override
  String get profileFaqQuestion2 => 'What does shipment protection cover?';

  @override
  String get profileFaqAnswer2 =>
      'Coverage depends on the plan shown at checkout. Open shipment details to review its coverage and exclusions.';

  @override
  String get profileFaqQuestion3 => 'How can I track my shipment?';

  @override
  String get profileFaqAnswer3 =>
      'Open My shipments to see the latest update and delivery status. If tracking is unavailable, contact us through support tickets.';

  @override
  String get profileFaqQuestion4 => 'Which documents are needed for a claim?';

  @override
  String get profileFaqAnswer4 =>
      'We usually need the tracking number, clear photos of the shipment, packaging and damage, and proof of the contents\' value.';

  @override
  String get profileFaqQuestion5 => 'How do I track my claim and compensation?';

  @override
  String get profileFaqAnswer5 =>
      'Open Claims to see the latest status. If approved, the compensation amount and transfer method will be shown there.';

  @override
  String get profileFaqEmpty => 'No questions match your search.';

  @override
  String get profileFaqSupportTitle => 'Still need help?';

  @override
  String get profileFaqSupportDescription =>
      'Our support team can help with shipments, protection, and claims.';

  @override
  String get profileSectionAccount => 'Account';

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileDeleteAccount => 'Delete account';

  @override
  String get profileLogoutTitle => 'Ready to log out?';

  @override
  String get profileLogoutMessage =>
      'You can sign back in anytime with your phone number or email.';

  @override
  String get profileLogoutConfirm => 'Yes, log out';

  @override
  String get profileLogoutCancel => 'No, stay';

  @override
  String get profileDeleteHeroTitle => 'Delete your account';

  @override
  String get profileDeleteSubtitle =>
      'This is final, so take a moment before confirming';

  @override
  String get profileDeleteTitle =>
      'Are you sure you want to delete your account?';

  @override
  String get profileDeleteMessage =>
      'You will lose access to your account, shipments, and claims. This cannot be undone.';

  @override
  String get profileDeleteNameLabel => 'Account name';

  @override
  String get profileDeletePhoneLabel => 'Mobile number';

  @override
  String get profileDeleteConfirm => 'Delete my account permanently';

  @override
  String get profileDeleteCancel => 'Keep my account';

  @override
  String get profileDeleteBack => 'Back';

  @override
  String get profileDeleteUnavailable =>
      'Account deletion is not available yet.';

  @override
  String profileVersion(String version) {
    return 'Haseen • Version $version';
  }

  @override
  String get profileCredits => 'Made with love by AL Master';

  @override
  String get otpPrivacyNotice =>
      'Never share your code with anyone, even if they claim to be from Haseen.';

  @override
  String get otpChangePhone => 'Change phone number';

  @override
  String get otpChangeEmail => 'Change email address';

  @override
  String get startAutofill => 'Start SMS autofill';

  @override
  String get verifyOtp => 'Verify code';

  @override
  String get otpInvalid => 'Please enter a valid code';

  @override
  String get otpVerifiedMessage => 'Code captured successfully.';

  @override
  String get otpAutofillUnavailable => 'Autofill unavailable on this device.';

  @override
  String get itemDetails => 'Back';

  @override
  String get loadMore => 'Load more';

  @override
  String get loading => 'Loading';

  @override
  String get continueAsGuest => 'Continue as guest';

  @override
  String get offlineBanner => 'You are offline';

  @override
  String get protectedAction => 'Protected action';

  @override
  String get authRequiredAction => 'Please sign in to perform this action.';

  @override
  String protectedActionCompleted(String itemId) {
    return 'Protected action completed for item $itemId.';
  }

  @override
  String get promoBannerMessage =>
      'Limited offer: free delivery on eligible orders.';

  @override
  String get clearSearchHistory => 'Clear history';

  @override
  String get recentlyViewedTitle => 'Recently viewed item ids';

  @override
  String get refreshSkippedWhileLoadingMore =>
      'Refresh is temporarily disabled while loading more items.';

  @override
  String get uiKitShowcase => 'UI Kit Showcase';

  @override
  String get apiMonitor => 'API Monitor';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMarkAllRead => 'Mark all read';

  @override
  String get notificationsEmpty => 'No notifications yet.';

  @override
  String get notificationsHeroTitle => 'Your notifications';

  @override
  String notificationsUnreadSubtitle(int count) {
    return 'You have $count unread notifications';
  }

  @override
  String get notificationsToday => 'Today';

  @override
  String get notificationsYesterday => 'Yesterday';

  @override
  String get notificationsFilterAll => 'All';

  @override
  String notificationsFilterUnread(int count) {
    return 'Unread • $count';
  }

  @override
  String get notificationsFilterShipments => 'Shipments';

  @override
  String get notificationsFilterClaims => 'Claims';

  @override
  String get notificationsDemoClaimTitle => 'Complete your claim';

  @override
  String get notificationsDemoClaimMessage =>
      'Add product photos for claim HS-2048';

  @override
  String get notificationsDemoShipmentTitle => 'Your shipment is on the way';

  @override
  String get notificationsDemoShipmentMessage =>
      'Your order from Noon arrives today';

  @override
  String get notificationsDemoProtectionTitle =>
      'Shipment protection activated';

  @override
  String get notificationsDemoProtectionMessage =>
      'Your order from Madar is protected by Haseen';

  @override
  String get notificationsDemoApprovedTitle => 'Your claim was approved 🎉';

  @override
  String get notificationsDemoApprovedMessage => 'SAR 65 was sent to your card';

  @override
  String get notificationsDemoReviewTitle => 'Your claim is under review';

  @override
  String get notificationsDemoReviewMessage =>
      'We will let you know when there is a decision';

  @override
  String get notificationsTimeFiveMinutes => '5 minutes ago';

  @override
  String get notificationsTimeThirtyMinutes => '30 minutes ago';

  @override
  String get notificationsTimeTodayExample => 'Today, 10:40 AM';

  @override
  String get notificationsTimeYesterdaySix => 'Yesterday, 6:20 AM';

  @override
  String get notificationsTimeYesterdayNine => 'Yesterday, 9:15 AM';

  @override
  String notificationsMinutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String notificationsTodayAt(String time) {
    return 'Today, $time';
  }

  @override
  String notificationsYesterdayAt(String time) {
    return 'Yesterday, $time';
  }

  @override
  String get apiMonitorTitle => 'API Monitor';

  @override
  String get apiMonitorRecentRequests => 'Recent Requests';

  @override
  String get apiMonitorSlowestRequests => 'Slowest Requests';

  @override
  String get apiMonitorFailedRequests => 'Failed Requests';

  @override
  String get apiMonitorNoRecords => 'No records yet.';

  @override
  String get navigationErrorTitle => 'Navigation Error';

  @override
  String get routeMissingItemId => 'Missing item id in route.';

  @override
  String get errorOfflineTitle => 'No internet connection';

  @override
  String get errorOfflineMessage => 'Check your connection and try again.';

  @override
  String get errorUnauthorizedTitle => 'Sign in required';

  @override
  String get errorUnauthorizedMessage => 'Please sign in to continue.';

  @override
  String get errorForbiddenTitle => 'Access denied';

  @override
  String get errorForbiddenMessage =>
      'You do not have permission for this action.';

  @override
  String get errorNotFoundTitle => 'Not found';

  @override
  String get errorNotFoundMessage => 'Requested data was not found.';

  @override
  String get errorValidationTitle => 'Invalid input';

  @override
  String get errorValidationMessage =>
      'Please review your input and try again.';

  @override
  String get errorServerTitle => 'Server unavailable';

  @override
  String get errorServerMessage =>
      'We are having trouble right now. Please try again later.';

  @override
  String get errorGenericTitle => 'Something went wrong';

  @override
  String get errorGenericMessage => 'Please try again.';

  @override
  String get validationRequired => 'This field is required.';

  @override
  String get validationEmail => 'Please enter a valid email address.';

  @override
  String get validationPasswordWeak =>
      'Password must include upper/lower letters and numbers.';

  @override
  String validationMinLength(int min) {
    return 'Must be at least $min characters.';
  }

  @override
  String validationMaxLength(int max) {
    return 'Must be at most $max characters.';
  }

  @override
  String get validationPhone => 'Please enter a valid phone number.';

  @override
  String validationNumericRange(String min, String max) {
    return 'Value must be between $min and $max.';
  }

  @override
  String get validationMismatch => 'Values do not match.';

  @override
  String get uiKitLocaleSectionTitle => 'Localization & Direction';

  @override
  String get uiKitLocaleSectionSubtitle =>
      'Preview locale and text direction behavior';

  @override
  String get uiKitLocaleLabel => 'Locale';

  @override
  String get uiKitDirectionLabel => 'Direction';

  @override
  String get uiKitDirectionRtl => 'RTL';

  @override
  String get uiKitDirectionLtr => 'LTR';

  @override
  String get uiKitStorybookControlsTitle => 'Storybook Controls';

  @override
  String get uiKitStorybookControlsSubtitle =>
      'Preview components under different viewport/text-direction settings';

  @override
  String get uiKitViewportLabel => 'Viewport';

  @override
  String get uiKitViewportAdaptive => 'Adaptive';

  @override
  String get uiKitViewportPhone => 'Phone';

  @override
  String get uiKitViewportTablet => 'Tablet';

  @override
  String get uiKitViewportDesktop => 'Desktop';

  @override
  String get uiKitTextScaleLabel => 'Text scale';

  @override
  String get uiKitRtlPreviewLabel => 'Force RTL preview';

  @override
  String get uiKitRtlPreviewHelp =>
      'Use this to test mirrored layouts without changing app language';

  @override
  String get uiKitButtonsSectionTitle => 'Buttons';

  @override
  String get uiKitButtonsSectionSubtitle =>
      'Primary, secondary, danger, link, and icon buttons';

  @override
  String get uiKitPrimaryAction => 'Primary';

  @override
  String get uiKitLoadingAction => 'Loading';

  @override
  String get uiKitSecondaryAction => 'Secondary';

  @override
  String get uiKitTextLinkAction => 'Text link';

  @override
  String get uiKitLikeTooltip => 'Like';

  @override
  String get uiKitInputsSectionTitle => 'Inputs';

  @override
  String get uiKitInputsSectionSubtitle =>
      'Text, password, search, and dropdown fields';

  @override
  String get uiKitNameLabel => 'Name';

  @override
  String get uiKitNameHint => 'Enter your name';

  @override
  String get uiKitPasswordLabel => 'Password';

  @override
  String get uiKitPasswordHint => 'Enter your password';

  @override
  String get uiKitShowPassword => 'Show password';

  @override
  String get uiKitHidePassword => 'Hide password';

  @override
  String get uiKitClearSearch => 'Clear search';

  @override
  String get uiKitRoleLabel => 'Role';

  @override
  String get uiKitRoleHint => 'Select role';

  @override
  String get uiKitRoleUser => 'User';

  @override
  String get uiKitRoleAdmin => 'Admin';

  @override
  String get uiKitRoleReviewer => 'Reviewer';

  @override
  String get uiKitStatesSectionTitle => 'State Surfaces';

  @override
  String get uiKitStatesSectionSubtitle =>
      'Preview loading/empty/error/content states';

  @override
  String get uiKitStateLoadingLabel => 'Loading';

  @override
  String get uiKitStateEmptyLabel => 'Empty';

  @override
  String get uiKitStateErrorLabel => 'Error';

  @override
  String get uiKitStateContentLabel => 'Content';

  @override
  String get uiKitStateContentTitle => 'Content state';

  @override
  String get uiKitStateContentMessage =>
      'This is the normal content presentation state.';

  @override
  String get uiKitMediaSectionTitle => 'Media & Skeletons';

  @override
  String get uiKitMediaSectionSubtitle =>
      'Network image wrapper and loading placeholders';

  @override
  String get uiKitNetworkImageLabel => 'AppNetworkImage';

  @override
  String get uiKitSkeletonCardLabel => 'Card skeleton';

  @override
  String get uiKitSkeletonListLabel => 'List skeleton';

  @override
  String get uiKitSkeletonDetailsLabel => 'Details skeleton';

  @override
  String get uiKitLayoutSectionTitle => 'Layout Components';

  @override
  String get uiKitLayoutSectionSubtitle =>
      'Card, list tile, and divider patterns';

  @override
  String get uiKitListItemTitle => 'AppListTile Item';

  @override
  String get uiKitListItemSubtitle => 'Reusable list tile with theme defaults';

  @override
  String get uiKitThemeTokensTitle => 'Theme tokens applied';

  @override
  String get uiKitThemeTokensSubtitle =>
      'Spacing and radius from centralized tokens';

  @override
  String get uiKitFeedbackSectionTitle => 'Feedback & Navigation';

  @override
  String get uiKitFeedbackSectionSubtitle =>
      'Dialogs, sheets, toasts, and bottom navigation template';

  @override
  String get uiKitShowToastAction => 'Show toast';

  @override
  String get uiKitShowDialogAction => 'Show confirm dialog';

  @override
  String get uiKitShowBottomSheetAction => 'Show bottom sheet';

  @override
  String get uiKitShowSelectionSheetAction => 'Show selection sheet';

  @override
  String get uiKitShowConfirmationSheetAction => 'Show confirmation sheet';

  @override
  String get uiKitOpenBottomNavDemoAction => 'Open bottom-nav demo';

  @override
  String get uiKitBottomNavTitle => 'Bottom Navigation Template';

  @override
  String get uiKitHomeTab => 'Home';

  @override
  String get uiKitOrdersTab => 'Orders';

  @override
  String get uiKitProfileTab => 'Profile';

  @override
  String get uiKitStatusSectionTitle => 'Status Banners';

  @override
  String get uiKitStatusSectionSubtitle =>
      'Inline banners for success/warning/info';

  @override
  String get uiKitSuccessTitle => 'Success';

  @override
  String get uiKitSuccessMessage => 'Profile updated successfully.';

  @override
  String get uiKitWarningTitle => 'Warning';

  @override
  String get uiKitWarningMessage => 'Using stale cached data while offline.';

  @override
  String get uiKitInfoTitle => 'Info';

  @override
  String get uiKitInfoMessage =>
      'Tap action to open informational bottom sheet.';

  @override
  String get uiKitLearnMoreAction => 'Learn more';

  @override
  String get uiKitInfoSheetMessage =>
      'This is a reusable inline status banner.';

  @override
  String get uiKitPermissionsSectionTitle => 'Permissions';

  @override
  String get uiKitPermissionsSectionSubtitle =>
      'Graceful behavior when providers are unconfigured';

  @override
  String get uiKitPermissionLabel => 'Permission';

  @override
  String get uiKitCheckAction => 'Check';

  @override
  String get uiKitRequestAction => 'Request';

  @override
  String get uiKitNoDetails => 'No details.';

  @override
  String get uiKitPermissionResultPrefix => 'Permission result';

  @override
  String get uiKitBottomSheetTitle => 'Bottom Sheet Title';

  @override
  String get uiKitBottomSheetMessage =>
      'This is a reusable bottom sheet wrapper.';

  @override
  String get uiKitConfirmActionTitle => 'Confirm Action';

  @override
  String get uiKitConfirmActionMessage =>
      'This dialog is part of the shared UI kit.';

  @override
  String get uiKitSelectionSheetTitle => 'Choose one action';

  @override
  String get uiKitArchiveAction => 'Archive';

  @override
  String get uiKitPinAction => 'Pin';

  @override
  String get uiKitDeleteAction => 'Delete';

  @override
  String get uiKitSelectedPrefix => 'Selected';

  @override
  String get uiKitDestructiveTitle => 'Confirm destructive action';

  @override
  String get uiKitDestructiveMessage => 'This action cannot be undone.';

  @override
  String get openDemandsTitle => 'File a claim';

  @override
  String get openDemandsWhyLocationHeading => 'Why do we need your location?';

  @override
  String get openDemandsLocationBenefitOne =>
      'It documents the circumstances when you file your claim';

  @override
  String get openDemandsLocationBenefitTwo =>
      'It helps the review team assess your claim sooner';

  @override
  String get openDemandsLocationBenefitThree =>
      'We use it only for this claim and never share it';

  @override
  String get openDemandsStepLocation => 'Location';

  @override
  String get openDemandsStepEvidence => 'Evidence';

  @override
  String get openDemandsStepReview => 'Review';

  @override
  String get openDemandsLocationBadge => 'Enable location';

  @override
  String get openDemandsLocationHeading => 'We need your current location';

  @override
  String get openDemandsLocationDescription =>
      'Your location helps us verify the claim details and supports the review team when assessing your claim. It is used only for this claim.';

  @override
  String get openDemandsAllowLocation => 'Allow location';

  @override
  String get openDemandsNotNow => 'Not now';

  @override
  String get openDemandsLocationGranted => 'Location permission granted.';

  @override
  String get openDemandsLocationDenied =>
      'Location permission was not granted.';

  @override
  String get openDemandsLocationUnavailable =>
      'Location access is not configured on this device yet.';

  @override
  String get openDemandsLocationDisabledBadge => 'Location is disabled';

  @override
  String get openDemandsLocationDeclinedHeading =>
      'Not sharing your location may affect your claim assessment';

  @override
  String get openDemandsLocationDeclinedDescription =>
      'Location information helps clarify the circumstances of your claim. Without it, the Haseen review team may have less information, but you can still complete your claim normally.';

  @override
  String get openDemandsSkippedWarningTitle =>
      'Without your location, your claim assessment may be affected';

  @override
  String get openDemandsSkippedWarningDescription =>
      'Your location helps the Haseen team understand your claim during review. You can still submit your claim without it.';

  @override
  String get openDemandsContinueWithoutLocation => 'Continue without location';

  @override
  String get demandDetailsLocationUnavailable =>
      'Location unavailable, noted for your claim';

  @override
  String get demandDetailsLocationAvailable =>
      'Location recorded for this claim';

  @override
  String get demandDetailsHeading => 'Let’s document your shipment';

  @override
  String get demandDetailsDescription =>
      'A few photos and a short video will help us review.';

  @override
  String get demandDetailsEvidenceQuestion => 'What should we photograph?';

  @override
  String get demandDetailsEvidenceAdded => 'Evidence added';

  @override
  String get demandDetailsEvidenceDocuments => 'Label and documents';

  @override
  String get demandDetailsEvidencePackaging => 'Packaging and item';

  @override
  String get demandDetailsEvidenceDamageVideo => 'Short video of the damage';

  @override
  String get demandDetailsDocumentsHint =>
      'One photo of the label and tracking number';

  @override
  String get demandDetailsPackagingHint => 'One photo showing the damage';

  @override
  String get demandDetailsVideoHint => 'About 10 seconds';

  @override
  String get demandDetailsOnePhoto => '1 photo';

  @override
  String get demandDetailsAboutTenSeconds => 'About 10 seconds';

  @override
  String get demandDetailsOptionalImages => 'Additional photos (optional)';

  @override
  String get demandDetailsAddImage => 'Add a photo';

  @override
  String get demandDetailsStartDocumentation => 'Let’s start documenting';

  @override
  String get demandDetailsContinueDocumentation => 'Continue documentation';

  @override
  String get demandDetailsNextReview => 'Next: Review claim';

  @override
  String get demandDetailsRetake => 'Retake';

  @override
  String get demandDetailsReviewComingSoon =>
      'Claim review will be available when the claims flow is enabled.';

  @override
  String get demandDetailsUploadComingSoon =>
      'Attachments will be available when claim uploads are enabled.';

  @override
  String get demandReviewHeading => 'Review and submit your claim';

  @override
  String get demandReviewDescription =>
      'Check the details, then the Haseen team will receive it';

  @override
  String get demandReviewLocationTitle => 'Your location';

  @override
  String get demandReviewLocationMissing => 'Location is turned off';

  @override
  String get demandReviewLocationMissingDescription =>
      'This may affect the assessment of your claim';

  @override
  String get demandReviewLocationCurrent => 'Your current location';

  @override
  String get demandReviewLocationEnable => 'Enable';

  @override
  String get demandReviewEvidenceTitle => 'Evidence';

  @override
  String demandReviewFileCount(int count) {
    return '$count files ✓';
  }

  @override
  String get demandReviewLabelPhoto => 'Label';

  @override
  String get demandReviewPackagingPhoto => 'Packaging';

  @override
  String get demandReviewVideo => 'Video';

  @override
  String get demandReviewAdditionalPhoto => 'Add photo';

  @override
  String get demandReviewDescriptionTitle => 'What happened to the item?';

  @override
  String get demandReviewDescriptionHint =>
      'Describe the damage... for example: the screen is scratched';

  @override
  String demandReviewCharacterCount(int count) {
    return '$count/300';
  }

  @override
  String get demandReviewSubmit => 'Submit claim';

  @override
  String get demandReviewSubmitComingSoon =>
      'Claim submission will be available when claims are enabled.';

  @override
  String get cameraPermissionHeading => 'We need camera access';

  @override
  String get cameraPermissionDescription =>
      'We only use the camera to document the shipment condition for your claim. Enable camera access in your app or device settings, then try again.';

  @override
  String get cameraPermissionDeniedDescription =>
      'Camera access was denied. Enable it in app settings, then return and try again.';

  @override
  String get cameraCaptureFailedDescription =>
      'We couldn\'t open the camera. Check that it is available and try again.';

  @override
  String get cameraPermissionAllow => 'Allow camera';

  @override
  String get cameraPermissionOpenSettings => 'Open settings';

  @override
  String get cameraPermissionNotNow => 'Not now';

  @override
  String get cameraGuideTitle => 'Photograph the label and documents';

  @override
  String get cameraGuideQuestion => 'What to capture?';

  @override
  String get cameraGuidePhotoHint =>
      'One clear photo is enough. Make sure the label can be read.';

  @override
  String get cameraGuideShippingLabel => 'Shipping label';

  @override
  String get cameraGuideTrackingNumber => 'Tracking number';

  @override
  String get cameraGuideIncludedDocuments =>
      'Any documents that came with the parcel';

  @override
  String get cameraHelp => 'Camera help';

  @override
  String get cameraGuideDocuments =>
      'Shipment label, tracking number, and any included documents';

  @override
  String get cameraGuidePackaging => 'Packaging and product from clear angles';

  @override
  String get cameraGuideDamage => 'A short video showing the damaged areas';

  @override
  String get cameraGuideReady => 'Ready, let’s take a photo';

  @override
  String get cameraCapture => 'Capture';

  @override
  String get cameraStartRecording => 'Start recording';

  @override
  String get cameraStopRecording => 'Stop recording';

  @override
  String get cameraPhotoModeLabel => 'Photo';

  @override
  String get cameraVideoModeLabel => 'Video';

  @override
  String get cameraFramingHint =>
      'Move closer and keep the whole label in frame';

  @override
  String get cameraVideoFramingHint =>
      'Move slowly around the parcel and focus on the damage';

  @override
  String get cameraFlash => 'Flash';

  @override
  String get cameraSwitch => 'Switch camera';

  @override
  String get cameraRecording => 'Recording';

  @override
  String get cameraCaptureError =>
      'Couldn\'t start the camera. Check permission and try again.';

  @override
  String get cameraRetry => 'Try again';

  @override
  String get cameraPhotoLooksClear => 'Photo looks clear ✓';

  @override
  String get cameraUsePhoto => 'Use photo';

  @override
  String get cameraRetakePhoto => 'Retake photo';

  @override
  String get cameraExitTitle => 'Are you sure you want to exit?';

  @override
  String get cameraExitDescription =>
      'Your evidence will not be saved, and you will need to start this claim again.';

  @override
  String get cameraContinueClaim => 'Continue claim';

  @override
  String get cameraExitClaim => 'Exit';

  @override
  String get cameraVideoLooksClear => 'Video looks clear ✓';

  @override
  String get cameraUseVideo => 'Use video';

  @override
  String get cameraRetakeVideo => 'Retake video';

  @override
  String get cameraPhotoCaptured => 'Photo captured and added to the claim.';

  @override
  String get navigationBack => 'Go back';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get profileEditTitle => 'Edit your profile';

  @override
  String get profileEditSubtitle => 'Keep your information up to date';

  @override
  String get profileEditPhoto => 'Change your photo';

  @override
  String get profileEditFullNameLabel => 'Full name';

  @override
  String get profileEditFullName => 'Abdullah Al Otaibi';

  @override
  String get profileEditPhoneLabel => 'Mobile number';

  @override
  String get profileEditPhoneHelper =>
      'If you change your number, we\'ll send a verification code to the new number';

  @override
  String get profileEditEmailLabel => 'Email (optional)';

  @override
  String get profileEditEmailHint => 'Enter your email';

  @override
  String get profileEditSave => 'Save changes';

  @override
  String get profileEditPhoneReadOnly =>
      'Phone number changes are not available here.';

  @override
  String get profileEditAvatarUnavailable =>
      'Profile photo changes are not available yet.';

  @override
  String get profileEditEmailCannotRemove =>
      'Email removal is not available here.';

  @override
  String get profileEditSaved => 'Your profile has been updated.';

  @override
  String get phoneChangeSend => 'Send verification code';

  @override
  String get phoneChangeTitle => 'Change phone number';

  @override
  String get phoneChangeCurrent => 'Current phone number';

  @override
  String get phoneChangeNew => 'New phone number';

  @override
  String get phoneChangeNewHint => '05XXXXXXXX';

  @override
  String get phoneChangeVerifyFirst =>
      'Verify the new phone number before saving.';

  @override
  String get phoneChangeInvalid => 'Enter a valid Saudi mobile number.';

  @override
  String get phoneChangeSame => 'Enter a different phone number.';

  @override
  String phoneChangeSent(String phone) {
    return 'Enter the four-digit code sent to $phone.';
  }

  @override
  String get phoneChangeVerified => 'Phone number updated.';

  @override
  String get phoneChangeResend => 'Resend code';

  @override
  String phoneChangeWait(int seconds) {
    return 'You can request another code in $seconds seconds.';
  }

  @override
  String get profileEditSaveUnavailable =>
      'Saving profile changes is not available yet.';

  @override
  String get profileEditPhotoUnavailable => 'Could not open photos right now.';

  @override
  String get notificationSettingsTitle => 'Notifications';

  @override
  String get notificationSettingsSubtitle => 'Choose what you hear from us';

  @override
  String get notificationPermissionTitle => 'Allow notifications';

  @override
  String get notificationPermissionDescription =>
      'Turn them on so you don\'t miss updates';

  @override
  String get notificationShipmentTitle => 'Shipment updates';

  @override
  String get notificationShipmentDescription =>
      'Where your shipment is and when it arrives';

  @override
  String get notificationClaimTitle => 'Claim updates';

  @override
  String get notificationClaimDescription =>
      'News about your claims or compensation';

  @override
  String get notificationOffersTitle => 'Store offers';

  @override
  String get notificationOffersDescription =>
      'Offers and discounts from partner stores';

  @override
  String get notificationSettingsNote =>
      'You can change these settings anytime and stay up to date on your claims.';

  @override
  String get activityTitle => 'Your activity';

  @override
  String get activitySubtitle =>
      'Everything happening with your shipments and claims';

  @override
  String get activityFilterAll => 'All';

  @override
  String get activityFilterShipments => 'Shipments';

  @override
  String get activityFilterClaims => 'Claims';

  @override
  String get activityLatestFirst => 'Latest first';

  @override
  String get activityOldestFirst => 'Oldest first';

  @override
  String get activityToday => 'Today, October 6';

  @override
  String get activityYesterday => 'Yesterday, October 5';

  @override
  String get activityOctoberThird => 'October 3';

  @override
  String get activityOctoberSecond => 'October 2';

  @override
  String get activityOctoberFirst => 'October 1';

  @override
  String get activityTime1040 => '10:40 AM';

  @override
  String get activityTime0915 => '9:15 AM';

  @override
  String get activityTime0420 => '4:20 PM';

  @override
  String get activityTime0210 => '2:10 PM';

  @override
  String get activityTime1130 => '11:30 AM';

  @override
  String get activityTime0805 => '8:05 AM';

  @override
  String get activityShipmentOutTitle => 'Your shipment is out for delivery';

  @override
  String get activityShipmentOutDescription =>
      'Noon Store • Smart watch • HS-2048';

  @override
  String get activityClaimReviewTitle => 'Your claim is under review';

  @override
  String get activityClaimReviewDescription =>
      'Nice One • Men\'s fragrance • HS-1874';

  @override
  String get activityCompensationTitle => 'Your compensation arrived 🎉';

  @override
  String get activityCompensationDescription => 'SAR 180 • Claim HS-2039';

  @override
  String get activityClaimSubmittedTitle => 'We received your claim';

  @override
  String get activityClaimSubmittedDescription =>
      'Nice One • Men\'s fragrance • HS-1874';

  @override
  String get activityShipmentDeliveredTitle => 'Your shipment was delivered';

  @override
  String get activityShowOlder => 'Show older activity';

  @override
  String get activityShowLess => 'Hide older activity';

  @override
  String get supportTicketsTitle => 'Support tickets';

  @override
  String get supportTicketsSubtitle =>
      'We\'re here for you, and coffee\'s on us ☕';

  @override
  String get supportTicketsStatAll => 'All tickets';

  @override
  String get supportTicketsStatOpen => 'Open';

  @override
  String get supportTicketsStatResolved => 'Resolved';

  @override
  String get supportTicketsNewButton => 'Open a new ticket';

  @override
  String get supportTicketsFilterAll => 'All';

  @override
  String get supportTicketsFilterShipments => 'Shipments';

  @override
  String get supportTicketsFilterCompensations => 'Compensation';

  @override
  String get supportTicketsStatusInProgress => 'In progress';

  @override
  String get supportTicketsStatusWaiting => 'Awaiting your reply';

  @override
  String get supportTicketsCompensationTitle => 'Delayed compensation';

  @override
  String get supportTicketsCompensationSubtitle => 'October 6, 2026 • ST-1052';

  @override
  String get supportTicketsShipmentTitle => 'Update shipment details';

  @override
  String get supportTicketsShipmentSubtitle => 'October 5, 2026 • ST-1048';

  @override
  String get supportTicketsLastUpdate => 'Last update';

  @override
  String get supportTicketsUpdateTwoHoursAgo => '2 hours ago';

  @override
  String get supportTicketsUpdateYesterday => 'Yesterday, 4:30 PM';

  @override
  String get supportTicketsCategory => 'Category';

  @override
  String get supportTicketsCompensationCategory => 'Compensation';

  @override
  String get supportTicketsShipmentCategory => 'Shipments';

  @override
  String get supportTicketsViewTicket => 'View ticket';

  @override
  String get supportTicketsViewReply => 'View reply';

  @override
  String get supportTicketsCreateUnavailable =>
      'Opening a new ticket is not available yet.';

  @override
  String get supportTicketsDetailsUnavailable =>
      'Ticket details are not available yet.';

  @override
  String get supportTicketConversationTitle => 'Conversation';

  @override
  String supportTicketMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages',
      one: '1 message',
    );
    return '$_temp0';
  }

  @override
  String get supportTicketConversationDate => 'October 6, 2026';

  @override
  String get supportTicketCustomerMessage =>
      'Hello, I still haven\'t received the compensation. Any updates?';

  @override
  String get supportTicketCustomerMetadata => 'Abdullah • 9:15 AM';

  @override
  String get supportTicketTeamName => 'Husain team';

  @override
  String get supportTicketTeamMessage =>
      'Hello Abdullah, thank you for contacting us. We are reviewing your compensation request with the relevant team and will keep you updated here.';

  @override
  String get supportTicketReplySla =>
      'The Husain team usually replies within 24 hours';

  @override
  String get supportTicketReplyHint => 'Write your reply here...';

  @override
  String get supportTicketAttachFile => 'Attach file';

  @override
  String get supportTicketSendReply => 'Send reply';

  @override
  String get supportTicketReplyUnavailable => 'Replies are not available yet.';

  @override
  String get createSupportTicketTitle => 'New ticket';

  @override
  String get createSupportTicketSubtitle =>
      'Tell us what happened and we\'ll get back to you soon';

  @override
  String get createSupportTicketRequiredNote =>
      'Fields marked with * are required';

  @override
  String get createSupportTicketCategoryLabel => 'Category *';

  @override
  String get createSupportTicketClaims => 'Claims';

  @override
  String get createSupportTicketShipments => 'Shipments';

  @override
  String get createSupportTicketAccount => 'My account';

  @override
  String get createSupportTicketSubjectLabel => 'Subject *';

  @override
  String get createSupportTicketSubjectHint =>
      'For example: Shipment delivery is delayed';

  @override
  String get createSupportTicketDescriptionLabel => 'What is the issue? *';

  @override
  String get createSupportTicketDescriptionHint =>
      'Tell us what happened, when, and how we can help.';

  @override
  String createSupportTicketCharacterCount(int count, int max) {
    return '$count of $max';
  }

  @override
  String get createSupportTicketShipmentLabel => 'Shipment number (optional)';

  @override
  String get createSupportTicketShipmentHint => 'Enter the shipment number';

  @override
  String get createSupportTicketShipmentHelper =>
      'Find it in the shipment details to help us assist you faster';

  @override
  String get createSupportTicketAttachmentsLabel => 'Attachments (optional)';

  @override
  String get createSupportTicketUploadTitle => 'Add photos or files';

  @override
  String get createSupportTicketUploadDescription =>
      'Up to 5 files, 10 MB each • JPG, PNG, PDF';

  @override
  String get createSupportTicketRemoveAttachment => 'Remove file';

  @override
  String get createSupportTicketAttachmentLimit =>
      'You can attach up to 5 files.';

  @override
  String get createSupportTicketAttachmentSizeLimit =>
      'Each file must be 10 MB or less.';

  @override
  String get createSupportTicketPickerError =>
      'Could not open files right now.';

  @override
  String get createSupportTicketRequiredError => 'This field is required.';

  @override
  String get createSupportTicketSubmit => 'Send ticket';

  @override
  String get createSupportTicketSubmitUnavailable =>
      'Ticket submission is not available yet.';

  @override
  String get claimDetailsTitle => 'Claim HS-2048';

  @override
  String get claimDetailsProduct => 'Smart watch – Gold Edition · 12 September';

  @override
  String get claimDetailsAccepted => 'Accepted';

  @override
  String get claimDetailsSuccessTitle => 'Your claim was accepted';

  @override
  String get claimDetailsSuccessBody =>
      'Your compensation is on its way and should arrive in 3–5 days';

  @override
  String get claimDetailsSettlement => 'Settlement';

  @override
  String get claimDetailsTimelineTitle => 'Claim timeline';

  @override
  String get claimDetailsSubmitted => 'Claim submitted';

  @override
  String get claimDetailsReviewed => 'Under review';

  @override
  String get claimDetailsDecision => 'Accepted 🎉';

  @override
  String get claimDetailsCompensation => 'Compensation sent';

  @override
  String get claimDetailsSep6 => '6 September';

  @override
  String get claimDetailsSep7 => '7 September';

  @override
  String get claimDetailsEvidenceTitle => 'Evidence you sent';

  @override
  String get claimDetailsAttachment => 'Additional';

  @override
  String get claimDetailsVideo => 'Video';

  @override
  String get claimDetailsPackaging => 'Packaging';

  @override
  String get claimDetailsLabel => 'Label';

  @override
  String get claimDetailsLocationTitle => 'Your location and notes';

  @override
  String get claimDetailsLocationCaption =>
      'Location when the claim was submitted';

  @override
  String get claimDetailsLocation =>
      '2415 King Fahd Road, Al Sahil, Al Rimal, Riyadh';

  @override
  String get claimDetailsNoteTitle => 'Your note';

  @override
  String get claimDetailsNote =>
      '“The watch screen is cracked, and the carton was pressed in from the corner.”';

  @override
  String get claimDetailsDetailsTitle => 'Claim details';

  @override
  String get claimDetailsClaimNumber => 'Claim number';

  @override
  String get claimDetailsProductLabel => 'Product';

  @override
  String get claimDetailsProductName => 'Smart watch – Gold Edition';

  @override
  String get claimDetailsItemPrice => 'Item price';

  @override
  String get claimDetailsClaimValue => 'Claim value';

  @override
  String get claimDetailsShipment => 'Related shipment';

  @override
  String get claimDetailsStore => 'Store';

  @override
  String get claimDetailsSubmittedDate => 'Submitted';

  @override
  String get claimDetailsDecisionDate => 'Decision date';

  @override
  String get claimDetailsTransferDate => 'Transfer date';

  @override
  String get claimDetailsSubmittedDateValue => '6 September 2026';

  @override
  String get claimDetailsDecisionDateValue => '7 September 2026';

  @override
  String get claimDetailsTransferDateValue => '7 September 2026';

  @override
  String get claimDetailsStoreName => 'Noon Store';

  @override
  String get claimDetailsSeeAll => 'See all details';

  @override
  String get claimDetailsHide => 'Hide details';
}
