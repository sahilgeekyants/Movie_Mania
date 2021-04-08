import "dart:convert";
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/services/config/shared_preference.dart';
import 'refresh_token.dart';
import 'response.dart';

class HttpServiceHelper {
  static Future<Response> httpRequestsHandler(
    String url,
    String requestType, {
    Map<String, String> headers,
    dynamic body,
    Encoding encoding,
  }) async {
    http.Response response;
    try {
      // print("Inside switch ------->> $requestType , $url , $body");
      switch (requestType) {
        case "GET":
          response = await http.get(url, headers: headers);
          break;
        case "POST":
          response = await http.post(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case "PUT":
          response = await http.put(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case "PATCH":
          response = await http.patch(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case "DELETE":
          response = await http.delete(url, headers: headers);
          break;
        case 'MULTIPART':
          var uri = Uri.parse(url);
          var request = new http.MultipartRequest("POST", uri);
          request.files.clear();

          if (body["data"] != null) {
            request.fields["data"] = body["data"];
          }

          request.files.addAll(body['files']);
          // print("request is in MULTIPART ${request.files.length}");
          var token = await localStorage.getToken();
          request.headers['Authorization'] = "Bearer $token";
          var res = await request.send();
          response = await http.Response.fromStream(res);
          print("response under http is ${response.body}");
          break;
        default:
          throw "No method type match";
      }
    } catch (exception) {
      print("error ocuured --->> $exception");
      if (exception.runtimeType == SocketException) {
        return _HttpServiceHelper._errorResponse(
            "NoInternet Error", response, url, headers, body.toString());
      } else {
        return _HttpServiceHelper._errorResponse(
            "httpError Error", response, url, headers, body.toString());
      }
    }
    return _HttpServiceHelper._handleResponse(
        response, requestType, url, headers, body, encoding);
  }
}

class _HttpServiceHelper {
  static Future<Response> _handleResponse(
      response, requestType, url, headers, body, encoding) {
    if (response != null) {
      return _identifyResponse(
          response, requestType, url, headers, body, encoding);
    }
    throw _errorResponse("response is null", response, url, headers, body);
  }

  static Future<Response> _identifyResponse(
      http.Response response, requestType, url, headers, body, encoding) async {
    final int _statusCode = response.statusCode;
    String loginUrl = "${Config.baseUrl}" + "auth/token";
    if (_statusCode == 400 &&
        url == loginUrl &&
        body.contains("refresh_token")) {
      await localStorage.clearUserAndToken();
      // DatabaseTables.tableNames.forEach((tableName) async {
      //   await SqliteTransactionsService().clearContent(tableName);
      // });
      // print("deleting ALL the DATABASES !!!!");
      // return navigatorKey.currentState.pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => Register()),
      //     (route) => false);
    } else if (_statusCode == 401 && url != loginUrl) {
      Response refreshResponse = await RefreshToken()
          .handleRefreshToken(requestType, url, headers, body);
      if (refreshResponse != null) {
        return refreshResponse;
      }
      throw _errorResponse("response is null", response, url, headers, body);
    } else if (_statusCode >= 400 && _statusCode != 401) {
      return _errorResponse("${response.body}", response, url, headers, body);
    } else if (_statusCode >= 200 && _statusCode < 300) {
      return _successResponse(response);
    } else
      return _errorResponse("${response.body}", response, url, headers, body);
  }

  static Response _successResponse(
    http.Response response,
  ) {
    try {
      if (response.headers.containsValue("application/pdf") ||
          response.headers.containsValue("application/octet-stream")) {
        Response pdfResponse = Response();
        pdfResponse.status = true;
        pdfResponse.body = response.bodyBytes;
        pdfResponse.message = 'API call successfully done';
        pdfResponse.headers = response.headers;
        pdfResponse.responseStatus = response.statusCode;
        return pdfResponse;
      } else {
        return Response.fromJson({
          'status': true,
          'body': response.body,
          'message': 'API call successfully done',
          'header': response.headers,
          'response_status': response.statusCode
        });
      }
    } catch (exception) {
      return _errorResponse("Unable to decode body", response, "", {}, "");
    }
  }

  static Response _errorResponse(String message, http.Response response,
      String url, dynamic headers, dynamic body) {
    dynamic crashErrorBody = {
      "url": url,
      "message": message,
      "body": body,
      "response": response
    };
    // FirebaseCrashlytics.instance.log(crashErrorBody.toString());
    return Response.fromJson({
      'status': false,
      'body': null,
      'message': message,
      'header': response != null ? response.headers : {},
      'response_status': response != null ? response.statusCode : -1,
    });
  }
}
