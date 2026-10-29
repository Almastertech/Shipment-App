class OtpRequest {
  const OtpRequest({
    required this.channel,
    this.phone,
    this.email,
    this.purpose = 'SIGNUP',
  });

  final String purpose;
  final String? phone;
  final String? email;
  final String channel;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'purpose': purpose,
        if (phone != null) 'phone': phone,
        if (email != null) 'email': email,
        'channel': channel,
      };
}

class OtpRequestResponse {
  const OtpRequestResponse({
    required this.channel,
    required this.destination,
    required this.expiresAt,
    required this.retryAfterSeconds,
  });

  final String channel;
  final String destination;
  final int expiresAt;
  final int retryAfterSeconds;

  factory OtpRequestResponse.fromJson(Map<String, dynamic> json) {
    return OtpRequestResponse(
      channel: json['channel'] as String? ?? '',
      destination: json['destination'] as String? ?? '',
      expiresAt: _readInt(json['expires_at']),
      retryAfterSeconds: _readInt(json['retry_after_seconds']),
    );
  }

  static int _readInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class OtpVerifyRequest {
  const OtpVerifyRequest({
    required this.channel,
    required this.code,
    this.phone,
    this.email,
  });

  final String? phone;
  final String? email;
  final String channel;
  final String code;

  Map<String, dynamic> toJson() => <String, dynamic>{
        if (phone != null) 'phone': phone,
        if (email != null) 'email': email,
        'channel': channel,
        'code': code,
      };
}

class OtpVerifyResponse {
  const OtpVerifyResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.expiresAt,
    required this.refreshExpiresIn,
    required this.refreshExpiresAt,
    required this.account,
  });

  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final int expiresAt;
  final int refreshExpiresIn;
  final int refreshExpiresAt;
  final AuthAccount account;

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) {
    final rawAccount = json['account'];
    return OtpVerifyResponse(
      accessToken: json['access_token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      tokenType: json['token_type'] as String? ?? 'Bearer',
      expiresIn: _readInt(json['expires_in']),
      expiresAt: _readInt(json['expires_at']),
      refreshExpiresIn: _readInt(json['refresh_expires_in']),
      refreshExpiresAt: _readInt(json['refresh_expires_at']),
      account: rawAccount is Map
          ? AuthAccount.fromJson(Map<String, dynamic>.from(rawAccount))
          : const AuthAccount.empty(),
    );
  }

  static int _readInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class AuthAccount {
  const AuthAccount({
    required this.id,
    required this.phone,
    required this.email,
    required this.status,
    this.phoneVerifiedAt,
    this.emailVerifiedAt,
  });

  const AuthAccount.empty()
      : id = '',
        phone = null,
        email = null,
        status = '',
        phoneVerifiedAt = null,
        emailVerifiedAt = null;

  final String id;
  final String? phone;
  final String? email;
  final String status;
  final String? phoneVerifiedAt;
  final String? emailVerifiedAt;

  factory AuthAccount.fromJson(Map<String, dynamic> json) {
    return AuthAccount(
      id: json['id'] as String? ?? '',
      phone: _readString(json['phone']),
      email: _readString(json['email']),
      status: json['status'] as String? ?? '',
      phoneVerifiedAt: _readString(json['phone_verified_at']),
      emailVerifiedAt: _readString(json['email_verified_at']),
    );
  }

  static String? _readString(dynamic value) {
    return value is String && value.isNotEmpty ? value : null;
  }
}
