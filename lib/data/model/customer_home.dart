/// Data returned by GET /v1/customer/home.
class CustomerHome {
  const CustomerHome({
    this.customerName,
    this.heroState,
    this.featuredShipment,
    this.activeShipments = const [],
    this.activeClaims = const [],
    this.requiredAction,
    this.partnerStoresCount = 0,
  });

  final String? customerName;
  final String? heroState;
  final CustomerHomeShipment? featuredShipment;
  final List<CustomerHomeShipment> activeShipments;
  final List<CustomerHomeClaim> activeClaims;
  final Object? requiredAction;
  final int partnerStoresCount;

  bool get hasRequiredAction => switch (requiredAction) {
        null => false,
        final Map<dynamic, dynamic> value => value.isNotEmpty,
        final String value => value.trim().isNotEmpty,
        final bool value => value,
        _ => true,
      };

  factory CustomerHome.fromJson(Map<String, dynamic> json) {
    return CustomerHome(
      customerName: _localizedText(json['customer_name']),
      heroState: _text(json['hero_state']),
      featuredShipment: json['featured_shipment'] is Map
          ? CustomerHomeShipment.fromJson(
              Map<String, dynamic>.from(json['featured_shipment'] as Map),
            )
          : null,
      activeShipments: _list(json['active_shipments'])
          .map(CustomerHomeShipment.fromJson)
          .toList(growable: false),
      activeClaims: _list(json['active_claims'])
          .map(CustomerHomeClaim.fromJson)
          .toList(growable: false),
      requiredAction: json['required_action'],
      partnerStoresCount: _integer(json['partner_stores_count']),
    );
  }
}

class CustomerHomeShipment {
  const CustomerHomeShipment({
    required this.packageId,
    this.orderNumber,
    this.storeName,
    this.productName,
    this.trackingNumber,
    this.carrierCode,
    this.status,
    this.createdAt,
    this.expectedDeliveryAt,
  });

  final String packageId;
  final String? orderNumber;
  final String? storeName;
  final String? productName;
  final String? trackingNumber;
  final String? carrierCode;
  final String? status;
  final DateTime? createdAt;
  final DateTime? expectedDeliveryAt;

  factory CustomerHomeShipment.fromJson(Map<String, dynamic> json) {
    return CustomerHomeShipment(
      packageId: _text(json['package_id']) ?? '',
      orderNumber: _text(json['order_number']),
      storeName: _localizedText(json['store_name']),
      productName: _localizedText(json['product_name']),
      trackingNumber: _text(json['tracking_number']),
      carrierCode: _text(json['carrier_code']),
      status: _text(json['status']),
      createdAt: _date(json['created_at']),
      expectedDeliveryAt: _date(json['expected_delivery_at']),
    );
  }
}

class CustomerHomeClaim {
  const CustomerHomeClaim({
    required this.id,
    this.ticketNumber,
    this.type,
    this.status,
    this.claimedAmountHalalas,
    this.orderNumber,
    this.storeName,
    this.updatedAt,
  });

  final String id;
  final String? ticketNumber;
  final String? type;
  final String? status;
  final String? claimedAmountHalalas;
  final String? orderNumber;
  final String? storeName;
  final DateTime? updatedAt;

  factory CustomerHomeClaim.fromJson(Map<String, dynamic> json) {
    return CustomerHomeClaim(
      id: _text(json['id']) ?? '',
      ticketNumber: _text(json['ticket_number']),
      type: _text(json['type']),
      status: _text(json['status']),
      claimedAmountHalalas: _text(json['claimed_amount_halalas']),
      orderNumber: _text(json['order_number']),
      storeName: _localizedText(json['store_name']),
      updatedAt: _date(json['updated_at']),
    );
  }
}

List<Map<String, dynamic>> _list(dynamic value) {
  if (value is! List) return const [];
  return value
      .whereType<Map<dynamic, dynamic>>()
      .map((item) => Map<String, dynamic>.from(item))
      .toList(growable: false);
}

String? _localizedText(dynamic value) {
  final direct = _text(value);
  if (direct != null) return direct;
  if (value is! Map) return null;
  for (final key in const ['value', 'name', 'en', 'ar']) {
    final candidate = _text(value[key]);
    if (candidate != null) return candidate;
  }
  for (final localized in value.values) {
    final candidate = _localizedText(localized);
    if (candidate != null) return candidate;
  }
  return null;
}

String? _text(dynamic value) {
  if (value is String && value.trim().isNotEmpty) return value.trim();
  if (value is num || value is bool) return value.toString();
  return null;
}

DateTime? _date(dynamic value) => DateTime.tryParse(_text(value) ?? '');

int _integer(dynamic value) {
  if (value is int) return value < 0 ? 0 : value;
  if (value is num) return value < 0 ? 0 : value.toInt();
  return int.tryParse(_text(value) ?? '') ?? 0;
}
