import 'package:movie_mania/services/config/shared_preference.dart';
import 'http_service.dart';
import 'response.dart';

class HttpService {
  ///[requestType] can be GET, POST, PUT, PATCH, DELETE
  static Future<Response> httpRequests(
    String url,
    String requestType, {
    Map<String, String> headers,
    dynamic body,
  }) async {
    Map<String, String> myHeaders = {};
    if ((requestType == "GET" || requestType == "DELETE") && (body != null))
      throw _errorResponse(
          "You can not pass body or encoding to GET or DELETE request");
    if (headers == null) {
      var token = await localStorage.getToken();
      myHeaders = {
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      };
    } else {
      myHeaders = headers;
    }
    return HttpServiceHelper.httpRequestsHandler(
      url,
      requestType,
      headers: myHeaders,
      body: body,
    );
  }

  static Response _errorResponse(String message) {
    return Response.fromJson({
      'status': false,
      'body': null,
      'message': message,
      'headers': {},
      'response_status': 0,
    });
  }
}
