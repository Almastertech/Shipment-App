class CustomerActivity {
  const CustomerActivity(
      {required this.id,
      required this.type,
      required this.event,
      required this.occurredAt,
      this.orderNumber,
      this.storeName,
      this.productName,
      this.claimStatus,
      this.trackingNumber});
  final String id;
  final String type;
  final String event;
  final DateTime occurredAt;
  final String? orderNumber;
  final String? storeName;
  final String? productName;
  final String? claimStatus;
  final String? trackingNumber;

  factory CustomerActivity.fromJson(Map<String, dynamic> json) {
    final claim = json['claim'];
    final shipment = json['shipment'];
    final id = json['id'];
    final occurredAt = DateTime.tryParse(_string(json['occurred_at']) ?? '');
    if (id is! String || id.isEmpty || occurredAt == null) {
      throw const FormatException('Invalid activity item.');
    }
    return CustomerActivity(
      id: id,
      type: _string(json['type']) ?? '',
      event: _string(json['event']) ?? '',
      occurredAt: occurredAt,
      orderNumber: _string(json['order_number']),
      storeName: _string(json['store_name']),
      productName: _string(json['product_name']),
      claimStatus: claim is Map ? _string(claim['status']) : null,
      trackingNumber:
          shipment is Map ? _string(shipment['tracking_number']) : null,
    );
  }

  static String? _string(dynamic value) =>
      value is String && value.trim().isNotEmpty ? value.trim() : null;
}

class CustomerActivityPage {
  const CustomerActivityPage(
      {required this.items, required this.hasMore, required this.nextCursor});
  final List<CustomerActivity> items;
  final bool hasMore;
  final String? nextCursor;
}
