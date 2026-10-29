import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get appTitle;

  /// No description provided for @splashBrand.
  ///
  /// In en, this message translates to:
  /// **'Haseen'**
  String get splashBrand;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Your products, in safe hands.'**
  String get splashTagline;

  /// No description provided for @splashFooter.
  ///
  /// In en, this message translates to:
  /// **'Protect your shipment from the store to your door.'**
  String get splashFooter;

  /// No description provided for @onboardingProtectionLead.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get onboardingProtectionLead;

  /// No description provided for @onboardingProtectionHighlight.
  ///
  /// In en, this message translates to:
  /// **'shipment protection'**
  String get onboardingProtectionHighlight;

  /// No description provided for @onboardingProtectionTail.
  ///
  /// In en, this message translates to:
  /// **'before checkout'**
  String get onboardingProtectionTail;

  /// No description provided for @onboardingProtectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Haseen protection at checkout and ship with peace of mind.'**
  String get onboardingProtectionSubtitle;

  /// No description provided for @onboardingTrackingLead.
  ///
  /// In en, this message translates to:
  /// **'Track your'**
  String get onboardingTrackingLead;

  /// No description provided for @onboardingTrackingHighlight.
  ///
  /// In en, this message translates to:
  /// **'shipment'**
  String get onboardingTrackingHighlight;

  /// No description provided for @onboardingTrackingTail.
  ///
  /// In en, this message translates to:
  /// **'from dispatch to delivery'**
  String get onboardingTrackingTail;

  /// No description provided for @onboardingTrackingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Follow your shipment step by step and know when it will arrive.'**
  String get onboardingTrackingSubtitle;

  /// No description provided for @onboardingClaimTitle.
  ///
  /// In en, this message translates to:
  /// **'Protection that stays with you'**
  String get onboardingClaimTitle;

  /// No description provided for @onboardingClaimSubtitle.
  ///
  /// In en, this message translates to:
  /// **'If something goes wrong, we will guide you through a simple claim.'**
  String get onboardingClaimSubtitle;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip intro'**
  String get onboardingSkip;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingStart;

  /// No description provided for @loginMethodHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get loginMethodHelp;

  /// No description provided for @loginMethodHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'Contact our support team for help signing in.'**
  String get loginMethodHelpMessage;

  /// No description provided for @loginMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'How would you like to sign in?'**
  String get loginMethodTitle;

  /// No description provided for @loginMethodSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use the same phone or email you entered when you activated protection.'**
  String get loginMethodSubtitle;

  /// No description provided for @loginMethodChooseTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a sign-in method'**
  String get loginMethodChooseTitle;

  /// No description provided for @authPrivacyNotice.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our Terms and Privacy Policy'**
  String get authPrivacyNotice;

  /// No description provided for @loginSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get loginSendCode;

  /// No description provided for @loginMethodPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get loginMethodPhone;

  /// No description provided for @loginMethodPhoneDescription.
  ///
  /// In en, this message translates to:
  /// **'We’ll send a verification code to the phone number linked to your account.'**
  String get loginMethodPhoneDescription;

  /// No description provided for @loginMethodEmail.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get loginMethodEmail;

  /// No description provided for @loginMethodEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'We’ll send a verification code to the email linked to your account.'**
  String get loginMethodEmailDescription;

  /// No description provided for @loginMethodContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get loginMethodContinue;

  /// No description provided for @loginPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get loginPhoneTitle;

  /// No description provided for @loginPhoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use the phone number you entered when you purchased shipment protection.'**
  String get loginPhoneSubtitle;

  /// No description provided for @loginPhoneFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get loginPhoneFieldLabel;

  /// No description provided for @loginPhoneFieldHint.
  ///
  /// In en, this message translates to:
  /// **'5X XXX XXXX'**
  String get loginPhoneFieldHint;

  /// No description provided for @loginPhoneFieldHelper.
  ///
  /// In en, this message translates to:
  /// **'We’ll send a one-time verification code to your number.'**
  String get loginPhoneFieldHelper;

  /// No description provided for @loginEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get loginEmailTitle;

  /// No description provided for @loginEmailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use the email address you entered when you purchased shipment protection.'**
  String get loginEmailSubtitle;

  /// No description provided for @loginEmailFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get loginEmailFieldLabel;

  /// No description provided for @loginEmailFieldHint.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get loginEmailFieldHint;

  /// No description provided for @loginEmailFieldHelper.
  ///
  /// In en, this message translates to:
  /// **'We’ll send a one-time verification code to your email.'**
  String get loginEmailFieldHelper;

  /// No description provided for @loginPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number for this country.'**
  String get loginPhoneInvalid;

  /// No description provided for @otpDestination.
  ///
  /// In en, this message translates to:
  /// **'We sent a 4-digit code to {contact}'**
  String otpDestination(String contact);

  /// No description provided for @otpPhoneDestination.
  ///
  /// In en, this message translates to:
  /// **'We sent a 4-digit code to your number ending in {contact}'**
  String otpPhoneDestination(Object contact);

  /// No description provided for @otpEmailDestination.
  ///
  /// In en, this message translates to:
  /// **'We sent a 4-digit code to {contact}'**
  String otpEmailDestination(Object contact);

  /// No description provided for @otpPhoneLengthHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4-digit code'**
  String get otpPhoneLengthHint;

  /// No description provided for @otpEmailLengthHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4-digit code'**
  String get otpEmailLengthHint;

  /// No description provided for @countryPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a country code'**
  String get countryPickerTitle;

  /// No description provided for @countryPickerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by country or calling code'**
  String get countryPickerSearchHint;

  /// No description provided for @countryPickerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No countries found'**
  String get countryPickerEmpty;

  /// No description provided for @sampleFeatureTitle.
  ///
  /// In en, this message translates to:
  /// **'Sample Feature'**
  String get sampleFeatureTitle;

  /// No description provided for @sampleFeatureSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reusable list, details, and state handling'**
  String get sampleFeatureSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search items'**
  String get searchHint;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsTitle;

  /// No description provided for @noItemsDescription.
  ///
  /// In en, this message translates to:
  /// **'Try changing the search query or pull to refresh.'**
  String get noItemsDescription;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get genericError;

  /// No description provided for @detailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsTitle;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get changeTheme;

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switchLanguage;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This is a starter login screen. Replace it with your domain auth flow.'**
  String get loginSubtitle;

  /// No description provided for @signInDemo.
  ///
  /// In en, this message translates to:
  /// **'Sign in with demo account'**
  String get signInDemo;

  /// No description provided for @openOtpDemo.
  ///
  /// In en, this message translates to:
  /// **'Open OTP demo'**
  String get openOtpDemo;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get otpTitle;

  /// No description provided for @otpVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpVerify;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We sent a 4-digit code to your number'**
  String get otpSubtitle;

  /// No description provided for @otpHint.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get otpHint;

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otpResend;

  /// No description provided for @otpResendCountdown.
  ///
  /// In en, this message translates to:
  /// **'You can request a new code in {time}'**
  String otpResendCountdown(String time);

  /// No description provided for @otpVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'The code is incorrect. Try again.'**
  String get otpVerificationFailed;

  /// No description provided for @otpSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Verified!'**
  String get otpSuccessTitle;

  /// No description provided for @otpSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Just a moment while we take you to your shipment.'**
  String get otpSuccessMessage;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, Abdullah 👋'**
  String get welcomeTitle;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your shipment is protected. Track it here, and submit a claim if anything happens.'**
  String get welcomeDescription;

  /// No description provided for @welcomeContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter Haseen'**
  String get welcomeContinue;

  /// No description provided for @welcomeProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart watch — Gold edition'**
  String get welcomeProductTitle;

  /// No description provided for @welcomeProtectionActive.
  ///
  /// In en, this message translates to:
  /// **'Haseen protection'**
  String get welcomeProtectionActive;

  /// No description provided for @accountNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No protection found for these details'**
  String get accountNotFoundTitle;

  /// No description provided for @accountNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'Check that you used the same phone number or email address that you entered when placing your order.'**
  String get accountNotFoundBody;

  /// No description provided for @accountNotFoundPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone used at purchase'**
  String get accountNotFoundPhone;

  /// No description provided for @accountNotFoundEmail.
  ///
  /// In en, this message translates to:
  /// **'Email used at purchase'**
  String get accountNotFoundEmail;

  /// No description provided for @accountNotFoundCheckEmail.
  ///
  /// In en, this message translates to:
  /// **'Check the order confirmation email from the store'**
  String get accountNotFoundCheckEmail;

  /// No description provided for @accountNotFoundTryOtherMethod.
  ///
  /// In en, this message translates to:
  /// **'Try the other method (phone or email)'**
  String get accountNotFoundTryOtherMethod;

  /// No description provided for @accountNotFoundTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try different details'**
  String get accountNotFoundTryAgain;

  /// No description provided for @accountNotFoundSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get accountNotFoundSupport;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name} 👋'**
  String homeGreeting(String name);

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your shipment is in good hands'**
  String get homeTitle;

  /// No description provided for @homeHeroGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello there 👋'**
  String get homeHeroGreeting;

  /// No description provided for @homeUserName.
  ///
  /// In en, this message translates to:
  /// **'Abdullah Al Tamimi'**
  String get homeUserName;

  /// No description provided for @homeHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'We are with you every step of the way until it reaches your door.'**
  String get homeHeroDescription;

  /// No description provided for @homeFeaturedShipment.
  ///
  /// In en, this message translates to:
  /// **'Featured shipment'**
  String get homeFeaturedShipment;

  /// No description provided for @homeNoFeaturedShipment.
  ///
  /// In en, this message translates to:
  /// **'No featured shipment yet'**
  String get homeNoFeaturedShipment;

  /// No description provided for @homeNoShipmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Shipment details are not available yet.'**
  String get homeNoShipmentDetails;

  /// No description provided for @homeNoShipmentStatus.
  ///
  /// In en, this message translates to:
  /// **'Status unavailable'**
  String get homeNoShipmentStatus;

  /// No description provided for @homeNoDeliveryEstimate.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get homeNoDeliveryEstimate;

  /// No description provided for @homeExpectedDelivery.
  ///
  /// In en, this message translates to:
  /// **'Expected delivery'**
  String get homeExpectedDelivery;

  /// No description provided for @homeOrderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get homeOrderNumber;

  /// No description provided for @homeTrackingNumber.
  ///
  /// In en, this message translates to:
  /// **'Tracking number'**
  String get homeTrackingNumber;

  /// No description provided for @homeNoOtherShipments.
  ///
  /// In en, this message translates to:
  /// **'You have no other active shipments.'**
  String get homeNoOtherShipments;

  /// No description provided for @homeNoActiveClaims.
  ///
  /// In en, this message translates to:
  /// **'You have no active claims.'**
  String get homeNoActiveClaims;

  /// No description provided for @homeClaim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get homeClaim;

  /// No description provided for @homeTicketNumber.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get homeTicketNumber;

  /// No description provided for @homeClaimedAmount.
  ///
  /// In en, this message translates to:
  /// **'Claimed amount (SAR)'**
  String get homeClaimedAmount;

  /// No description provided for @homePartnerStoreCount.
  ///
  /// In en, this message translates to:
  /// **'{count} partner stores'**
  String homePartnerStoreCount(int count);

  /// No description provided for @homeActionRequired.
  ///
  /// In en, this message translates to:
  /// **'There is an action waiting for you.'**
  String get homeActionRequired;

  /// No description provided for @homeLoadError.
  ///
  /// In en, this message translates to:
  /// **'We could not load your home screen.'**
  String get homeLoadError;

  /// No description provided for @homeHeroShipmentDelivery.
  ///
  /// In en, this message translates to:
  /// **'Arrives Friday, October 1'**
  String get homeHeroShipmentDelivery;

  /// No description provided for @homeHeroShipmentAction.
  ///
  /// In en, this message translates to:
  /// **'Track it'**
  String get homeHeroShipmentAction;

  /// No description provided for @homeShipmentStatusHeadline.
  ///
  /// In en, this message translates to:
  /// **'Haseen is on the way with you'**
  String get homeShipmentStatusHeadline;

  /// No description provided for @homeMoreShipmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your other shipments'**
  String get homeMoreShipmentsTitle;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAll;

  /// No description provided for @homeActiveShipments.
  ///
  /// In en, this message translates to:
  /// **'Your active shipments'**
  String get homeActiveShipments;

  /// No description provided for @myShipmentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Coverage for damage, loss and delays on shipments from partner stores'**
  String get myShipmentsSubtitle;

  /// No description provided for @myShipmentsActiveTab.
  ///
  /// In en, this message translates to:
  /// **'Active 2'**
  String get myShipmentsActiveTab;

  /// No description provided for @myShipmentsDeliveredTab.
  ///
  /// In en, this message translates to:
  /// **'Delivered 1'**
  String get myShipmentsDeliveredTab;

  /// No description provided for @shipmentsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'My shipments'**
  String get shipmentsScreenTitle;

  /// No description provided for @shipmentsScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Two shipments on the way, both protected'**
  String get shipmentsScreenSubtitle;

  /// No description provided for @shipmentsDeliveredSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your delivered shipment, with time to make a claim'**
  String get shipmentsDeliveredSubtitle;

  /// No description provided for @shipmentDeliveredStatus.
  ///
  /// In en, this message translates to:
  /// **'✓ Delivered'**
  String get shipmentDeliveredStatus;

  /// No description provided for @shipmentDeliveredAt.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get shipmentDeliveredAt;

  /// No description provided for @shipmentDeliveredDate.
  ///
  /// In en, this message translates to:
  /// **'Monday, September 27'**
  String get shipmentDeliveredDate;

  /// No description provided for @shipmentDeliveredClaimHint.
  ///
  /// In en, this message translates to:
  /// **'Notice an issue? You can file a claim until October 11'**
  String get shipmentDeliveredClaimHint;

  /// No description provided for @homeActiveClaims.
  ///
  /// In en, this message translates to:
  /// **'Your active claims'**
  String get homeActiveClaims;

  /// No description provided for @homeSeeAllShipments.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAllShipments;

  /// No description provided for @homeShipmentStore.
  ///
  /// In en, this message translates to:
  /// **'Noon store'**
  String get homeShipmentStore;

  /// No description provided for @homeShipmentProduct.
  ///
  /// In en, this message translates to:
  /// **'Smart watch - Gold Edition'**
  String get homeShipmentProduct;

  /// No description provided for @homeShipmentPrice.
  ///
  /// In en, this message translates to:
  /// **'SAR 480'**
  String get homeShipmentPrice;

  /// No description provided for @homeShipmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Your shipment is on its way'**
  String get homeShipmentTitle;

  /// No description provided for @homeShipmentStepOrdered.
  ///
  /// In en, this message translates to:
  /// **'Order placed'**
  String get homeShipmentStepOrdered;

  /// No description provided for @homeShipmentStepInTransit.
  ///
  /// In en, this message translates to:
  /// **'In transit'**
  String get homeShipmentStepInTransit;

  /// No description provided for @homeShipmentStepDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get homeShipmentStepDelivered;

  /// No description provided for @homeShipmentView.
  ///
  /// In en, this message translates to:
  /// **'View shipment'**
  String get homeShipmentView;

  /// No description provided for @homeShipmentProtection.
  ///
  /// In en, this message translates to:
  /// **'Protected by Haseen'**
  String get homeShipmentProtection;

  /// No description provided for @homeShipmentDeliveryStatus.
  ///
  /// In en, this message translates to:
  /// **'In transit'**
  String get homeShipmentDeliveryStatus;

  /// No description provided for @homeShipmentExpectedDelivery.
  ///
  /// In en, this message translates to:
  /// **'Estimated delivery'**
  String get homeShipmentExpectedDelivery;

  /// No description provided for @homeShipmentExpectedDate.
  ///
  /// In en, this message translates to:
  /// **'Monday, October 1'**
  String get homeShipmentExpectedDate;

  /// No description provided for @homeShipmentTrackingLabel.
  ///
  /// In en, this message translates to:
  /// **'Tracking number'**
  String get homeShipmentTrackingLabel;

  /// No description provided for @homeShipmentTrackingNumber.
  ///
  /// In en, this message translates to:
  /// **'#HS-2048'**
  String get homeShipmentTrackingNumber;

  /// No description provided for @homeShipmentDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get homeShipmentDetails;

  /// No description provided for @homeCompactShipmentProduct.
  ///
  /// In en, this message translates to:
  /// **'Wireless headphones'**
  String get homeCompactShipmentProduct;

  /// No description provided for @homeCompactShipmentStore.
  ///
  /// In en, this message translates to:
  /// **'Jarir store'**
  String get homeCompactShipmentStore;

  /// No description provided for @homeCompactShipmentPrice.
  ///
  /// In en, this message translates to:
  /// **'SAR 320'**
  String get homeCompactShipmentPrice;

  /// No description provided for @homeCompactShipmentStatus.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get homeCompactShipmentStatus;

  /// No description provided for @homeCompactShipmentDelivery.
  ///
  /// In en, this message translates to:
  /// **'Arrives Sunday, October 5'**
  String get homeCompactShipmentDelivery;

  /// No description provided for @homeCompactShipmentTrackingLabel.
  ///
  /// In en, this message translates to:
  /// **'Tracking:'**
  String get homeCompactShipmentTrackingLabel;

  /// No description provided for @homeCompactShipmentTrackingNumber.
  ///
  /// In en, this message translates to:
  /// **'HS-3107'**
  String get homeCompactShipmentTrackingNumber;

  /// No description provided for @homeCompactShipment2Product.
  ///
  /// In en, this message translates to:
  /// **'Men\'s fragrance, 100 ml'**
  String get homeCompactShipment2Product;

  /// No description provided for @homeCompactShipment2Store.
  ///
  /// In en, this message translates to:
  /// **'Al Majd Oud store'**
  String get homeCompactShipment2Store;

  /// No description provided for @homeCompactShipment2Price.
  ///
  /// In en, this message translates to:
  /// **'SAR 650'**
  String get homeCompactShipment2Price;

  /// No description provided for @homeCompactShipment2Status.
  ///
  /// In en, this message translates to:
  /// **'In transit'**
  String get homeCompactShipment2Status;

  /// No description provided for @homeCompactShipment2Delivery.
  ///
  /// In en, this message translates to:
  /// **'Arrives tomorrow'**
  String get homeCompactShipment2Delivery;

  /// No description provided for @homeCompactShipment2TrackingNumber.
  ///
  /// In en, this message translates to:
  /// **'HS-2990'**
  String get homeCompactShipment2TrackingNumber;

  /// No description provided for @shipmentDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Shipment details'**
  String get shipmentDetailsTitle;

  /// No description provided for @shipmentDetailsInTransitLabel.
  ///
  /// In en, this message translates to:
  /// **'On its way to you'**
  String get shipmentDetailsInTransitLabel;

  /// No description provided for @shipmentDetailsBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get shipmentDetailsBack;

  /// No description provided for @shipmentDetailsShare.
  ///
  /// In en, this message translates to:
  /// **'Share shipment'**
  String get shipmentDetailsShare;

  /// No description provided for @shipmentProtectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Haseen has your back'**
  String get shipmentProtectionTitle;

  /// No description provided for @shipmentProtectionCoveredBy.
  ///
  /// In en, this message translates to:
  /// **'Your shipment is protected from damage and loss until it arrives'**
  String get shipmentProtectionCoveredBy;

  /// No description provided for @shipmentProtectionValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Protection value'**
  String get shipmentProtectionValueLabel;

  /// No description provided for @shipmentProtectionValue.
  ///
  /// In en, this message translates to:
  /// **'SAR 480'**
  String get shipmentProtectionValue;

  /// No description provided for @shipmentProtectionStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Coverage'**
  String get shipmentProtectionStatusLabel;

  /// No description provided for @shipmentProtectionStatus.
  ///
  /// In en, this message translates to:
  /// **'Damage and loss'**
  String get shipmentProtectionStatus;

  /// No description provided for @shipmentProtectionRemainingLabel.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get shipmentProtectionRemainingLabel;

  /// No description provided for @shipmentProtectionRemaining.
  ///
  /// In en, this message translates to:
  /// **'After delivery'**
  String get shipmentProtectionRemaining;

  /// No description provided for @shipmentProtectionClaimAction.
  ///
  /// In en, this message translates to:
  /// **'You can file a claim once your shipment arrives'**
  String get shipmentProtectionClaimAction;

  /// No description provided for @shipmentTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Where is your shipment?'**
  String get shipmentTimelineTitle;

  /// No description provided for @shipmentTimelineOrdered.
  ///
  /// In en, this message translates to:
  /// **'Order placed'**
  String get shipmentTimelineOrdered;

  /// No description provided for @shipmentTimelineShipped.
  ///
  /// In en, this message translates to:
  /// **'Left the warehouse'**
  String get shipmentTimelineShipped;

  /// No description provided for @shipmentTimelineInTransit.
  ///
  /// In en, this message translates to:
  /// **'On its way to you'**
  String get shipmentTimelineInTransit;

  /// No description provided for @shipmentTimelineDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get shipmentTimelineDelivered;

  /// No description provided for @shipmentTimelineOrderDate.
  ///
  /// In en, this message translates to:
  /// **'October 1'**
  String get shipmentTimelineOrderDate;

  /// No description provided for @shipmentTimelineOrderedDate.
  ///
  /// In en, this message translates to:
  /// **'Tuesday, September 28'**
  String get shipmentTimelineOrderedDate;

  /// No description provided for @shipmentTimelineShippedDate.
  ///
  /// In en, this message translates to:
  /// **'Wednesday, September 29 · Riyadh'**
  String get shipmentTimelineShippedDate;

  /// No description provided for @shipmentTimelineInTransitDate.
  ///
  /// In en, this message translates to:
  /// **'Now · Your courier is on the way'**
  String get shipmentTimelineInTransitDate;

  /// No description provided for @shipmentTimelineDeliveryDate.
  ///
  /// In en, this message translates to:
  /// **'Friday, October 1'**
  String get shipmentTimelineDeliveryDate;

  /// No description provided for @shipmentDetailsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Shipment information'**
  String get shipmentDetailsSectionTitle;

  /// No description provided for @shipmentDetailsExpectedDelivery.
  ///
  /// In en, this message translates to:
  /// **'Estimated delivery'**
  String get shipmentDetailsExpectedDelivery;

  /// No description provided for @shipmentDetailsExpectedDeliveryValue.
  ///
  /// In en, this message translates to:
  /// **'Friday, October 1'**
  String get shipmentDetailsExpectedDeliveryValue;

  /// No description provided for @shipmentDetailsStore.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get shipmentDetailsStore;

  /// No description provided for @shipmentDetailsOrderDate.
  ///
  /// In en, this message translates to:
  /// **'Order date'**
  String get shipmentDetailsOrderDate;

  /// No description provided for @shipmentDetailsOrderDateValue.
  ///
  /// In en, this message translates to:
  /// **'Tuesday, September 28'**
  String get shipmentDetailsOrderDateValue;

  /// No description provided for @shipmentDetailsProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get shipmentDetailsProduct;

  /// No description provided for @shipmentDetailsProductValue.
  ///
  /// In en, this message translates to:
  /// **'Smart watch – Gold Edition'**
  String get shipmentDetailsProductValue;

  /// No description provided for @shipmentDetailsAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get shipmentDetailsAddress;

  /// No description provided for @shipmentDetailsAddressValue.
  ///
  /// In en, this message translates to:
  /// **'Al Yasmin District, Riyadh'**
  String get shipmentDetailsAddressValue;

  /// No description provided for @shipmentDetailsQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get shipmentDetailsQuantity;

  /// No description provided for @shipmentDetailsQuantityValue.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get shipmentDetailsQuantityValue;

  /// No description provided for @homeQuickGuide.
  ///
  /// In en, this message translates to:
  /// **'Quick guide'**
  String get homeQuickGuide;

  /// No description provided for @homeQuickGuideAction.
  ///
  /// In en, this message translates to:
  /// **'How does protection work?'**
  String get homeQuickGuideAction;

  /// No description provided for @homeRequestNumber.
  ///
  /// In en, this message translates to:
  /// **'HS-2048'**
  String get homeRequestNumber;

  /// No description provided for @homeRequestType.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get homeRequestType;

  /// No description provided for @homeRequestRemainingTime.
  ///
  /// In en, this message translates to:
  /// **'Action required'**
  String get homeRequestRemainingTime;

  /// No description provided for @homeRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Men\'s fragrance, 100 ml · Nice One'**
  String get homeRequestTitle;

  /// No description provided for @homeRequestDescription.
  ///
  /// In en, this message translates to:
  /// **'Please capture the product and packaging clearly so we can review your claim quickly.'**
  String get homeRequestDescription;

  /// No description provided for @homeRequestStepReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get homeRequestStepReceived;

  /// No description provided for @homeRequestStepReview.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get homeRequestStepReview;

  /// No description provided for @homeRequestStepDecision.
  ///
  /// In en, this message translates to:
  /// **'Decision'**
  String get homeRequestStepDecision;

  /// No description provided for @homeRequestStepCompensation.
  ///
  /// In en, this message translates to:
  /// **'Compensation'**
  String get homeRequestStepCompensation;

  /// No description provided for @homeRequestAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Shipment value'**
  String get homeRequestAmountLabel;

  /// No description provided for @homeRequestAmount.
  ///
  /// In en, this message translates to:
  /// **'SAR 480'**
  String get homeRequestAmount;

  /// No description provided for @homeRequestAction.
  ///
  /// In en, this message translates to:
  /// **'Continue claim'**
  String get homeRequestAction;

  /// No description provided for @homeSecondaryRequestEta.
  ///
  /// In en, this message translates to:
  /// **'Within 2–3 days'**
  String get homeSecondaryRequestEta;

  /// No description provided for @homeSecondaryRequestDescription.
  ///
  /// In en, this message translates to:
  /// **'We are reviewing your claim details. No further action is needed right now.'**
  String get homeSecondaryRequestDescription;

  /// No description provided for @homeSecondaryRequestAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Claim value'**
  String get homeSecondaryRequestAmountLabel;

  /// No description provided for @homeSecondaryRequestAction.
  ///
  /// In en, this message translates to:
  /// **'Track claim'**
  String get homeSecondaryRequestAction;

  /// No description provided for @requestsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Your claims'**
  String get requestsScreenTitle;

  /// No description provided for @requestsOpenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You have 3 open claims; one needs your attention'**
  String get requestsOpenSubtitle;

  /// No description provided for @requestsClosedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your completed claims and their outcomes'**
  String get requestsClosedSubtitle;

  /// No description provided for @requestsOpenTab.
  ///
  /// In en, this message translates to:
  /// **'Open · 3'**
  String get requestsOpenTab;

  /// No description provided for @requestsClosedTab.
  ///
  /// In en, this message translates to:
  /// **'Closed · 2'**
  String get requestsClosedTab;

  /// No description provided for @requestsSecondOpenNumber.
  ///
  /// In en, this message translates to:
  /// **'HS-1931'**
  String get requestsSecondOpenNumber;

  /// No description provided for @requestsSecondOpenTitle.
  ///
  /// In en, this message translates to:
  /// **'Wireless headphones Pro · Jarir'**
  String get requestsSecondOpenTitle;

  /// No description provided for @requestsOpenClaimAmount.
  ///
  /// In en, this message translates to:
  /// **'SAR 320'**
  String get requestsOpenClaimAmount;

  /// No description provided for @requestsClaimAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Claim value'**
  String get requestsClaimAmountLabel;

  /// No description provided for @requestsClosedRejectedNumber.
  ///
  /// In en, this message translates to:
  /// **'HS-1874'**
  String get requestsClosedRejectedNumber;

  /// No description provided for @requestsClosedRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Men\'s fragrance · Aug 20'**
  String get requestsClosedRejectedTitle;

  /// No description provided for @requestsClosedAcceptedStatus.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get requestsClosedAcceptedStatus;

  /// No description provided for @requestsClosedRejectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get requestsClosedRejectedStatus;

  /// No description provided for @requestsCompensationLabel.
  ///
  /// In en, this message translates to:
  /// **'Compensation'**
  String get requestsCompensationLabel;

  /// No description provided for @requestsItemValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Item value'**
  String get requestsItemValueLabel;

  /// No description provided for @requestsAcceptedCompensation.
  ///
  /// In en, this message translates to:
  /// **'SAR 65'**
  String get requestsAcceptedCompensation;

  /// No description provided for @requestsRejectedCompensation.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get requestsRejectedCompensation;

  /// No description provided for @requestsClosedItemValue.
  ///
  /// In en, this message translates to:
  /// **'SAR 480'**
  String get requestsClosedItemValue;

  /// No description provided for @requestsAcceptedMessage.
  ///
  /// In en, this message translates to:
  /// **'Refund returns to your card within 3–5 days'**
  String get requestsAcceptedMessage;

  /// No description provided for @requestsRejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'We need more details. Contact support'**
  String get requestsRejectedMessage;

  /// No description provided for @requestsDetailsAction.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get requestsDetailsAction;

  /// No description provided for @requestsDetailsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Claim details will be available soon.'**
  String get requestsDetailsComingSoon;

  /// No description provided for @homeHowItWorks.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get homeHowItWorks;

  /// No description provided for @mainBannerGreeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Haseen 👋'**
  String get mainBannerGreeting;

  /// No description provided for @mainBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop with Haseen protection'**
  String get mainBannerTitle;

  /// No description provided for @mainBannerDescription.
  ///
  /// In en, this message translates to:
  /// **'Shop with our trusted partners and enjoy safe delivery with protection from checkout to your door.'**
  String get mainBannerDescription;

  /// No description provided for @mainBannerAction.
  ///
  /// In en, this message translates to:
  /// **'Discover partner stores'**
  String get mainBannerAction;

  /// No description provided for @mainBannerPartnerCount.
  ///
  /// In en, this message translates to:
  /// **'40+ partner stores'**
  String get mainBannerPartnerCount;

  /// No description provided for @homeStepOneLabel.
  ///
  /// In en, this message translates to:
  /// **'Step one'**
  String get homeStepOneLabel;

  /// No description provided for @homeStepOneTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop from a partner store'**
  String get homeStepOneTitle;

  /// No description provided for @homeStepOneDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose Haseen protection at checkout.'**
  String get homeStepOneDescription;

  /// No description provided for @homeStepTwoLabel.
  ///
  /// In en, this message translates to:
  /// **'Step two'**
  String get homeStepTwoLabel;

  /// No description provided for @homeStepTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'Your shipment is protected automatically'**
  String get homeStepTwoTitle;

  /// No description provided for @homeStepTwoDescription.
  ///
  /// In en, this message translates to:
  /// **'Track its status here, moment by moment.'**
  String get homeStepTwoDescription;

  /// No description provided for @homeStepThreeLabel.
  ///
  /// In en, this message translates to:
  /// **'Step three'**
  String get homeStepThreeLabel;

  /// No description provided for @homeStepThreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Make a claim in a few steps'**
  String get homeStepThreeTitle;

  /// No description provided for @homeStepThreeDescription.
  ///
  /// In en, this message translates to:
  /// **'If it is damaged or lost, we will help quickly.'**
  String get homeStepThreeDescription;

  /// No description provided for @secondaryBannerEyebrow.
  ///
  /// In en, this message translates to:
  /// **'How does protection work?'**
  String get secondaryBannerEyebrow;

  /// No description provided for @secondaryBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'What does Haseen protection cover?'**
  String get secondaryBannerTitle;

  /// No description provided for @secondaryBannerDescription.
  ///
  /// In en, this message translates to:
  /// **'Damage, loss, and delays on eligible shipments from partner stores.'**
  String get secondaryBannerDescription;

  /// No description provided for @secondaryBannerAction.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get secondaryBannerAction;

  /// No description provided for @bottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomNavHome;

  /// No description provided for @bottomNavShipments.
  ///
  /// In en, this message translates to:
  /// **'My shipments'**
  String get bottomNavShipments;

  /// No description provided for @bottomNavOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get bottomNavOrders;

  /// No description provided for @bottomNavClaims.
  ///
  /// In en, this message translates to:
  /// **'Claims'**
  String get bottomNavClaims;

  /// No description provided for @bottomNavStores.
  ///
  /// In en, this message translates to:
  /// **'Shops'**
  String get bottomNavStores;

  /// No description provided for @shopsHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Stores you can trust'**
  String get shopsHeroTitle;

  /// No description provided for @shopsHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shop from our partners with shipment protection from door to door.'**
  String get shopsHeroSubtitle;

  /// No description provided for @shopsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a store...'**
  String get shopsSearchHint;

  /// No description provided for @shopsTrustTitle.
  ///
  /// In en, this message translates to:
  /// **'Every store is protected by Haseen'**
  String get shopsTrustTitle;

  /// No description provided for @shopsTrustDescription.
  ///
  /// In en, this message translates to:
  /// **'Shop from trusted stores and get shipment protection from checkout to delivery.'**
  String get shopsTrustDescription;

  /// No description provided for @shopsMetricPartners.
  ///
  /// In en, this message translates to:
  /// **'Partner stores'**
  String get shopsMetricPartners;

  /// No description provided for @shopsMetricCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get shopsMetricCategories;

  /// No description provided for @shopsMetricDays.
  ///
  /// In en, this message translates to:
  /// **'To file a claim'**
  String get shopsMetricDays;

  /// No description provided for @shopsDaysValue.
  ///
  /// In en, this message translates to:
  /// **'2 days'**
  String get shopsDaysValue;

  /// No description provided for @shopsProtectionPromise.
  ///
  /// In en, this message translates to:
  /// **'Lost, damaged, or delayed? File a claim right in the app.'**
  String get shopsProtectionPromise;

  /// No description provided for @shopsFeaturedTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured stores'**
  String get shopsFeaturedTitle;

  /// No description provided for @shopsSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get shopsSeeAll;

  /// No description provided for @shopsProtectionAvailable.
  ///
  /// In en, this message translates to:
  /// **'Protection available'**
  String get shopsProtectionAvailable;

  /// No description provided for @shopsFeaturedStore.
  ///
  /// In en, this message translates to:
  /// **'Madar Store'**
  String get shopsFeaturedStore;

  /// No description provided for @shopsFeaturedCategory.
  ///
  /// In en, this message translates to:
  /// **'Electronics and accessories'**
  String get shopsFeaturedCategory;

  /// No description provided for @shopsShopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop Madar'**
  String get shopsShopNow;

  /// No description provided for @shopsOptionsHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Madar Store'**
  String get shopsOptionsHeroTitle;

  /// No description provided for @shopsOptionsCategory.
  ///
  /// In en, this message translates to:
  /// **'Electronics and accessories • Riyadh'**
  String get shopsOptionsCategory;

  /// No description provided for @shopsOptionsProtection.
  ///
  /// In en, this message translates to:
  /// **'Protection'**
  String get shopsOptionsProtection;

  /// No description provided for @shopsOptionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available ✓'**
  String get shopsOptionsAvailable;

  /// No description provided for @shopsOptionsDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get shopsOptionsDelivery;

  /// No description provided for @shopsOptionsDeliveryValue.
  ///
  /// In en, this message translates to:
  /// **'2–4 days'**
  String get shopsOptionsDeliveryValue;

  /// No description provided for @shopsOptionsReturn.
  ///
  /// In en, this message translates to:
  /// **'Returns'**
  String get shopsOptionsReturn;

  /// No description provided for @shopsOptionsReturnValue.
  ///
  /// In en, this message translates to:
  /// **'Within 7 days'**
  String get shopsOptionsReturnValue;

  /// No description provided for @shopsOptionsQuestion.
  ///
  /// In en, this message translates to:
  /// **'How would you like your shipment protected?'**
  String get shopsOptionsQuestion;

  /// No description provided for @shopsOptionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose protection before paying at the store'**
  String get shopsOptionsSubtitle;

  /// No description provided for @shopsOptionsProtectedTitle.
  ///
  /// In en, this message translates to:
  /// **'With Haseen protection'**
  String get shopsOptionsProtectedTitle;

  /// No description provided for @shopsOptionsProtectedDescription.
  ///
  /// In en, this message translates to:
  /// **'Damage or loss during transit, subject to protection terms'**
  String get shopsOptionsProtectedDescription;

  /// No description provided for @shopsOptionsUnprotectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Without protection'**
  String get shopsOptionsUnprotectedTitle;

  /// No description provided for @shopsOptionsUnprotectedDescription.
  ///
  /// In en, this message translates to:
  /// **'You are responsible for any damage to the shipment'**
  String get shopsOptionsUnprotectedDescription;

  /// No description provided for @shopsOptionsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Details are illustrative and do not indicate an actual partnership or insurance with the store.'**
  String get shopsOptionsDisclaimer;

  /// No description provided for @shopsAllStores.
  ///
  /// In en, this message translates to:
  /// **'All stores'**
  String get shopsAllStores;

  /// No description provided for @shopsStoreCount.
  ///
  /// In en, this message translates to:
  /// **'+40 stores'**
  String get shopsStoreCount;

  /// No description provided for @shopsFashionStore.
  ///
  /// In en, this message translates to:
  /// **'Style Store'**
  String get shopsFashionStore;

  /// No description provided for @shopsFashionCategory.
  ///
  /// In en, this message translates to:
  /// **'Fashion and everyday items'**
  String get shopsFashionCategory;

  /// No description provided for @shopsPerfumeStore.
  ///
  /// In en, this message translates to:
  /// **'Dar Al Oud'**
  String get shopsPerfumeStore;

  /// No description provided for @shopsPerfumeCategory.
  ///
  /// In en, this message translates to:
  /// **'Perfumes and incense'**
  String get shopsPerfumeCategory;

  /// No description provided for @shopsCafeStore.
  ///
  /// In en, this message translates to:
  /// **'Al Deera Roastery'**
  String get shopsCafeStore;

  /// No description provided for @shopsCafeCategory.
  ///
  /// In en, this message translates to:
  /// **'Coffee and specialty roasts'**
  String get shopsCafeCategory;

  /// No description provided for @shopsJoinTitle.
  ///
  /// In en, this message translates to:
  /// **'Have a store? Let your customers shop with confidence.'**
  String get shopsJoinTitle;

  /// No description provided for @shopsJoinDescription.
  ///
  /// In en, this message translates to:
  /// **'Add your store to Haseen and offer shipment protection with every order.'**
  String get shopsJoinDescription;

  /// No description provided for @shopsJoinAction.
  ///
  /// In en, this message translates to:
  /// **'Add your store to Haseen'**
  String get shopsJoinAction;

  /// No description provided for @bottomNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavProfile;

  /// No description provided for @profileScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get profileScreenTitle;

  /// No description provided for @profileScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your information and settings in one place'**
  String get profileScreenSubtitle;

  /// No description provided for @profilePhone.
  ///
  /// In en, this message translates to:
  /// **'+966 55 012 3487'**
  String get profilePhone;

  /// No description provided for @profileStatCompensations.
  ///
  /// In en, this message translates to:
  /// **'Compensations'**
  String get profileStatCompensations;

  /// No description provided for @profileStatCompensationsValue.
  ///
  /// In en, this message translates to:
  /// **'SAR 480'**
  String get profileStatCompensationsValue;

  /// No description provided for @profileStatClaims.
  ///
  /// In en, this message translates to:
  /// **'Claims'**
  String get profileStatClaims;

  /// No description provided for @profileStatClaimsValue.
  ///
  /// In en, this message translates to:
  /// **'7'**
  String get profileStatClaimsValue;

  /// No description provided for @profileStatShipments.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get profileStatShipments;

  /// No description provided for @profileStatShipmentsValue.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get profileStatShipmentsValue;

  /// No description provided for @profileSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get profileSectionGeneral;

  /// No description provided for @profileActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get profileActivity;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileLanguageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get profileLanguageArabic;

  /// No description provided for @profileLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get profileLanguageEnglish;

  /// No description provided for @profileLanguageAr.
  ///
  /// In en, this message translates to:
  /// **'عربي'**
  String get profileLanguageAr;

  /// No description provided for @profileLanguageEn.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get profileLanguageEn;

  /// No description provided for @profileSectionSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get profileSectionSupport;

  /// No description provided for @profileSupportTickets.
  ///
  /// In en, this message translates to:
  /// **'Support tickets'**
  String get profileSupportTickets;

  /// No description provided for @profileBlog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get profileBlog;

  /// No description provided for @profileFaq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get profileFaq;

  /// No description provided for @profileSectionLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get profileSectionLegal;

  /// No description provided for @profileTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get profileTerms;

  /// No description provided for @profilePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get profilePrivacy;

  /// No description provided for @profileProtectionTerms.
  ///
  /// In en, this message translates to:
  /// **'Protection terms'**
  String get profileProtectionTerms;

  /// No description provided for @profileTermsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your rights and responsibilities, clearly explained'**
  String get profileTermsSubtitle;

  /// No description provided for @profilePrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your privacy matters. Here is how we handle your data'**
  String get profilePrivacySubtitle;

  /// No description provided for @profileProtectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear information about your shipment protection'**
  String get profileProtectionSubtitle;

  /// No description provided for @profileFaqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answers to the questions we hear most often'**
  String get profileFaqSubtitle;

  /// No description provided for @profileFaqHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Have a question?'**
  String get profileFaqHeroTitle;

  /// No description provided for @profileInformationDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get profileInformationDetails;

  /// No description provided for @profileInformationVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get profileInformationVersion;

  /// No description provided for @profileInformationCurrentVersion.
  ///
  /// In en, this message translates to:
  /// **'October 2026'**
  String get profileInformationCurrentVersion;

  /// No description provided for @profileInformationReadingTime.
  ///
  /// In en, this message translates to:
  /// **'Reading time'**
  String get profileInformationReadingTime;

  /// No description provided for @profileInformationScope.
  ///
  /// In en, this message translates to:
  /// **'Scope'**
  String get profileInformationScope;

  /// No description provided for @profileInformationLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileInformationLanguage;

  /// No description provided for @profileInformationArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get profileInformationArabic;

  /// No description provided for @profileInformationMinutes4.
  ///
  /// In en, this message translates to:
  /// **'4 minutes'**
  String get profileInformationMinutes4;

  /// No description provided for @profileInformationMinutes3.
  ///
  /// In en, this message translates to:
  /// **'3 minutes'**
  String get profileInformationMinutes3;

  /// No description provided for @profileInformationProtectionScope.
  ///
  /// In en, this message translates to:
  /// **'Shipping and protection'**
  String get profileInformationProtectionScope;

  /// No description provided for @profileInformationProtectionIncludes.
  ///
  /// In en, this message translates to:
  /// **'Includes'**
  String get profileInformationProtectionIncludes;

  /// No description provided for @profileInformationClaimPeriod.
  ///
  /// In en, this message translates to:
  /// **'Claim window'**
  String get profileInformationClaimPeriod;

  /// No description provided for @profileInformationLossDamage.
  ///
  /// In en, this message translates to:
  /// **'Loss and damage'**
  String get profileInformationLossDamage;

  /// No description provided for @profileInformationTwoDays.
  ///
  /// In en, this message translates to:
  /// **'Within two days'**
  String get profileInformationTwoDays;

  /// No description provided for @profileInformationSupportQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have a question about this topic?'**
  String get profileInformationSupportQuestion;

  /// No description provided for @profileInformationContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get profileInformationContactSupport;

  /// No description provided for @profileTermsSection1Title.
  ///
  /// In en, this message translates to:
  /// **'Your account and responsibility'**
  String get profileTermsSection1Title;

  /// No description provided for @profileTermsSection1Body.
  ///
  /// In en, this message translates to:
  /// **'Provide accurate details and update them when needed. Keep your sign-in details private and tell us if you notice unusual activity.'**
  String get profileTermsSection1Body;

  /// No description provided for @profileTermsSection2Title.
  ///
  /// In en, this message translates to:
  /// **'Shipment protection'**
  String get profileTermsSection2Title;

  /// No description provided for @profileTermsSection2Body.
  ///
  /// In en, this message translates to:
  /// **'Protection applies to shipments for which you selected Haseen protection at checkout with a partner store, according to the plan linked to your order.'**
  String get profileTermsSection2Body;

  /// No description provided for @profileTermsSection3Title.
  ///
  /// In en, this message translates to:
  /// **'Orders and compensation'**
  String get profileTermsSection3Title;

  /// No description provided for @profileTermsSection3Body.
  ///
  /// In en, this message translates to:
  /// **'You can submit a claim within the stated period after delivery. We review the evidence and share our decision. Approved compensation is sent using the original payment method.'**
  String get profileTermsSection3Body;

  /// No description provided for @profileTermsSection4Title.
  ///
  /// In en, this message translates to:
  /// **'Acceptable use'**
  String get profileTermsSection4Title;

  /// No description provided for @profileTermsSection4Body.
  ///
  /// In en, this message translates to:
  /// **'You may not use the app for unlawful activity, infringe ownership rights, or submit false details or evidence.'**
  String get profileTermsSection4Body;

  /// No description provided for @profileTermsSection5Title.
  ///
  /// In en, this message translates to:
  /// **'Changes to these terms'**
  String get profileTermsSection5Title;

  /// No description provided for @profileTermsSection5Body.
  ///
  /// In en, this message translates to:
  /// **'We may update these terms from time to time and will notify you before a material change affects you.'**
  String get profileTermsSection5Body;

  /// No description provided for @profilePrivacySection1Title.
  ///
  /// In en, this message translates to:
  /// **'Data we collect'**
  String get profilePrivacySection1Title;

  /// No description provided for @profilePrivacySection1Body.
  ///
  /// In en, this message translates to:
  /// **'Your name, phone number, email, partner-store order details, claim evidence you upload, and your location if you allow access.'**
  String get profilePrivacySection1Body;

  /// No description provided for @profilePrivacySection2Title.
  ///
  /// In en, this message translates to:
  /// **'How we use it'**
  String get profilePrivacySection2Title;

  /// No description provided for @profilePrivacySection2Body.
  ///
  /// In en, this message translates to:
  /// **'We use it to activate shipment protection, track delivery, review claims, issue compensation, and improve your app experience.'**
  String get profilePrivacySection2Body;

  /// No description provided for @profilePrivacySection3Title.
  ///
  /// In en, this message translates to:
  /// **'Who we share it with'**
  String get profilePrivacySection3Title;

  /// No description provided for @profilePrivacySection3Body.
  ///
  /// In en, this message translates to:
  /// **'We share only what is needed with the store, carrier, and insurance partner to serve your request. We do not sell your data.'**
  String get profilePrivacySection3Body;

  /// No description provided for @profilePrivacySection4Title.
  ///
  /// In en, this message translates to:
  /// **'How we protect it'**
  String get profilePrivacySection4Title;

  /// No description provided for @profilePrivacySection4Body.
  ///
  /// In en, this message translates to:
  /// **'We store your data using encryption and limit which team members can access it.'**
  String get profilePrivacySection4Body;

  /// No description provided for @profilePrivacySection5Title.
  ///
  /// In en, this message translates to:
  /// **'Your rights and choices'**
  String get profilePrivacySection5Title;

  /// No description provided for @profilePrivacySection5Body.
  ///
  /// In en, this message translates to:
  /// **'You can view, update, or request deletion of your data. You can also turn off location sharing in settings at any time.'**
  String get profilePrivacySection5Body;

  /// No description provided for @profilePrivacySection6Title.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get profilePrivacySection6Title;

  /// No description provided for @profilePrivacySection6Body.
  ///
  /// In en, this message translates to:
  /// **'For privacy questions, open a support ticket from your account.'**
  String get profilePrivacySection6Body;

  /// No description provided for @profileProtectionSection1Title.
  ///
  /// In en, this message translates to:
  /// **'Protection coverage'**
  String get profileProtectionSection1Title;

  /// No description provided for @profileProtectionSection1Body.
  ///
  /// In en, this message translates to:
  /// **'Protection covers shipment loss or damage during transit according to the plan selected for your order. See each shipment page for its specific coverage.'**
  String get profileProtectionSection1Body;

  /// No description provided for @profileProtectionSection2Title.
  ///
  /// In en, this message translates to:
  /// **'What is not covered'**
  String get profileProtectionSection2Title;

  /// No description provided for @profileProtectionSection2Body.
  ///
  /// In en, this message translates to:
  /// **'Misuse after delivery, manufacturing defects, and damage unrelated to transportation are not covered.'**
  String get profileProtectionSection2Body;

  /// No description provided for @profileProtectionSection3Title.
  ///
  /// In en, this message translates to:
  /// **'When to submit a claim'**
  String get profileProtectionSection3Title;

  /// No description provided for @profileProtectionSection3Body.
  ///
  /// In en, this message translates to:
  /// **'After delivery, submit within two days of receipt. For a missing shipment, you can submit after the estimated delivery date.'**
  String get profileProtectionSection3Body;

  /// No description provided for @profileProtectionSection4Title.
  ///
  /// In en, this message translates to:
  /// **'Required evidence'**
  String get profileProtectionSection4Title;

  /// No description provided for @profileProtectionSection4Body.
  ///
  /// In en, this message translates to:
  /// **'A photo of the package and tracking number, photos of the packaging and item, and a short video showing the damage.'**
  String get profileProtectionSection4Body;

  /// No description provided for @profileProtectionSection5Title.
  ///
  /// In en, this message translates to:
  /// **'Compensation'**
  String get profileProtectionSection5Title;

  /// No description provided for @profileProtectionSection5Body.
  ///
  /// In en, this message translates to:
  /// **'If your claim is approved, compensation is returned to the original payment method within 3–5 business days.'**
  String get profileProtectionSection5Body;

  /// No description provided for @profileFaqSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a question...'**
  String get profileFaqSearchHint;

  /// No description provided for @profileFaqCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get profileFaqCategoryAll;

  /// No description provided for @profileFaqCategoryShipments.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get profileFaqCategoryShipments;

  /// No description provided for @profileFaqCategoryProtection.
  ///
  /// In en, this message translates to:
  /// **'Protection'**
  String get profileFaqCategoryProtection;

  /// No description provided for @profileFaqCategoryClaims.
  ///
  /// In en, this message translates to:
  /// **'Claims'**
  String get profileFaqCategoryClaims;

  /// No description provided for @profileFaqMostAsked.
  ///
  /// In en, this message translates to:
  /// **'Most asked'**
  String get profileFaqMostAsked;

  /// No description provided for @profileFaqQuestion1.
  ///
  /// In en, this message translates to:
  /// **'How do I claim for a damaged or missing shipment?'**
  String get profileFaqQuestion1;

  /// No description provided for @profileFaqAnswer1.
  ///
  /// In en, this message translates to:
  /// **'If your shipment has Haseen protection, you can submit a claim in a few steps:'**
  String get profileFaqAnswer1;

  /// No description provided for @profileFaqStep1.
  ///
  /// In en, this message translates to:
  /// **'Open My shipments and select the affected shipment.'**
  String get profileFaqStep1;

  /// No description provided for @profileFaqStep2.
  ///
  /// In en, this message translates to:
  /// **'Tap Submit a claim and choose what happened.'**
  String get profileFaqStep2;

  /// No description provided for @profileFaqStep3.
  ///
  /// In en, this message translates to:
  /// **'Photograph the label and item, add a short video, and send your request.'**
  String get profileFaqStep3;

  /// No description provided for @profileFaqAnswer1Note.
  ///
  /// In en, this message translates to:
  /// **'Track your claim under Claims. Compensation follows the protection terms for your shipment.'**
  String get profileFaqAnswer1Note;

  /// No description provided for @profileFaqQuestion2.
  ///
  /// In en, this message translates to:
  /// **'What does shipment protection cover?'**
  String get profileFaqQuestion2;

  /// No description provided for @profileFaqAnswer2.
  ///
  /// In en, this message translates to:
  /// **'Coverage depends on the plan shown at checkout. Open shipment details to review its coverage and exclusions.'**
  String get profileFaqAnswer2;

  /// No description provided for @profileFaqQuestion3.
  ///
  /// In en, this message translates to:
  /// **'How can I track my shipment?'**
  String get profileFaqQuestion3;

  /// No description provided for @profileFaqAnswer3.
  ///
  /// In en, this message translates to:
  /// **'Open My shipments to see the latest update and delivery status. If tracking is unavailable, contact us through support tickets.'**
  String get profileFaqAnswer3;

  /// No description provided for @profileFaqQuestion4.
  ///
  /// In en, this message translates to:
  /// **'Which documents are needed for a claim?'**
  String get profileFaqQuestion4;

  /// No description provided for @profileFaqAnswer4.
  ///
  /// In en, this message translates to:
  /// **'We usually need the tracking number, clear photos of the shipment, packaging and damage, and proof of the contents\' value.'**
  String get profileFaqAnswer4;

  /// No description provided for @profileFaqQuestion5.
  ///
  /// In en, this message translates to:
  /// **'How do I track my claim and compensation?'**
  String get profileFaqQuestion5;

  /// No description provided for @profileFaqAnswer5.
  ///
  /// In en, this message translates to:
  /// **'Open Claims to see the latest status. If approved, the compensation amount and transfer method will be shown there.'**
  String get profileFaqAnswer5;

  /// No description provided for @profileFaqEmpty.
  ///
  /// In en, this message translates to:
  /// **'No questions match your search.'**
  String get profileFaqEmpty;

  /// No description provided for @profileFaqSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Still need help?'**
  String get profileFaqSupportTitle;

  /// No description provided for @profileFaqSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'Our support team can help with shipments, protection, and claims.'**
  String get profileFaqSupportDescription;

  /// No description provided for @profileSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileSectionAccount;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get profileDeleteAccount;

  /// No description provided for @profileLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to log out?'**
  String get profileLogoutTitle;

  /// No description provided for @profileLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'You can sign back in anytime with your phone number or email.'**
  String get profileLogoutMessage;

  /// No description provided for @profileLogoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, log out'**
  String get profileLogoutConfirm;

  /// No description provided for @profileLogoutCancel.
  ///
  /// In en, this message translates to:
  /// **'No, stay'**
  String get profileLogoutCancel;

  /// No description provided for @profileDeleteHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account'**
  String get profileDeleteHeroTitle;

  /// No description provided for @profileDeleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This is final, so take a moment before confirming'**
  String get profileDeleteSubtitle;

  /// No description provided for @profileDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get profileDeleteTitle;

  /// No description provided for @profileDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'You will lose access to your account, shipments, and claims. This cannot be undone.'**
  String get profileDeleteMessage;

  /// No description provided for @profileDeleteNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get profileDeleteNameLabel;

  /// No description provided for @profileDeletePhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get profileDeletePhoneLabel;

  /// No description provided for @profileDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete my account permanently'**
  String get profileDeleteConfirm;

  /// No description provided for @profileDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Keep my account'**
  String get profileDeleteCancel;

  /// No description provided for @profileDeleteBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get profileDeleteBack;

  /// No description provided for @profileDeleteUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Account deletion is not available yet.'**
  String get profileDeleteUnavailable;

  /// No description provided for @profileVersion.
  ///
  /// In en, this message translates to:
  /// **'Haseen • Version {version}'**
  String profileVersion(String version);

  /// No description provided for @profileCredits.
  ///
  /// In en, this message translates to:
  /// **'Made with love by AL Master'**
  String get profileCredits;

  /// No description provided for @otpPrivacyNotice.
  ///
  /// In en, this message translates to:
  /// **'Never share your code with anyone, even if they claim to be from Haseen.'**
  String get otpPrivacyNotice;

  /// No description provided for @otpChangePhone.
  ///
  /// In en, this message translates to:
  /// **'Change phone number'**
  String get otpChangePhone;

  /// No description provided for @otpChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email address'**
  String get otpChangeEmail;

  /// No description provided for @startAutofill.
  ///
  /// In en, this message translates to:
  /// **'Start SMS autofill'**
  String get startAutofill;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get verifyOtp;

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid code'**
  String get otpInvalid;

  /// No description provided for @otpVerifiedMessage.
  ///
  /// In en, this message translates to:
  /// **'Code captured successfully.'**
  String get otpVerifiedMessage;

  /// No description provided for @otpAutofillUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Autofill unavailable on this device.'**
  String get otpAutofillUnavailable;

  /// No description provided for @itemDetails.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get itemDetails;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuest;

  /// No description provided for @offlineBanner.
  ///
  /// In en, this message translates to:
  /// **'You are offline'**
  String get offlineBanner;

  /// No description provided for @protectedAction.
  ///
  /// In en, this message translates to:
  /// **'Protected action'**
  String get protectedAction;

  /// No description provided for @authRequiredAction.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to perform this action.'**
  String get authRequiredAction;

  /// No description provided for @protectedActionCompleted.
  ///
  /// In en, this message translates to:
  /// **'Protected action completed for item {itemId}.'**
  String protectedActionCompleted(String itemId);

  /// No description provided for @promoBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'Limited offer: free delivery on eligible orders.'**
  String get promoBannerMessage;

  /// No description provided for @clearSearchHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get clearSearchHistory;

  /// No description provided for @recentlyViewedTitle.
  ///
  /// In en, this message translates to:
  /// **'Recently viewed item ids'**
  String get recentlyViewedTitle;

  /// No description provided for @refreshSkippedWhileLoadingMore.
  ///
  /// In en, this message translates to:
  /// **'Refresh is temporarily disabled while loading more items.'**
  String get refreshSkippedWhileLoadingMore;

  /// No description provided for @uiKitShowcase.
  ///
  /// In en, this message translates to:
  /// **'UI Kit Showcase'**
  String get uiKitShowcase;

  /// No description provided for @apiMonitor.
  ///
  /// In en, this message translates to:
  /// **'API Monitor'**
  String get apiMonitor;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get notificationsEmpty;

  /// No description provided for @notificationsHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Your notifications'**
  String get notificationsHeroTitle;

  /// No description provided for @notificationsUnreadSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You have {count} unread notifications'**
  String notificationsUnreadSubtitle(int count);

  /// No description provided for @notificationsToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get notificationsToday;

  /// No description provided for @notificationsYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notificationsYesterday;

  /// No description provided for @notificationsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notificationsFilterAll;

  /// No description provided for @notificationsFilterUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread • {count}'**
  String notificationsFilterUnread(int count);

  /// No description provided for @notificationsFilterShipments.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get notificationsFilterShipments;

  /// No description provided for @notificationsFilterClaims.
  ///
  /// In en, this message translates to:
  /// **'Claims'**
  String get notificationsFilterClaims;

  /// No description provided for @notificationsDemoClaimTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your claim'**
  String get notificationsDemoClaimTitle;

  /// No description provided for @notificationsDemoClaimMessage.
  ///
  /// In en, this message translates to:
  /// **'Add product photos for claim HS-2048'**
  String get notificationsDemoClaimMessage;

  /// No description provided for @notificationsDemoShipmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Your shipment is on the way'**
  String get notificationsDemoShipmentTitle;

  /// No description provided for @notificationsDemoShipmentMessage.
  ///
  /// In en, this message translates to:
  /// **'Your order from Noon arrives today'**
  String get notificationsDemoShipmentMessage;

  /// No description provided for @notificationsDemoProtectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Shipment protection activated'**
  String get notificationsDemoProtectionTitle;

  /// No description provided for @notificationsDemoProtectionMessage.
  ///
  /// In en, this message translates to:
  /// **'Your order from Madar is protected by Haseen'**
  String get notificationsDemoProtectionMessage;

  /// No description provided for @notificationsDemoApprovedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your claim was approved 🎉'**
  String get notificationsDemoApprovedTitle;

  /// No description provided for @notificationsDemoApprovedMessage.
  ///
  /// In en, this message translates to:
  /// **'SAR 65 was sent to your card'**
  String get notificationsDemoApprovedMessage;

  /// No description provided for @notificationsDemoReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Your claim is under review'**
  String get notificationsDemoReviewTitle;

  /// No description provided for @notificationsDemoReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'We will let you know when there is a decision'**
  String get notificationsDemoReviewMessage;

  /// No description provided for @notificationsTimeFiveMinutes.
  ///
  /// In en, this message translates to:
  /// **'5 minutes ago'**
  String get notificationsTimeFiveMinutes;

  /// No description provided for @notificationsTimeThirtyMinutes.
  ///
  /// In en, this message translates to:
  /// **'30 minutes ago'**
  String get notificationsTimeThirtyMinutes;

  /// No description provided for @notificationsTimeTodayExample.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:40 AM'**
  String get notificationsTimeTodayExample;

  /// No description provided for @notificationsTimeYesterdaySix.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, 6:20 AM'**
  String get notificationsTimeYesterdaySix;

  /// No description provided for @notificationsTimeYesterdayNine.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, 9:15 AM'**
  String get notificationsTimeYesterdayNine;

  /// No description provided for @notificationsMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String notificationsMinutesAgo(int count);

  /// No description provided for @notificationsTodayAt.
  ///
  /// In en, this message translates to:
  /// **'Today, {time}'**
  String notificationsTodayAt(String time);

  /// No description provided for @notificationsYesterdayAt.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, {time}'**
  String notificationsYesterdayAt(String time);

  /// No description provided for @apiMonitorTitle.
  ///
  /// In en, this message translates to:
  /// **'API Monitor'**
  String get apiMonitorTitle;

  /// No description provided for @apiMonitorRecentRequests.
  ///
  /// In en, this message translates to:
  /// **'Recent Requests'**
  String get apiMonitorRecentRequests;

  /// No description provided for @apiMonitorSlowestRequests.
  ///
  /// In en, this message translates to:
  /// **'Slowest Requests'**
  String get apiMonitorSlowestRequests;

  /// No description provided for @apiMonitorFailedRequests.
  ///
  /// In en, this message translates to:
  /// **'Failed Requests'**
  String get apiMonitorFailedRequests;

  /// No description provided for @apiMonitorNoRecords.
  ///
  /// In en, this message translates to:
  /// **'No records yet.'**
  String get apiMonitorNoRecords;

  /// No description provided for @navigationErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Navigation Error'**
  String get navigationErrorTitle;

  /// No description provided for @routeMissingItemId.
  ///
  /// In en, this message translates to:
  /// **'Missing item id in route.'**
  String get routeMissingItemId;

  /// No description provided for @errorOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorOfflineTitle;

  /// No description provided for @errorOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get errorOfflineMessage;

  /// No description provided for @errorUnauthorizedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in required'**
  String get errorUnauthorizedTitle;

  /// No description provided for @errorUnauthorizedMessage.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue.'**
  String get errorUnauthorizedMessage;

  /// No description provided for @errorForbiddenTitle.
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get errorForbiddenTitle;

  /// No description provided for @errorForbiddenMessage.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission for this action.'**
  String get errorForbiddenMessage;

  /// No description provided for @errorNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get errorNotFoundTitle;

  /// No description provided for @errorNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'Requested data was not found.'**
  String get errorNotFoundMessage;

  /// No description provided for @errorValidationTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid input'**
  String get errorValidationTitle;

  /// No description provided for @errorValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Please review your input and try again.'**
  String get errorValidationMessage;

  /// No description provided for @errorServerTitle.
  ///
  /// In en, this message translates to:
  /// **'Server unavailable'**
  String get errorServerTitle;

  /// No description provided for @errorServerMessage.
  ///
  /// In en, this message translates to:
  /// **'We are having trouble right now. Please try again later.'**
  String get errorServerMessage;

  /// No description provided for @errorGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGenericTitle;

  /// No description provided for @errorGenericMessage.
  ///
  /// In en, this message translates to:
  /// **'Please try again.'**
  String get errorGenericMessage;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get validationRequired;

  /// No description provided for @validationEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get validationEmail;

  /// No description provided for @validationPasswordWeak.
  ///
  /// In en, this message translates to:
  /// **'Password must include upper/lower letters and numbers.'**
  String get validationPasswordWeak;

  /// No description provided for @validationMinLength.
  ///
  /// In en, this message translates to:
  /// **'Must be at least {min} characters.'**
  String validationMinLength(int min);

  /// No description provided for @validationMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Must be at most {max} characters.'**
  String validationMaxLength(int max);

  /// No description provided for @validationPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number.'**
  String get validationPhone;

  /// No description provided for @validationNumericRange.
  ///
  /// In en, this message translates to:
  /// **'Value must be between {min} and {max}.'**
  String validationNumericRange(String min, String max);

  /// No description provided for @validationMismatch.
  ///
  /// In en, this message translates to:
  /// **'Values do not match.'**
  String get validationMismatch;

  /// No description provided for @uiKitLocaleSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Localization & Direction'**
  String get uiKitLocaleSectionTitle;

  /// No description provided for @uiKitLocaleSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Preview locale and text direction behavior'**
  String get uiKitLocaleSectionSubtitle;

  /// No description provided for @uiKitLocaleLabel.
  ///
  /// In en, this message translates to:
  /// **'Locale'**
  String get uiKitLocaleLabel;

  /// No description provided for @uiKitDirectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get uiKitDirectionLabel;

  /// No description provided for @uiKitDirectionRtl.
  ///
  /// In en, this message translates to:
  /// **'RTL'**
  String get uiKitDirectionRtl;

  /// No description provided for @uiKitDirectionLtr.
  ///
  /// In en, this message translates to:
  /// **'LTR'**
  String get uiKitDirectionLtr;

  /// No description provided for @uiKitStorybookControlsTitle.
  ///
  /// In en, this message translates to:
  /// **'Storybook Controls'**
  String get uiKitStorybookControlsTitle;

  /// No description provided for @uiKitStorybookControlsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Preview components under different viewport/text-direction settings'**
  String get uiKitStorybookControlsSubtitle;

  /// No description provided for @uiKitViewportLabel.
  ///
  /// In en, this message translates to:
  /// **'Viewport'**
  String get uiKitViewportLabel;

  /// No description provided for @uiKitViewportAdaptive.
  ///
  /// In en, this message translates to:
  /// **'Adaptive'**
  String get uiKitViewportAdaptive;

  /// No description provided for @uiKitViewportPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get uiKitViewportPhone;

  /// No description provided for @uiKitViewportTablet.
  ///
  /// In en, this message translates to:
  /// **'Tablet'**
  String get uiKitViewportTablet;

  /// No description provided for @uiKitViewportDesktop.
  ///
  /// In en, this message translates to:
  /// **'Desktop'**
  String get uiKitViewportDesktop;

  /// No description provided for @uiKitTextScaleLabel.
  ///
  /// In en, this message translates to:
  /// **'Text scale'**
  String get uiKitTextScaleLabel;

  /// No description provided for @uiKitRtlPreviewLabel.
  ///
  /// In en, this message translates to:
  /// **'Force RTL preview'**
  String get uiKitRtlPreviewLabel;

  /// No description provided for @uiKitRtlPreviewHelp.
  ///
  /// In en, this message translates to:
  /// **'Use this to test mirrored layouts without changing app language'**
  String get uiKitRtlPreviewHelp;

  /// No description provided for @uiKitButtonsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get uiKitButtonsSectionTitle;

  /// No description provided for @uiKitButtonsSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Primary, secondary, danger, link, and icon buttons'**
  String get uiKitButtonsSectionSubtitle;

  /// No description provided for @uiKitPrimaryAction.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get uiKitPrimaryAction;

  /// No description provided for @uiKitLoadingAction.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get uiKitLoadingAction;

  /// No description provided for @uiKitSecondaryAction.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get uiKitSecondaryAction;

  /// No description provided for @uiKitTextLinkAction.
  ///
  /// In en, this message translates to:
  /// **'Text link'**
  String get uiKitTextLinkAction;

  /// No description provided for @uiKitLikeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get uiKitLikeTooltip;

  /// No description provided for @uiKitInputsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Inputs'**
  String get uiKitInputsSectionTitle;

  /// No description provided for @uiKitInputsSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Text, password, search, and dropdown fields'**
  String get uiKitInputsSectionSubtitle;

  /// No description provided for @uiKitNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get uiKitNameLabel;

  /// No description provided for @uiKitNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get uiKitNameHint;

  /// No description provided for @uiKitPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get uiKitPasswordLabel;

  /// No description provided for @uiKitPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get uiKitPasswordHint;

  /// No description provided for @uiKitShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get uiKitShowPassword;

  /// No description provided for @uiKitHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get uiKitHidePassword;

  /// No description provided for @uiKitClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get uiKitClearSearch;

  /// No description provided for @uiKitRoleLabel.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get uiKitRoleLabel;

  /// No description provided for @uiKitRoleHint.
  ///
  /// In en, this message translates to:
  /// **'Select role'**
  String get uiKitRoleHint;

  /// No description provided for @uiKitRoleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get uiKitRoleUser;

  /// No description provided for @uiKitRoleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get uiKitRoleAdmin;

  /// No description provided for @uiKitRoleReviewer.
  ///
  /// In en, this message translates to:
  /// **'Reviewer'**
  String get uiKitRoleReviewer;

  /// No description provided for @uiKitStatesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'State Surfaces'**
  String get uiKitStatesSectionTitle;

  /// No description provided for @uiKitStatesSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Preview loading/empty/error/content states'**
  String get uiKitStatesSectionSubtitle;

  /// No description provided for @uiKitStateLoadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get uiKitStateLoadingLabel;

  /// No description provided for @uiKitStateEmptyLabel.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get uiKitStateEmptyLabel;

  /// No description provided for @uiKitStateErrorLabel.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get uiKitStateErrorLabel;

  /// No description provided for @uiKitStateContentLabel.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get uiKitStateContentLabel;

  /// No description provided for @uiKitStateContentTitle.
  ///
  /// In en, this message translates to:
  /// **'Content state'**
  String get uiKitStateContentTitle;

  /// No description provided for @uiKitStateContentMessage.
  ///
  /// In en, this message translates to:
  /// **'This is the normal content presentation state.'**
  String get uiKitStateContentMessage;

  /// No description provided for @uiKitMediaSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Media & Skeletons'**
  String get uiKitMediaSectionTitle;

  /// No description provided for @uiKitMediaSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Network image wrapper and loading placeholders'**
  String get uiKitMediaSectionSubtitle;

  /// No description provided for @uiKitNetworkImageLabel.
  ///
  /// In en, this message translates to:
  /// **'AppNetworkImage'**
  String get uiKitNetworkImageLabel;

  /// No description provided for @uiKitSkeletonCardLabel.
  ///
  /// In en, this message translates to:
  /// **'Card skeleton'**
  String get uiKitSkeletonCardLabel;

  /// No description provided for @uiKitSkeletonListLabel.
  ///
  /// In en, this message translates to:
  /// **'List skeleton'**
  String get uiKitSkeletonListLabel;

  /// No description provided for @uiKitSkeletonDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Details skeleton'**
  String get uiKitSkeletonDetailsLabel;

  /// No description provided for @uiKitLayoutSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Layout Components'**
  String get uiKitLayoutSectionTitle;

  /// No description provided for @uiKitLayoutSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Card, list tile, and divider patterns'**
  String get uiKitLayoutSectionSubtitle;

  /// No description provided for @uiKitListItemTitle.
  ///
  /// In en, this message translates to:
  /// **'AppListTile Item'**
  String get uiKitListItemTitle;

  /// No description provided for @uiKitListItemSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reusable list tile with theme defaults'**
  String get uiKitListItemSubtitle;

  /// No description provided for @uiKitThemeTokensTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme tokens applied'**
  String get uiKitThemeTokensTitle;

  /// No description provided for @uiKitThemeTokensSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Spacing and radius from centralized tokens'**
  String get uiKitThemeTokensSubtitle;

  /// No description provided for @uiKitFeedbackSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback & Navigation'**
  String get uiKitFeedbackSectionTitle;

  /// No description provided for @uiKitFeedbackSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Dialogs, sheets, toasts, and bottom navigation template'**
  String get uiKitFeedbackSectionSubtitle;

  /// No description provided for @uiKitShowToastAction.
  ///
  /// In en, this message translates to:
  /// **'Show toast'**
  String get uiKitShowToastAction;

  /// No description provided for @uiKitShowDialogAction.
  ///
  /// In en, this message translates to:
  /// **'Show confirm dialog'**
  String get uiKitShowDialogAction;

  /// No description provided for @uiKitShowBottomSheetAction.
  ///
  /// In en, this message translates to:
  /// **'Show bottom sheet'**
  String get uiKitShowBottomSheetAction;

  /// No description provided for @uiKitShowSelectionSheetAction.
  ///
  /// In en, this message translates to:
  /// **'Show selection sheet'**
  String get uiKitShowSelectionSheetAction;

  /// No description provided for @uiKitShowConfirmationSheetAction.
  ///
  /// In en, this message translates to:
  /// **'Show confirmation sheet'**
  String get uiKitShowConfirmationSheetAction;

  /// No description provided for @uiKitOpenBottomNavDemoAction.
  ///
  /// In en, this message translates to:
  /// **'Open bottom-nav demo'**
  String get uiKitOpenBottomNavDemoAction;

  /// No description provided for @uiKitBottomNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Bottom Navigation Template'**
  String get uiKitBottomNavTitle;

  /// No description provided for @uiKitHomeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get uiKitHomeTab;

  /// No description provided for @uiKitOrdersTab.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get uiKitOrdersTab;

  /// No description provided for @uiKitProfileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get uiKitProfileTab;

  /// No description provided for @uiKitStatusSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Status Banners'**
  String get uiKitStatusSectionTitle;

  /// No description provided for @uiKitStatusSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Inline banners for success/warning/info'**
  String get uiKitStatusSectionSubtitle;

  /// No description provided for @uiKitSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get uiKitSuccessTitle;

  /// No description provided for @uiKitSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get uiKitSuccessMessage;

  /// No description provided for @uiKitWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get uiKitWarningTitle;

  /// No description provided for @uiKitWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'Using stale cached data while offline.'**
  String get uiKitWarningMessage;

  /// No description provided for @uiKitInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get uiKitInfoTitle;

  /// No description provided for @uiKitInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap action to open informational bottom sheet.'**
  String get uiKitInfoMessage;

  /// No description provided for @uiKitLearnMoreAction.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get uiKitLearnMoreAction;

  /// No description provided for @uiKitInfoSheetMessage.
  ///
  /// In en, this message translates to:
  /// **'This is a reusable inline status banner.'**
  String get uiKitInfoSheetMessage;

  /// No description provided for @uiKitPermissionsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get uiKitPermissionsSectionTitle;

  /// No description provided for @uiKitPermissionsSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Graceful behavior when providers are unconfigured'**
  String get uiKitPermissionsSectionSubtitle;

  /// No description provided for @uiKitPermissionLabel.
  ///
  /// In en, this message translates to:
  /// **'Permission'**
  String get uiKitPermissionLabel;

  /// No description provided for @uiKitCheckAction.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get uiKitCheckAction;

  /// No description provided for @uiKitRequestAction.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get uiKitRequestAction;

  /// No description provided for @uiKitNoDetails.
  ///
  /// In en, this message translates to:
  /// **'No details.'**
  String get uiKitNoDetails;

  /// No description provided for @uiKitPermissionResultPrefix.
  ///
  /// In en, this message translates to:
  /// **'Permission result'**
  String get uiKitPermissionResultPrefix;

  /// No description provided for @uiKitBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Bottom Sheet Title'**
  String get uiKitBottomSheetTitle;

  /// No description provided for @uiKitBottomSheetMessage.
  ///
  /// In en, this message translates to:
  /// **'This is a reusable bottom sheet wrapper.'**
  String get uiKitBottomSheetMessage;

  /// No description provided for @uiKitConfirmActionTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Action'**
  String get uiKitConfirmActionTitle;

  /// No description provided for @uiKitConfirmActionMessage.
  ///
  /// In en, this message translates to:
  /// **'This dialog is part of the shared UI kit.'**
  String get uiKitConfirmActionMessage;

  /// No description provided for @uiKitSelectionSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose one action'**
  String get uiKitSelectionSheetTitle;

  /// No description provided for @uiKitArchiveAction.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get uiKitArchiveAction;

  /// No description provided for @uiKitPinAction.
  ///
  /// In en, this message translates to:
  /// **'Pin'**
  String get uiKitPinAction;

  /// No description provided for @uiKitDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get uiKitDeleteAction;

  /// No description provided for @uiKitSelectedPrefix.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get uiKitSelectedPrefix;

  /// No description provided for @uiKitDestructiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm destructive action'**
  String get uiKitDestructiveTitle;

  /// No description provided for @uiKitDestructiveMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get uiKitDestructiveMessage;

  /// No description provided for @openDemandsTitle.
  ///
  /// In en, this message translates to:
  /// **'File a claim'**
  String get openDemandsTitle;

  /// No description provided for @openDemandsWhyLocationHeading.
  ///
  /// In en, this message translates to:
  /// **'Why do we need your location?'**
  String get openDemandsWhyLocationHeading;

  /// No description provided for @openDemandsLocationBenefitOne.
  ///
  /// In en, this message translates to:
  /// **'It documents the circumstances when you file your claim'**
  String get openDemandsLocationBenefitOne;

  /// No description provided for @openDemandsLocationBenefitTwo.
  ///
  /// In en, this message translates to:
  /// **'It helps the review team assess your claim sooner'**
  String get openDemandsLocationBenefitTwo;

  /// No description provided for @openDemandsLocationBenefitThree.
  ///
  /// In en, this message translates to:
  /// **'We use it only for this claim and never share it'**
  String get openDemandsLocationBenefitThree;

  /// No description provided for @openDemandsStepLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get openDemandsStepLocation;

  /// No description provided for @openDemandsStepEvidence.
  ///
  /// In en, this message translates to:
  /// **'Evidence'**
  String get openDemandsStepEvidence;

  /// No description provided for @openDemandsStepReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get openDemandsStepReview;

  /// No description provided for @openDemandsLocationBadge.
  ///
  /// In en, this message translates to:
  /// **'Enable location'**
  String get openDemandsLocationBadge;

  /// No description provided for @openDemandsLocationHeading.
  ///
  /// In en, this message translates to:
  /// **'We need your current location'**
  String get openDemandsLocationHeading;

  /// No description provided for @openDemandsLocationDescription.
  ///
  /// In en, this message translates to:
  /// **'Your location helps us verify the claim details and supports the review team when assessing your claim. It is used only for this claim.'**
  String get openDemandsLocationDescription;

  /// No description provided for @openDemandsAllowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow location'**
  String get openDemandsAllowLocation;

  /// No description provided for @openDemandsNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get openDemandsNotNow;

  /// No description provided for @openDemandsLocationGranted.
  ///
  /// In en, this message translates to:
  /// **'Location permission granted.'**
  String get openDemandsLocationGranted;

  /// No description provided for @openDemandsLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission was not granted.'**
  String get openDemandsLocationDenied;

  /// No description provided for @openDemandsLocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location access is not configured on this device yet.'**
  String get openDemandsLocationUnavailable;

  /// No description provided for @openDemandsLocationDisabledBadge.
  ///
  /// In en, this message translates to:
  /// **'Location is disabled'**
  String get openDemandsLocationDisabledBadge;

  /// No description provided for @openDemandsLocationDeclinedHeading.
  ///
  /// In en, this message translates to:
  /// **'Not sharing your location may affect your claim assessment'**
  String get openDemandsLocationDeclinedHeading;

  /// No description provided for @openDemandsLocationDeclinedDescription.
  ///
  /// In en, this message translates to:
  /// **'Location information helps clarify the circumstances of your claim. Without it, the Haseen review team may have less information, but you can still complete your claim normally.'**
  String get openDemandsLocationDeclinedDescription;

  /// No description provided for @openDemandsSkippedWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Without your location, your claim assessment may be affected'**
  String get openDemandsSkippedWarningTitle;

  /// No description provided for @openDemandsSkippedWarningDescription.
  ///
  /// In en, this message translates to:
  /// **'Your location helps the Haseen team understand your claim during review. You can still submit your claim without it.'**
  String get openDemandsSkippedWarningDescription;

  /// No description provided for @openDemandsContinueWithoutLocation.
  ///
  /// In en, this message translates to:
  /// **'Continue without location'**
  String get openDemandsContinueWithoutLocation;

  /// No description provided for @demandDetailsLocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable, noted for your claim'**
  String get demandDetailsLocationUnavailable;

  /// No description provided for @demandDetailsLocationAvailable.
  ///
  /// In en, this message translates to:
  /// **'Location recorded for this claim'**
  String get demandDetailsLocationAvailable;

  /// No description provided for @demandDetailsHeading.
  ///
  /// In en, this message translates to:
  /// **'Let’s document your shipment'**
  String get demandDetailsHeading;

  /// No description provided for @demandDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'A few photos and a short video will help us review.'**
  String get demandDetailsDescription;

  /// No description provided for @demandDetailsEvidenceQuestion.
  ///
  /// In en, this message translates to:
  /// **'What should we photograph?'**
  String get demandDetailsEvidenceQuestion;

  /// No description provided for @demandDetailsEvidenceAdded.
  ///
  /// In en, this message translates to:
  /// **'Evidence added'**
  String get demandDetailsEvidenceAdded;

  /// No description provided for @demandDetailsEvidenceDocuments.
  ///
  /// In en, this message translates to:
  /// **'Label and documents'**
  String get demandDetailsEvidenceDocuments;

  /// No description provided for @demandDetailsEvidencePackaging.
  ///
  /// In en, this message translates to:
  /// **'Packaging and item'**
  String get demandDetailsEvidencePackaging;

  /// No description provided for @demandDetailsEvidenceDamageVideo.
  ///
  /// In en, this message translates to:
  /// **'Short video of the damage'**
  String get demandDetailsEvidenceDamageVideo;

  /// No description provided for @demandDetailsDocumentsHint.
  ///
  /// In en, this message translates to:
  /// **'One photo of the label and tracking number'**
  String get demandDetailsDocumentsHint;

  /// No description provided for @demandDetailsPackagingHint.
  ///
  /// In en, this message translates to:
  /// **'One photo showing the damage'**
  String get demandDetailsPackagingHint;

  /// No description provided for @demandDetailsVideoHint.
  ///
  /// In en, this message translates to:
  /// **'About 10 seconds'**
  String get demandDetailsVideoHint;

  /// No description provided for @demandDetailsOnePhoto.
  ///
  /// In en, this message translates to:
  /// **'1 photo'**
  String get demandDetailsOnePhoto;

  /// No description provided for @demandDetailsAboutTenSeconds.
  ///
  /// In en, this message translates to:
  /// **'About 10 seconds'**
  String get demandDetailsAboutTenSeconds;

  /// No description provided for @demandDetailsOptionalImages.
  ///
  /// In en, this message translates to:
  /// **'Additional photos (optional)'**
  String get demandDetailsOptionalImages;

  /// No description provided for @demandDetailsAddImage.
  ///
  /// In en, this message translates to:
  /// **'Add a photo'**
  String get demandDetailsAddImage;

  /// No description provided for @demandDetailsStartDocumentation.
  ///
  /// In en, this message translates to:
  /// **'Let’s start documenting'**
  String get demandDetailsStartDocumentation;

  /// No description provided for @demandDetailsContinueDocumentation.
  ///
  /// In en, this message translates to:
  /// **'Continue documentation'**
  String get demandDetailsContinueDocumentation;

  /// No description provided for @demandDetailsNextReview.
  ///
  /// In en, this message translates to:
  /// **'Next: Review claim'**
  String get demandDetailsNextReview;

  /// No description provided for @demandDetailsRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get demandDetailsRetake;

  /// No description provided for @demandDetailsReviewComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Claim review will be available when the claims flow is enabled.'**
  String get demandDetailsReviewComingSoon;

  /// No description provided for @demandDetailsUploadComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Attachments will be available when claim uploads are enabled.'**
  String get demandDetailsUploadComingSoon;

  /// No description provided for @demandReviewHeading.
  ///
  /// In en, this message translates to:
  /// **'Review and submit your claim'**
  String get demandReviewHeading;

  /// No description provided for @demandReviewDescription.
  ///
  /// In en, this message translates to:
  /// **'Check the details, then the Haseen team will receive it'**
  String get demandReviewDescription;

  /// No description provided for @demandReviewLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Your location'**
  String get demandReviewLocationTitle;

  /// No description provided for @demandReviewLocationMissing.
  ///
  /// In en, this message translates to:
  /// **'Location is turned off'**
  String get demandReviewLocationMissing;

  /// No description provided for @demandReviewLocationMissingDescription.
  ///
  /// In en, this message translates to:
  /// **'This may affect the assessment of your claim'**
  String get demandReviewLocationMissingDescription;

  /// No description provided for @demandReviewLocationCurrent.
  ///
  /// In en, this message translates to:
  /// **'Your current location'**
  String get demandReviewLocationCurrent;

  /// No description provided for @demandReviewLocationEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get demandReviewLocationEnable;

  /// No description provided for @demandReviewEvidenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Evidence'**
  String get demandReviewEvidenceTitle;

  /// No description provided for @demandReviewFileCount.
  ///
  /// In en, this message translates to:
  /// **'{count} files ✓'**
  String demandReviewFileCount(int count);

  /// No description provided for @demandReviewLabelPhoto.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get demandReviewLabelPhoto;

  /// No description provided for @demandReviewPackagingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Packaging'**
  String get demandReviewPackagingPhoto;

  /// No description provided for @demandReviewVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get demandReviewVideo;

  /// No description provided for @demandReviewAdditionalPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get demandReviewAdditionalPhoto;

  /// No description provided for @demandReviewDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'What happened to the item?'**
  String get demandReviewDescriptionTitle;

  /// No description provided for @demandReviewDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the damage... for example: the screen is scratched'**
  String get demandReviewDescriptionHint;

  /// No description provided for @demandReviewCharacterCount.
  ///
  /// In en, this message translates to:
  /// **'{count}/300'**
  String demandReviewCharacterCount(int count);

  /// No description provided for @demandReviewSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit claim'**
  String get demandReviewSubmit;

  /// No description provided for @demandReviewSubmitComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Claim submission will be available when claims are enabled.'**
  String get demandReviewSubmitComingSoon;

  /// No description provided for @cameraPermissionHeading.
  ///
  /// In en, this message translates to:
  /// **'We need camera access'**
  String get cameraPermissionHeading;

  /// No description provided for @cameraPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'We only use the camera to document the shipment condition for your claim. Enable camera access in your app or device settings, then try again.'**
  String get cameraPermissionDescription;

  /// No description provided for @cameraPermissionDeniedDescription.
  ///
  /// In en, this message translates to:
  /// **'Camera access was denied. Enable it in app settings, then return and try again.'**
  String get cameraPermissionDeniedDescription;

  /// No description provided for @cameraCaptureFailedDescription.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t open the camera. Check that it is available and try again.'**
  String get cameraCaptureFailedDescription;

  /// No description provided for @cameraPermissionAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow camera'**
  String get cameraPermissionAllow;

  /// No description provided for @cameraPermissionOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get cameraPermissionOpenSettings;

  /// No description provided for @cameraPermissionNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get cameraPermissionNotNow;

  /// No description provided for @cameraGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'Photograph the label and documents'**
  String get cameraGuideTitle;

  /// No description provided for @cameraGuideQuestion.
  ///
  /// In en, this message translates to:
  /// **'What to capture?'**
  String get cameraGuideQuestion;

  /// No description provided for @cameraGuidePhotoHint.
  ///
  /// In en, this message translates to:
  /// **'One clear photo is enough. Make sure the label can be read.'**
  String get cameraGuidePhotoHint;

  /// No description provided for @cameraGuideShippingLabel.
  ///
  /// In en, this message translates to:
  /// **'Shipping label'**
  String get cameraGuideShippingLabel;

  /// No description provided for @cameraGuideTrackingNumber.
  ///
  /// In en, this message translates to:
  /// **'Tracking number'**
  String get cameraGuideTrackingNumber;

  /// No description provided for @cameraGuideIncludedDocuments.
  ///
  /// In en, this message translates to:
  /// **'Any documents that came with the parcel'**
  String get cameraGuideIncludedDocuments;

  /// No description provided for @cameraHelp.
  ///
  /// In en, this message translates to:
  /// **'Camera help'**
  String get cameraHelp;

  /// No description provided for @cameraGuideDocuments.
  ///
  /// In en, this message translates to:
  /// **'Shipment label, tracking number, and any included documents'**
  String get cameraGuideDocuments;

  /// No description provided for @cameraGuidePackaging.
  ///
  /// In en, this message translates to:
  /// **'Packaging and product from clear angles'**
  String get cameraGuidePackaging;

  /// No description provided for @cameraGuideDamage.
  ///
  /// In en, this message translates to:
  /// **'A short video showing the damaged areas'**
  String get cameraGuideDamage;

  /// No description provided for @cameraGuideReady.
  ///
  /// In en, this message translates to:
  /// **'Ready, let’s take a photo'**
  String get cameraGuideReady;

  /// No description provided for @cameraCapture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get cameraCapture;

  /// No description provided for @cameraStartRecording.
  ///
  /// In en, this message translates to:
  /// **'Start recording'**
  String get cameraStartRecording;

  /// No description provided for @cameraStopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop recording'**
  String get cameraStopRecording;

  /// No description provided for @cameraPhotoModeLabel.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get cameraPhotoModeLabel;

  /// No description provided for @cameraVideoModeLabel.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get cameraVideoModeLabel;

  /// No description provided for @cameraFramingHint.
  ///
  /// In en, this message translates to:
  /// **'Move closer and keep the whole label in frame'**
  String get cameraFramingHint;

  /// No description provided for @cameraVideoFramingHint.
  ///
  /// In en, this message translates to:
  /// **'Move slowly around the parcel and focus on the damage'**
  String get cameraVideoFramingHint;

  /// No description provided for @cameraFlash.
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get cameraFlash;

  /// No description provided for @cameraSwitch.
  ///
  /// In en, this message translates to:
  /// **'Switch camera'**
  String get cameraSwitch;

  /// No description provided for @cameraRecording.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get cameraRecording;

  /// No description provided for @cameraCaptureError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t start the camera. Check permission and try again.'**
  String get cameraCaptureError;

  /// No description provided for @cameraRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get cameraRetry;

  /// No description provided for @cameraPhotoLooksClear.
  ///
  /// In en, this message translates to:
  /// **'Photo looks clear ✓'**
  String get cameraPhotoLooksClear;

  /// No description provided for @cameraUsePhoto.
  ///
  /// In en, this message translates to:
  /// **'Use photo'**
  String get cameraUsePhoto;

  /// No description provided for @cameraRetakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Retake photo'**
  String get cameraRetakePhoto;

  /// No description provided for @cameraExitTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit?'**
  String get cameraExitTitle;

  /// No description provided for @cameraExitDescription.
  ///
  /// In en, this message translates to:
  /// **'Your evidence will not be saved, and you will need to start this claim again.'**
  String get cameraExitDescription;

  /// No description provided for @cameraContinueClaim.
  ///
  /// In en, this message translates to:
  /// **'Continue claim'**
  String get cameraContinueClaim;

  /// No description provided for @cameraExitClaim.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get cameraExitClaim;

  /// No description provided for @cameraVideoLooksClear.
  ///
  /// In en, this message translates to:
  /// **'Video looks clear ✓'**
  String get cameraVideoLooksClear;

  /// No description provided for @cameraUseVideo.
  ///
  /// In en, this message translates to:
  /// **'Use video'**
  String get cameraUseVideo;

  /// No description provided for @cameraRetakeVideo.
  ///
  /// In en, this message translates to:
  /// **'Retake video'**
  String get cameraRetakeVideo;

  /// No description provided for @cameraPhotoCaptured.
  ///
  /// In en, this message translates to:
  /// **'Photo captured and added to the claim.'**
  String get cameraPhotoCaptured;

  /// No description provided for @navigationBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get navigationBack;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit your profile'**
  String get profileEditTitle;

  /// No description provided for @profileEditSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your information up to date'**
  String get profileEditSubtitle;

  /// No description provided for @profileEditPhoto.
  ///
  /// In en, this message translates to:
  /// **'Change your photo'**
  String get profileEditPhoto;

  /// No description provided for @profileEditFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get profileEditFullNameLabel;

  /// No description provided for @profileEditFullName.
  ///
  /// In en, this message translates to:
  /// **'Abdullah Al Otaibi'**
  String get profileEditFullName;

  /// No description provided for @profileEditPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get profileEditPhoneLabel;

  /// No description provided for @profileEditPhoneHelper.
  ///
  /// In en, this message translates to:
  /// **'If you change your number, we\'ll send a verification code to the new number'**
  String get profileEditPhoneHelper;

  /// No description provided for @profileEditEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email (optional)'**
  String get profileEditEmailLabel;

  /// No description provided for @profileEditEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get profileEditEmailHint;

  /// No description provided for @profileEditSave.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get profileEditSave;

  /// No description provided for @profileEditPhoneReadOnly.
  ///
  /// In en, this message translates to:
  /// **'Phone number changes are not available here.'**
  String get profileEditPhoneReadOnly;

  /// No description provided for @profileEditAvatarUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Profile photo changes are not available yet.'**
  String get profileEditAvatarUnavailable;

  /// No description provided for @profileEditEmailCannotRemove.
  ///
  /// In en, this message translates to:
  /// **'Email removal is not available here.'**
  String get profileEditEmailCannotRemove;

  /// No description provided for @profileEditSaved.
  ///
  /// In en, this message translates to:
  /// **'Your profile has been updated.'**
  String get profileEditSaved;

  /// No description provided for @phoneChangeSend.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get phoneChangeSend;

  /// No description provided for @phoneChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Change phone number'**
  String get phoneChangeTitle;

  /// No description provided for @phoneChangeCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current phone number'**
  String get phoneChangeCurrent;

  /// No description provided for @phoneChangeNew.
  ///
  /// In en, this message translates to:
  /// **'New phone number'**
  String get phoneChangeNew;

  /// No description provided for @phoneChangeNewHint.
  ///
  /// In en, this message translates to:
  /// **'05XXXXXXXX'**
  String get phoneChangeNewHint;

  /// No description provided for @phoneChangeVerifyFirst.
  ///
  /// In en, this message translates to:
  /// **'Verify the new phone number before saving.'**
  String get phoneChangeVerifyFirst;

  /// No description provided for @phoneChangeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Saudi mobile number.'**
  String get phoneChangeInvalid;

  /// No description provided for @phoneChangeSame.
  ///
  /// In en, this message translates to:
  /// **'Enter a different phone number.'**
  String get phoneChangeSame;

  /// No description provided for @phoneChangeSent.
  ///
  /// In en, this message translates to:
  /// **'Enter the four-digit code sent to {phone}.'**
  String phoneChangeSent(String phone);

  /// No description provided for @phoneChangeVerified.
  ///
  /// In en, this message translates to:
  /// **'Phone number updated.'**
  String get phoneChangeVerified;

  /// No description provided for @phoneChangeResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get phoneChangeResend;

  /// No description provided for @phoneChangeWait.
  ///
  /// In en, this message translates to:
  /// **'You can request another code in {seconds} seconds.'**
  String phoneChangeWait(int seconds);

  /// No description provided for @profileEditSaveUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Saving profile changes is not available yet.'**
  String get profileEditSaveUnavailable;

  /// No description provided for @profileEditPhotoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not open photos right now.'**
  String get profileEditPhotoUnavailable;

  /// No description provided for @notificationSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationSettingsTitle;

  /// No description provided for @notificationSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose what you hear from us'**
  String get notificationSettingsSubtitle;

  /// No description provided for @notificationPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications'**
  String get notificationPermissionTitle;

  /// No description provided for @notificationPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Turn them on so you don\'t miss updates'**
  String get notificationPermissionDescription;

  /// No description provided for @notificationShipmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Shipment updates'**
  String get notificationShipmentTitle;

  /// No description provided for @notificationShipmentDescription.
  ///
  /// In en, this message translates to:
  /// **'Where your shipment is and when it arrives'**
  String get notificationShipmentDescription;

  /// No description provided for @notificationClaimTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim updates'**
  String get notificationClaimTitle;

  /// No description provided for @notificationClaimDescription.
  ///
  /// In en, this message translates to:
  /// **'News about your claims or compensation'**
  String get notificationClaimDescription;

  /// No description provided for @notificationOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'Store offers'**
  String get notificationOffersTitle;

  /// No description provided for @notificationOffersDescription.
  ///
  /// In en, this message translates to:
  /// **'Offers and discounts from partner stores'**
  String get notificationOffersDescription;

  /// No description provided for @notificationSettingsNote.
  ///
  /// In en, this message translates to:
  /// **'You can change these settings anytime and stay up to date on your claims.'**
  String get notificationSettingsNote;

  /// No description provided for @activityTitle.
  ///
  /// In en, this message translates to:
  /// **'Your activity'**
  String get activityTitle;

  /// No description provided for @activitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Everything happening with your shipments and claims'**
  String get activitySubtitle;

  /// No description provided for @activityFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get activityFilterAll;

  /// No description provided for @activityFilterShipments.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get activityFilterShipments;

  /// No description provided for @activityFilterClaims.
  ///
  /// In en, this message translates to:
  /// **'Claims'**
  String get activityFilterClaims;

  /// No description provided for @activityLatestFirst.
  ///
  /// In en, this message translates to:
  /// **'Latest first'**
  String get activityLatestFirst;

  /// No description provided for @activityOldestFirst.
  ///
  /// In en, this message translates to:
  /// **'Oldest first'**
  String get activityOldestFirst;

  /// No description provided for @activityToday.
  ///
  /// In en, this message translates to:
  /// **'Today, October 6'**
  String get activityToday;

  /// No description provided for @activityYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, October 5'**
  String get activityYesterday;

  /// No description provided for @activityOctoberThird.
  ///
  /// In en, this message translates to:
  /// **'October 3'**
  String get activityOctoberThird;

  /// No description provided for @activityOctoberSecond.
  ///
  /// In en, this message translates to:
  /// **'October 2'**
  String get activityOctoberSecond;

  /// No description provided for @activityOctoberFirst.
  ///
  /// In en, this message translates to:
  /// **'October 1'**
  String get activityOctoberFirst;

  /// No description provided for @activityTime1040.
  ///
  /// In en, this message translates to:
  /// **'10:40 AM'**
  String get activityTime1040;

  /// No description provided for @activityTime0915.
  ///
  /// In en, this message translates to:
  /// **'9:15 AM'**
  String get activityTime0915;

  /// No description provided for @activityTime0420.
  ///
  /// In en, this message translates to:
  /// **'4:20 PM'**
  String get activityTime0420;

  /// No description provided for @activityTime0210.
  ///
  /// In en, this message translates to:
  /// **'2:10 PM'**
  String get activityTime0210;

  /// No description provided for @activityTime1130.
  ///
  /// In en, this message translates to:
  /// **'11:30 AM'**
  String get activityTime1130;

  /// No description provided for @activityTime0805.
  ///
  /// In en, this message translates to:
  /// **'8:05 AM'**
  String get activityTime0805;

  /// No description provided for @activityShipmentOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Your shipment is out for delivery'**
  String get activityShipmentOutTitle;

  /// No description provided for @activityShipmentOutDescription.
  ///
  /// In en, this message translates to:
  /// **'Noon Store • Smart watch • HS-2048'**
  String get activityShipmentOutDescription;

  /// No description provided for @activityClaimReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Your claim is under review'**
  String get activityClaimReviewTitle;

  /// No description provided for @activityClaimReviewDescription.
  ///
  /// In en, this message translates to:
  /// **'Nice One • Men\'s fragrance • HS-1874'**
  String get activityClaimReviewDescription;

  /// No description provided for @activityCompensationTitle.
  ///
  /// In en, this message translates to:
  /// **'Your compensation arrived 🎉'**
  String get activityCompensationTitle;

  /// No description provided for @activityCompensationDescription.
  ///
  /// In en, this message translates to:
  /// **'SAR 180 • Claim HS-2039'**
  String get activityCompensationDescription;

  /// No description provided for @activityClaimSubmittedTitle.
  ///
  /// In en, this message translates to:
  /// **'We received your claim'**
  String get activityClaimSubmittedTitle;

  /// No description provided for @activityClaimSubmittedDescription.
  ///
  /// In en, this message translates to:
  /// **'Nice One • Men\'s fragrance • HS-1874'**
  String get activityClaimSubmittedDescription;

  /// No description provided for @activityShipmentDeliveredTitle.
  ///
  /// In en, this message translates to:
  /// **'Your shipment was delivered'**
  String get activityShipmentDeliveredTitle;

  /// No description provided for @activityShowOlder.
  ///
  /// In en, this message translates to:
  /// **'Show older activity'**
  String get activityShowOlder;

  /// No description provided for @activityShowLess.
  ///
  /// In en, this message translates to:
  /// **'Hide older activity'**
  String get activityShowLess;

  /// No description provided for @supportTicketsTitle.
  ///
  /// In en, this message translates to:
  /// **'Support tickets'**
  String get supportTicketsTitle;

  /// No description provided for @supportTicketsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'re here for you, and coffee\'s on us ☕'**
  String get supportTicketsSubtitle;

  /// No description provided for @supportTicketsStatAll.
  ///
  /// In en, this message translates to:
  /// **'All tickets'**
  String get supportTicketsStatAll;

  /// No description provided for @supportTicketsStatOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get supportTicketsStatOpen;

  /// No description provided for @supportTicketsStatResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get supportTicketsStatResolved;

  /// No description provided for @supportTicketsNewButton.
  ///
  /// In en, this message translates to:
  /// **'Open a new ticket'**
  String get supportTicketsNewButton;

  /// No description provided for @supportTicketsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get supportTicketsFilterAll;

  /// No description provided for @supportTicketsFilterShipments.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get supportTicketsFilterShipments;

  /// No description provided for @supportTicketsFilterCompensations.
  ///
  /// In en, this message translates to:
  /// **'Compensation'**
  String get supportTicketsFilterCompensations;

  /// No description provided for @supportTicketsStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get supportTicketsStatusInProgress;

  /// No description provided for @supportTicketsStatusWaiting.
  ///
  /// In en, this message translates to:
  /// **'Awaiting your reply'**
  String get supportTicketsStatusWaiting;

  /// No description provided for @supportTicketsCompensationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delayed compensation'**
  String get supportTicketsCompensationTitle;

  /// No description provided for @supportTicketsCompensationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'October 6, 2026 • ST-1052'**
  String get supportTicketsCompensationSubtitle;

  /// No description provided for @supportTicketsShipmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Update shipment details'**
  String get supportTicketsShipmentTitle;

  /// No description provided for @supportTicketsShipmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'October 5, 2026 • ST-1048'**
  String get supportTicketsShipmentSubtitle;

  /// No description provided for @supportTicketsLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last update'**
  String get supportTicketsLastUpdate;

  /// No description provided for @supportTicketsUpdateTwoHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'2 hours ago'**
  String get supportTicketsUpdateTwoHoursAgo;

  /// No description provided for @supportTicketsUpdateYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, 4:30 PM'**
  String get supportTicketsUpdateYesterday;

  /// No description provided for @supportTicketsCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get supportTicketsCategory;

  /// No description provided for @supportTicketsCompensationCategory.
  ///
  /// In en, this message translates to:
  /// **'Compensation'**
  String get supportTicketsCompensationCategory;

  /// No description provided for @supportTicketsShipmentCategory.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get supportTicketsShipmentCategory;

  /// No description provided for @supportTicketsViewTicket.
  ///
  /// In en, this message translates to:
  /// **'View ticket'**
  String get supportTicketsViewTicket;

  /// No description provided for @supportTicketsViewReply.
  ///
  /// In en, this message translates to:
  /// **'View reply'**
  String get supportTicketsViewReply;

  /// No description provided for @supportTicketsCreateUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Opening a new ticket is not available yet.'**
  String get supportTicketsCreateUnavailable;

  /// No description provided for @supportTicketsDetailsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Ticket details are not available yet.'**
  String get supportTicketsDetailsUnavailable;

  /// No description provided for @supportTicketConversationTitle.
  ///
  /// In en, this message translates to:
  /// **'Conversation'**
  String get supportTicketConversationTitle;

  /// No description provided for @supportTicketMessageCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 message} other{{count} messages}}'**
  String supportTicketMessageCount(int count);

  /// No description provided for @supportTicketConversationDate.
  ///
  /// In en, this message translates to:
  /// **'October 6, 2026'**
  String get supportTicketConversationDate;

  /// No description provided for @supportTicketCustomerMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, I still haven\'t received the compensation. Any updates?'**
  String get supportTicketCustomerMessage;

  /// No description provided for @supportTicketCustomerMetadata.
  ///
  /// In en, this message translates to:
  /// **'Abdullah • 9:15 AM'**
  String get supportTicketCustomerMetadata;

  /// No description provided for @supportTicketTeamName.
  ///
  /// In en, this message translates to:
  /// **'Husain team'**
  String get supportTicketTeamName;

  /// No description provided for @supportTicketTeamMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello Abdullah, thank you for contacting us. We are reviewing your compensation request with the relevant team and will keep you updated here.'**
  String get supportTicketTeamMessage;

  /// No description provided for @supportTicketReplySla.
  ///
  /// In en, this message translates to:
  /// **'The Husain team usually replies within 24 hours'**
  String get supportTicketReplySla;

  /// No description provided for @supportTicketReplyHint.
  ///
  /// In en, this message translates to:
  /// **'Write your reply here...'**
  String get supportTicketReplyHint;

  /// No description provided for @supportTicketAttachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach file'**
  String get supportTicketAttachFile;

  /// No description provided for @supportTicketSendReply.
  ///
  /// In en, this message translates to:
  /// **'Send reply'**
  String get supportTicketSendReply;

  /// No description provided for @supportTicketReplyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Replies are not available yet.'**
  String get supportTicketReplyUnavailable;

  /// No description provided for @createSupportTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'New ticket'**
  String get createSupportTicketTitle;

  /// No description provided for @createSupportTicketSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us what happened and we\'ll get back to you soon'**
  String get createSupportTicketSubtitle;

  /// No description provided for @createSupportTicketRequiredNote.
  ///
  /// In en, this message translates to:
  /// **'Fields marked with * are required'**
  String get createSupportTicketRequiredNote;

  /// No description provided for @createSupportTicketCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category *'**
  String get createSupportTicketCategoryLabel;

  /// No description provided for @createSupportTicketClaims.
  ///
  /// In en, this message translates to:
  /// **'Claims'**
  String get createSupportTicketClaims;

  /// No description provided for @createSupportTicketShipments.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get createSupportTicketShipments;

  /// No description provided for @createSupportTicketAccount.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get createSupportTicketAccount;

  /// No description provided for @createSupportTicketSubjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject *'**
  String get createSupportTicketSubjectLabel;

  /// No description provided for @createSupportTicketSubjectHint.
  ///
  /// In en, this message translates to:
  /// **'For example: Shipment delivery is delayed'**
  String get createSupportTicketSubjectHint;

  /// No description provided for @createSupportTicketDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'What is the issue? *'**
  String get createSupportTicketDescriptionLabel;

  /// No description provided for @createSupportTicketDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us what happened, when, and how we can help.'**
  String get createSupportTicketDescriptionHint;

  /// No description provided for @createSupportTicketCharacterCount.
  ///
  /// In en, this message translates to:
  /// **'{count} of {max}'**
  String createSupportTicketCharacterCount(int count, int max);

  /// No description provided for @createSupportTicketShipmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Shipment number (optional)'**
  String get createSupportTicketShipmentLabel;

  /// No description provided for @createSupportTicketShipmentHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the shipment number'**
  String get createSupportTicketShipmentHint;

  /// No description provided for @createSupportTicketShipmentHelper.
  ///
  /// In en, this message translates to:
  /// **'Find it in the shipment details to help us assist you faster'**
  String get createSupportTicketShipmentHelper;

  /// No description provided for @createSupportTicketAttachmentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Attachments (optional)'**
  String get createSupportTicketAttachmentsLabel;

  /// No description provided for @createSupportTicketUploadTitle.
  ///
  /// In en, this message translates to:
  /// **'Add photos or files'**
  String get createSupportTicketUploadTitle;

  /// No description provided for @createSupportTicketUploadDescription.
  ///
  /// In en, this message translates to:
  /// **'Up to 5 files, 10 MB each • JPG, PNG, PDF'**
  String get createSupportTicketUploadDescription;

  /// No description provided for @createSupportTicketRemoveAttachment.
  ///
  /// In en, this message translates to:
  /// **'Remove file'**
  String get createSupportTicketRemoveAttachment;

  /// No description provided for @createSupportTicketAttachmentLimit.
  ///
  /// In en, this message translates to:
  /// **'You can attach up to 5 files.'**
  String get createSupportTicketAttachmentLimit;

  /// No description provided for @createSupportTicketAttachmentSizeLimit.
  ///
  /// In en, this message translates to:
  /// **'Each file must be 10 MB or less.'**
  String get createSupportTicketAttachmentSizeLimit;

  /// No description provided for @createSupportTicketPickerError.
  ///
  /// In en, this message translates to:
  /// **'Could not open files right now.'**
  String get createSupportTicketPickerError;

  /// No description provided for @createSupportTicketRequiredError.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get createSupportTicketRequiredError;

  /// No description provided for @createSupportTicketSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send ticket'**
  String get createSupportTicketSubmit;

  /// No description provided for @createSupportTicketSubmitUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Ticket submission is not available yet.'**
  String get createSupportTicketSubmitUnavailable;

  /// No description provided for @claimDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim HS-2048'**
  String get claimDetailsTitle;

  /// No description provided for @claimDetailsProduct.
  ///
  /// In en, this message translates to:
  /// **'Smart watch – Gold Edition · 12 September'**
  String get claimDetailsProduct;

  /// No description provided for @claimDetailsAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get claimDetailsAccepted;

  /// No description provided for @claimDetailsSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Your claim was accepted'**
  String get claimDetailsSuccessTitle;

  /// No description provided for @claimDetailsSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'Your compensation is on its way and should arrive in 3–5 days'**
  String get claimDetailsSuccessBody;

  /// No description provided for @claimDetailsSettlement.
  ///
  /// In en, this message translates to:
  /// **'Settlement'**
  String get claimDetailsSettlement;

  /// No description provided for @claimDetailsTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim timeline'**
  String get claimDetailsTimelineTitle;

  /// No description provided for @claimDetailsSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Claim submitted'**
  String get claimDetailsSubmitted;

  /// No description provided for @claimDetailsReviewed.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get claimDetailsReviewed;

  /// No description provided for @claimDetailsDecision.
  ///
  /// In en, this message translates to:
  /// **'Accepted 🎉'**
  String get claimDetailsDecision;

  /// No description provided for @claimDetailsCompensation.
  ///
  /// In en, this message translates to:
  /// **'Compensation sent'**
  String get claimDetailsCompensation;

  /// No description provided for @claimDetailsSep6.
  ///
  /// In en, this message translates to:
  /// **'6 September'**
  String get claimDetailsSep6;

  /// No description provided for @claimDetailsSep7.
  ///
  /// In en, this message translates to:
  /// **'7 September'**
  String get claimDetailsSep7;

  /// No description provided for @claimDetailsEvidenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Evidence you sent'**
  String get claimDetailsEvidenceTitle;

  /// No description provided for @claimDetailsAttachment.
  ///
  /// In en, this message translates to:
  /// **'Additional'**
  String get claimDetailsAttachment;

  /// No description provided for @claimDetailsVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get claimDetailsVideo;

  /// No description provided for @claimDetailsPackaging.
  ///
  /// In en, this message translates to:
  /// **'Packaging'**
  String get claimDetailsPackaging;

  /// No description provided for @claimDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get claimDetailsLabel;

  /// No description provided for @claimDetailsLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Your location and notes'**
  String get claimDetailsLocationTitle;

  /// No description provided for @claimDetailsLocationCaption.
  ///
  /// In en, this message translates to:
  /// **'Location when the claim was submitted'**
  String get claimDetailsLocationCaption;

  /// No description provided for @claimDetailsLocation.
  ///
  /// In en, this message translates to:
  /// **'2415 King Fahd Road, Al Sahil, Al Rimal, Riyadh'**
  String get claimDetailsLocation;

  /// No description provided for @claimDetailsNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Your note'**
  String get claimDetailsNoteTitle;

  /// No description provided for @claimDetailsNote.
  ///
  /// In en, this message translates to:
  /// **'“The watch screen is cracked, and the carton was pressed in from the corner.”'**
  String get claimDetailsNote;

  /// No description provided for @claimDetailsDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim details'**
  String get claimDetailsDetailsTitle;

  /// No description provided for @claimDetailsClaimNumber.
  ///
  /// In en, this message translates to:
  /// **'Claim number'**
  String get claimDetailsClaimNumber;

  /// No description provided for @claimDetailsProductLabel.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get claimDetailsProductLabel;

  /// No description provided for @claimDetailsProductName.
  ///
  /// In en, this message translates to:
  /// **'Smart watch – Gold Edition'**
  String get claimDetailsProductName;

  /// No description provided for @claimDetailsItemPrice.
  ///
  /// In en, this message translates to:
  /// **'Item price'**
  String get claimDetailsItemPrice;

  /// No description provided for @claimDetailsClaimValue.
  ///
  /// In en, this message translates to:
  /// **'Claim value'**
  String get claimDetailsClaimValue;

  /// No description provided for @claimDetailsShipment.
  ///
  /// In en, this message translates to:
  /// **'Related shipment'**
  String get claimDetailsShipment;

  /// No description provided for @claimDetailsStore.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get claimDetailsStore;

  /// No description provided for @claimDetailsSubmittedDate.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get claimDetailsSubmittedDate;

  /// No description provided for @claimDetailsDecisionDate.
  ///
  /// In en, this message translates to:
  /// **'Decision date'**
  String get claimDetailsDecisionDate;

  /// No description provided for @claimDetailsTransferDate.
  ///
  /// In en, this message translates to:
  /// **'Transfer date'**
  String get claimDetailsTransferDate;

  /// No description provided for @claimDetailsSubmittedDateValue.
  ///
  /// In en, this message translates to:
  /// **'6 September 2026'**
  String get claimDetailsSubmittedDateValue;

  /// No description provided for @claimDetailsDecisionDateValue.
  ///
  /// In en, this message translates to:
  /// **'7 September 2026'**
  String get claimDetailsDecisionDateValue;

  /// No description provided for @claimDetailsTransferDateValue.
  ///
  /// In en, this message translates to:
  /// **'7 September 2026'**
  String get claimDetailsTransferDateValue;

  /// No description provided for @claimDetailsStoreName.
  ///
  /// In en, this message translates to:
  /// **'Noon Store'**
  String get claimDetailsStoreName;

  /// No description provided for @claimDetailsSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all details'**
  String get claimDetailsSeeAll;

  /// No description provided for @claimDetailsHide.
  ///
  /// In en, this message translates to:
  /// **'Hide details'**
  String get claimDetailsHide;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
