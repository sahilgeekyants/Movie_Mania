// import 'package:shared_preferences/shared_preferences.dart';

// class MyLocalStorage {
//   SharedPreferences _prefs;

//   Future setLocalStorage() async {
//     if (_prefs == null) {
//       print("initialising the shared preference");
//       _prefs = await SharedPreferences.getInstance();
//     }
//   }

//   Future setSessionId(token) async {
//     _prefs.setString("session_id", token);
//   }

//   Future getSessionId() async {
//     var _id = _prefs.getString("session_id");
//     return _id;
//   }

//   // Future setDeviceId(String deviceId) async {
//   //   _prefs = await SharedPreferences.getInstance();
//   //   _prefs.setString("device_id", deviceId);
//   // }

//   // Future clearUserAndToken() async {
//   //   _prefs = await SharedPreferences.getInstance();
//   //   await _prefs.clear();
//   // }

//   // Future getUserId() async {
//   //   _prefs = await SharedPreferences.getInstance();
//   //   return _prefs.getInt("userId");
//   // }

//   // Future getDeviceId() async {
//   //   _prefs = await SharedPreferences.getInstance();
//   //   return _prefs.getString("device_id");
//   // }
// }

// MyLocalStorage localStorage = MyLocalStorage();
