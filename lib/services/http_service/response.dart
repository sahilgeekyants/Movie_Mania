import 'dart:convert';

class Response {
  bool status;
  int responseStatus;
  dynamic body;
  String message;
  dynamic headers;

  Response({this.status, this.message, this.headers, this.body});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    headers = json['header'];
    responseStatus = json['response_status'];
    if ((json['body'] != null) && (json['body'].toString().isNotEmpty)) {
      body = jsonDecode(json['body']);
    }
  }
}
