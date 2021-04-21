import 'package:hive/hive.dart';
import 'package:movie_mania/models/db_data_models/movie_data_model.dart';

class BookmarkedMoviesBox {
  //saving bookmarked_movies in the form of Map<MovieDataModel>
  static final String _boxName = "bookmarked_movies";
  static Box<int> _box;
  //
  static Future openBox() async {
    _box = await Hive.openBox<int>(_boxName);
  }

  static Future<bool> hasData() async {
    if (_box == null) {
      await openBox();
    }
    return _box.isNotEmpty;
  }

  static Future<bool> isMovieBookmarked(int id) async {
    if (_box == null) {
      await openBox();
    }
    return _box.containsKey(id);
  }

  static Future addMovie(int id) async {
    if (_box == null) {
      await openBox();
    }
    await _box.put(id, id);
    print('Added the bookmarked movie with id : $id');
  }

  static Future deleteMovie(int id) async {
    if (_box == null) {
      await openBox();
    }
    await _box.delete(id);
    print('Deleted the bookmarked movie with id : $id');
  }

  static Future<List<int>> getAllBookmarkedMovies() async {
    if (_box == null) {
      await openBox();
    }
    return _box.values.toList();
  }

  static Future deleteAllBookmarkedMovies() async {
    if (_box == null) {
      await openBox();
    }
    int _deletedCount = await _box.clear();
    print(
        'All entries deleted from Bookmarked Movies box, count : $_deletedCount');
  }
}
