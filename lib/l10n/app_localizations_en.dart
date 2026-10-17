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
    return 'We sent a 6-digit code to $contact';
  }

  @override
  String otpPhoneDestination(Object contact) {
    return 'We sent a 6-digit code to your number ending in $contact';
  }

  @override
  String otpEmailDestination(Object contact) {
    return 'We sent a 6-digit code to $contact';
  }

  @override
  String get otpPhoneLengthHint => 'Enter the 4-digit code';

  @override
  String get otpEmailLengthHint => 'Enter the 6-digit code';

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
  String get otpSubtitle => 'We sent a 6-digit code to your number';

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
      'Check the order confirmation email from the merchant';

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
  String get homeTitle => 'Track your shipments today';

  @override
  String get homeActiveShipments => 'Your active shipments';

  @override
  String get myShipmentsSubtitle =>
      'Coverage for damage, loss and delays on merchant shipments';

  @override
  String get myShipmentsActiveTab => 'Active 2';

  @override
  String get myShipmentsDeliveredTab => 'Delivered 1';

  @override
  String get homeActiveClaims => 'Your active claims';

  @override
  String get homeSeeAllShipments => 'See all';

  @override
  String get homeShipmentMerchant => 'Noon store';

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
  String get shipmentDetailsTitle => 'Shipment details';

  @override
  String get shipmentProtectionTitle => 'Shipment protection';

  @override
  String get shipmentProtectionCoveredBy => 'Protected by Haseen';

  @override
  String get shipmentProtectionValueLabel => 'Coverage value';

  @override
  String get shipmentProtectionValue => 'SAR 480';

  @override
  String get shipmentProtectionStatusLabel => 'Status';

  @override
  String get shipmentProtectionStatus => 'Active';

  @override
  String get shipmentProtectionRemainingLabel => 'Claim window (12 days)';

  @override
  String get shipmentProtectionRemaining => 'Not activated';

  @override
  String get shipmentProtectionClaimAction => 'File a claim';

  @override
  String get shipmentTimelineTitle => 'Shipment journey';

  @override
  String get shipmentTimelineOrdered => 'Order placed';

  @override
  String get shipmentTimelineShipped => 'Shipped';

  @override
  String get shipmentTimelineInTransit => 'In transit';

  @override
  String get shipmentTimelineDelivered => 'Delivered';

  @override
  String get shipmentTimelineOrderDate => 'October 1';

  @override
  String get shipmentDetailsSectionTitle => 'Shipment information';

  @override
  String get shipmentDetailsExpectedDelivery => 'Estimated delivery';

  @override
  String get shipmentDetailsExpectedDeliveryValue => 'Noon store';

  @override
  String get shipmentDetailsOrderDate => 'Order date';

  @override
  String get shipmentDetailsOrderDateValue => 'Friday, October 1';

  @override
  String get shipmentDetailsProduct => 'Product';

  @override
  String get shipmentDetailsProductValue => 'Wireless Pro earbuds';

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
  String get homeRequestTitle =>
      'Men\'s fragrance valued at SAR 100 from Nice One';

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
  String get homeHowItWorks => 'How it works';

  @override
  String get mainBannerGreeting => 'Welcome to Haseen 👋';

  @override
  String get mainBannerTitle => 'Your purchases are protected with Haseen';

  @override
  String get mainBannerDescription =>
      'When you shop with a partner store, your shipment appears here automatically. Protected from order to doorstep.';

  @override
  String get mainBannerAction => 'Explore partner stores';

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
  String get secondaryBannerTitle => 'Get to know Haseen shipment protection';

  @override
  String get secondaryBannerDescription =>
      'Coverage for damage, loss and delays on eligible merchant shipments.';

  @override
  String get secondaryBannerAction => 'Visit the blog';

  @override
  String get bottomNavHome => 'Home';

  @override
  String get bottomNavShipments => 'My shipments';

  @override
  String get bottomNavOrders => 'Orders';

  @override
  String get bottomNavStores => 'Merchant';

  @override
  String get bottomNavProfile => 'Profile';

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
  String get openDemandsContinueWithoutLocation => 'Continue without location';

  @override
  String get demandDetailsLocationUnavailable =>
      'Location unavailable; noted in your claim';

  @override
  String get demandDetailsLocationAvailable =>
      'Location recorded for this claim';

  @override
  String get demandDetailsHeading => 'Let’s document the shipment condition';

  @override
  String get demandDetailsDescription =>
      'A few photos and a short video help us document the shipment clearly. We’ll guide you through each step.';

  @override
  String get demandDetailsEvidenceDocuments => 'Label and documents';

  @override
  String get demandDetailsEvidencePackaging => 'Packaging and item';

  @override
  String get demandDetailsEvidenceDamageVideo =>
      'Short video of the damaged areas';

  @override
  String get demandDetailsOnePhoto => '1 photo';

  @override
  String get demandDetailsAboutTenSeconds => 'About 10 seconds';

  @override
  String get demandDetailsOptionalImages => 'Additional photos (optional*)';

  @override
  String get demandDetailsAddImage => 'Add a photo';

  @override
  String get demandDetailsStartDocumentation => 'Start documentation';

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
  String get cameraGuideTitle => 'Photograph the label and documents';

  @override
  String get cameraGuideQuestion => 'What to capture?';

  @override
  String get cameraGuideDocuments =>
      'Shipment label, tracking number, and any included documents';

  @override
  String get cameraGuidePackaging => 'Packaging and product from clear angles';

  @override
  String get cameraGuideDamage => 'A short video showing the damaged areas';

  @override
  String get cameraGuideReady => 'Ready';

  @override
  String get cameraCapture => 'Capture';

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
  String get cameraExitTitle => 'Do you want to exit?';

  @override
  String get cameraExitDescription =>
      'The evidence and information you added to this claim won\'t be saved. You\'ll need to start again later.';

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
}
