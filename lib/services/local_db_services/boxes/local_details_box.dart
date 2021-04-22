import 'package:hive/hive.dart';

class LocalDetailsBox {
  //adding session_id and ...
  //
  static final String _boxName = "local_details";
  static Box<String> _box;
  static String _sessionKey = "guest_session_id";
  //
  static Future openBox() async {
    _box = await Hive.openBox<String>(_boxName);
  }

  static Future<bool> hasData() async {
    if (_box == null) {
      await openBox();
    }
    return _box.isNotEmpty;
  }

  static Future setGuestSessionId(String id) async {
    if (_box == null) {
      await openBox();
    }
    if (_box.get(_sessionKey) == null) {
      await _box.put(_sessionKey, id);
    }
  }

  static Future<String> getGuestSessionId() async {
    if (_box == null) {
      await openBox();
    }
    return _box.get(_sessionKey);
  }
}
