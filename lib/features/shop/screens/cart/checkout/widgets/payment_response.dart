class PaymentResponse {
  final String redirectUrl;
  final String orderTrackingId;

  PaymentResponse({
    required this.redirectUrl,
    required this.orderTrackingId,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      redirectUrl: json['redirectUrl'] as String,
      orderTrackingId: json['orderTrackingId'] as String,
    );
  }
  
}

class PaymentStatus{
  final String status;

  PaymentStatus({
    required this.status,
  });

  factory PaymentStatus.fromJson(Map<String, dynamic> json) {
    return PaymentStatus(
      status: json['payment_status_description'] ?? "Pending",
    );
  }
}