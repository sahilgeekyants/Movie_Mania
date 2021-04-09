import 'package:shared_preferences/shared_preferences.dart';

class MyLocalStorage {
  static SharedPreferences prefs;
  Map<dynamic, dynamic> authenticationInfo = {};
  bool isAuthenticated;

  static setLocalStorage() async {
    print("initialising the shared preference");
    prefs = await SharedPreferences.getInstance();
  }

  Future setToken(token) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", token);
  }

  Future setRefreshToken(refresh_token) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("refresh_token", refresh_token);
  }

  Future getToken() async {
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("access_token");
    return token;
  }

  Future setDeviceId(String deviceId) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("device_id", deviceId);
  }

  Future getRefreshToken() async {
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("refresh_token");
    return token;
  }

  Future clearUserAndToken() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future getUserId() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt("userId");
  }

  Future getDeviceId() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("device_id");
  }
}

MyLocalStorage localStorage = MyLocalStorage();
