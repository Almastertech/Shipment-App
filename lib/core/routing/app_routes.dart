class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String loginMethod = '/login-method';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String otpSuccess = '/otp-success';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String merchant = '/merchant';
  static const String shipments = '/shipments';
  static const String profile = '/profile';
  static const String deleteAccount = '/profile/delete-account';
  static const String editProfile = '/profile/edit';
  static const String notificationSettings = '/profile/notifications';
  static const String activity = '/profile/activity';
  static const String supportTickets = '/profile/support-tickets';
  static const String supportTicketDetails = '/profile/support-tickets/details';
  static const String createSupportTicket = '/profile/support-tickets/new';
  static const String shipmentDetails = '/shipment-details';
  static const String requests = '/requests';
  static const String requestDetails = '/request-details';
  static const String openDemands = '/open-demands';
  static const String demandDetails = '/demand-details';
  static const String cameraPermission = '/camera-permission';
  static const String cameraCapture = '/camera-capture';
  static const String uiKitShowcase = '/ui-kit';
  static const String debugApiMonitor = '/debug/network-monitor';
  static const String sampleList = '/sample';
  static const String sampleDetails = '/sample/:id';

  /// Builds the sample details path with a concrete [id].
  static String sampleDetailsPath(String id) =>
      '/sample/${Uri.encodeComponent(id)}';
}
