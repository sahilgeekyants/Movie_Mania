import 'dart:convert';
import 'package:movie_mania/services/config/shared_preference.dart';

import '../config/config.dart';
import 'index.dart';
import 'response.dart';

class RefreshToken {
  final clientID = "airops.ctc.mobile";
  final configUrl = Config.baseUrl;
  final clientSecret = Config.clientId;

  get clientCredentials {
    return Base64Encoder().convert("$clientID:$clientSecret".codeUnits);
  }

  Future<dynamic> handleRefreshToken(
    requestType,
    url,
    headers,
    body,
  ) async {
    try {
      var refreshToken = await localStorage.getRefreshToken();
      final refreshBody =
          "refresh_token=$refreshToken&grant_type=refresh_token";
      final refreshurl = "$configUrl" + "auth/token";
      print("refreshBody is $refreshBody");
      Response response = await HttpService.httpRequests(refreshurl, "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic $clientCredentials"
          },
          body: refreshBody);
      print("the response of the refresh token is ---->> ${response.body}");
      if (response.status) {
        await localStorage.setToken(response.body['access_token']);
        Response oldApiResponse =
            await HttpService.httpRequests(url, requestType, body: body);
        return oldApiResponse;
      }
    } catch (error) {
      print("some error occurred");
    }
  }
}
