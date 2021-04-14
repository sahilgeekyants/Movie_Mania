import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class LocalDBServiceProvider {
  //
  static final String _dbName = "MovieMania.db";
  static String _path;
  //

  static Future initializeLocalDb() async {
    if (_path == null) {
      print("initialising hive DB");
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      _path = join(documentsDirectory.path, _dbName);
      Hive.init(_path);
    }
  }

  static Future closeAllBoxes() async => await Hive.close();
  static Future deleteAllBoxes() async => await Hive.deleteFromDisk();
  static Future deleteBox(String name) async =>
      await Hive.deleteBoxFromDisk(name);
  static bool isBoxOpen(String name) => Hive.isBoxOpen(name);
  static void registerAdapter<T>(TypeAdapter<T> adapter) =>
      Hive.registerAdapter<T>(adapter);
}

// LocalDBServiceProvider localStorage = LocalDBServiceProvider();
