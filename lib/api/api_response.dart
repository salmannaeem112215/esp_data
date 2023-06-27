import 'package:esp_remote/headers.dart';

class ApiResponse {
  final bool success;
  final Payload payload;

  String get message => payload.message;
  dynamic get data => payload.data;

  static const String success_ = 'success';
  static const String payload_ = 'payload';

  ApiResponse({
    required this.success,
    Payload? payload,
  }) : payload = payload ?? Payload();

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final payload = json[payload_];
    return ApiResponse(
      success: json[success_] ?? false,
      payload: payload != null ? Payload.fromJson(payload) : null,
    );
  }

  factory ApiResponse.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return ApiResponse(
      success: json[success_] ?? false,
      payload: json[payload_] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      success_: success,
      payload_: payload,
    };
  }
}

class Payload {
  final String message;
  final dynamic data;

  static const String message_ = 'message';
  static const String data_ = 'data';

  Payload({
    this.message = '',
    dynamic data,
  }) : data = data ?? {};

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      message: json[message_] ?? false,
      data: json[data_] ?? '',
    );
  }

  factory Payload.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Payload(
      message: json[message_] ?? false,
      data: json[data_] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      message_: message,
      data_: data,
    };
  }
}
