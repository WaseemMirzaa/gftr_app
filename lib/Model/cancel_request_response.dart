class CancelRequestResponse {
  final bool? status;
  final int? code;
  final String? message;

  CancelRequestResponse({
    this.status,
    this.code,
    this.message,
  });

  factory CancelRequestResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return CancelRequestResponse();
    }
    return CancelRequestResponse(
      status: json['status'] is bool ? json['status'] : null,
      code: json['code'] is int
          ? json['code']
          : (json['code'] is String ? int.tryParse(json['code']) : null),
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
    };
  }
}
