import "dart:convert";
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/utils/constants/api_request_types.dart';
import 'package:movie_mania/utils/constants/messages.dart';
import 'response.dart';

class HttpServiceHelper {
  static Future<Response> httpRequestsHandler(
    String url,
    ApiRequestType requestType, {
    Map<String, String> headers,
    dynamic body,
    Encoding encoding,
  }) async {
    http.Response response;
    try {
      // print("Inside switch ------->> $requestType , $url , $body");
      switch (requestType) {
        case ApiRequestType.GET:
          response = await http.get(url, headers: headers);
          break;
        case ApiRequestType.POST:
          response = await http.post(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case ApiRequestType.PUT:
          response = await http.put(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case ApiRequestType.PATCH:
          response = await http.patch(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case ApiRequestType.DELETE:
          response = await http.delete(url, headers: headers);
          break;
        default:
          throw "No method type match";
      }
    } catch (exception) {
      print("error ocuured --->> $exception");
      if (exception.runtimeType == SocketException) {
        return _HttpServiceHelper._errorResponse(
          ToastMessages.errorMessage["NoInternet"],
          response,
          url,
          headers,
          body.toString(),
        );
      } else {
        return _HttpServiceHelper._errorResponse(
          ToastMessages.errorMessage["httpError"],
          response,
          url,
          headers,
          body.toString(),
        );
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
    // String loginUrl = "${Config.baseUrl}" + "auth/token";
    if (_statusCode == 400) {
      // await localStorage.clearUserAndToken();
      // DatabaseTables.tableNames.forEach((tableName) async {
      //   await SqliteTransactionsService().clearContent(tableName);
      // });
      // print("deleting ALL the DATABASES !!!!");
      // return navigatorKey.currentState.pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => Register()),
      //     (route) => false);
      return _errorResponse(
          response.reasonPhrase, response, url, headers, body);
    } else if (_statusCode == 401) {
      //handle refresh token here
      // Response refreshResponse = await RefreshToken()
      //     .handleRefreshToken(requestType, url, headers, body);
      // if (refreshResponse != null) {
      //   return refreshResponse;
      // }
      print('original error reasonPhrase: ${response.reasonPhrase}');
      return _errorResponse("response is null", response, url, headers, body);
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
      return Response.fromJson({
        'status': true,
        'body': response.body,
        'message': 'API call successfully done',
        'header': response.headers,
        'response_status': response.statusCode
      });
    } catch (exception) {
      return _errorResponse("Unable to decode body", response, "", {}, "");
    }
  }

  static Response _errorResponse(String message, http.Response response,
      String url, dynamic headers, dynamic body) {
    return Response.fromJson({
      'status': false,
      'body': null,
      'message': message,
      'header': response != null ? response.headers : {},
      'response_status': response != null ? response.statusCode : -1,
    });
  }
}
