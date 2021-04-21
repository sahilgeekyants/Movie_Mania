// import 'dart:io';
// import 'package:movie_mania/utils/constants/db_table_names.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class SqlServiceProvider {
//   static String _dbName = "MovieMania.db";
//   static Database _db;
//   //
//   static List<String> _initialScript = [
//     "CREATE TABLE ${DbTables.movieGenres} (id INTEGER NOT NULL , name text NOT NULL, PRIMARY KEY (id))",
//     "CREATE TABLE ${DbTables.recentOpenMovie} (id INTEGER NOT NULL , title text NOT NULL, poster_path text NOT NULL, genre_ids text NOT NULL, bookmarked INTEGER NOT NULL, PRIMARY KEY (id))", //table for recently searched movies (genre-ids separated by ,)
//   ];
//   //
//   static List<String> _migrationScript = [];
//   //
//   static getDbInstance() async {
//     int version = _migrationScript.length + 1;
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _dbName);
//     if (_db == null) {
//       _db = await openDatabase(
//         path,
//         version: version,
//         onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//           _initialScript.forEach((query) async {
//             await db.execute(query);
//           });
//           print('LOCAL DATABASES CREATED SUCCESSFULLY !!!');
//         },
//         // onUpgrade: (db, oldVersion, newVersion) async {
//         //   print("oldVersion is $oldVersion ,newVersion is $newVersion ");
//         //   for (var i = oldVersion - 1; i < newVersion - 1; i++) {
//         //     print('Executing migration query : ${_migrationScript[i]}');
//         //     await db.execute(_migrationScript[i]);
//         //   }
//         // },
//       );
//     }
//     return _db;
//   }

//   closeDb() async {
//     _db.close();
//   }

//   clearContent(tableName) async {
//     await _db.execute("DELETE FROM " + "$tableName");
//   }
// }
