class CustomerAccount {
  const CustomerAccount({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.avatarUrl,
    required this.shipmentsCount,
    required this.claimsCount,
    required this.totalCompensationHalalas,
    required this.preferredLanguage,
    required this.memberSince,
  });

  final String id;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? avatarUrl;
  final int shipmentsCount;
  final int claimsCount;
  final String totalCompensationHalalas;
  final String? preferredLanguage;
  final DateTime? memberSince;

  CustomerAccount withPhone(String value) => CustomerAccount(
        id: id,
        fullName: fullName,
        phone: value,
        email: email,
        avatarUrl: avatarUrl,
        shipmentsCount: shipmentsCount,
        claimsCount: claimsCount,
        totalCompensationHalalas: totalCompensationHalalas,
        preferredLanguage: preferredLanguage,
        memberSince: memberSince,
      );

  factory CustomerAccount.fromJson(Map<String, dynamic> json) {
    final rawStats = json['stats'];
    final stats = rawStats is Map ? rawStats : const <String, dynamic>{};
    final id = json['id'];
    if (id is! String || id.isEmpty) {
      throw const FormatException('Customer account ID is missing.');
    }
    return CustomerAccount(
      id: id,
      fullName: _string(json['full_name']),
      phone: _string(json['phone']),
      email: _string(json['email']),
      avatarUrl: _string(json['avatar_url']),
      shipmentsCount: (stats['shipments_count'] as num?)?.toInt() ?? 0,
      claimsCount: (stats['claims_count'] as num?)?.toInt() ?? 0,
      totalCompensationHalalas:
          _string(stats['total_compensation_halalas']) ?? '0',
      preferredLanguage: _string(json['preferred_language']),
      memberSince: DateTime.tryParse(_string(json['member_since']) ?? ''),
    );
  }

  static String? _string(dynamic value) =>
      value is String && value.trim().isNotEmpty ? value.trim() : null;

  String get compensationRiyals {
    final halalas = BigInt.tryParse(totalCompensationHalalas);
    if (halalas == null) return '—';
    final amount = halalas.abs();
    final whole = amount ~/ BigInt.from(100);
    final fraction = (amount % BigInt.from(100)).toString().padLeft(2, '0');
    return '${halalas.isNegative ? '-' : ''}$whole.$fraction';
  }
}
