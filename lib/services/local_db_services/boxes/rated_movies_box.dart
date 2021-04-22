import 'package:hive/hive.dart';
import 'package:movie_mania/models/db_data_models/movie_data_model.dart';

class RatedMoviesBox {
  //saving rated_movies in the form of Map<MovieDataModel>
  static final String _boxName = "rated_movies";
  static Box<MovieDataModel> _box;
  //
  static Future openBox() async {
    _box = await Hive.openBox<MovieDataModel>(_boxName);
  }

  static Future<bool> hasData() async {
    if (_box == null) {
      await openBox();
    }
    return _box.isNotEmpty;
  }

  static Future<bool> isMovieRated(int id) async {
    if (_box == null) {
      await openBox();
    }
    return _box.containsKey(id);
  }

  static Future addMovie(MovieDataModel model) async {
    if (_box == null) {
      await openBox();
    }
    await _box.put(model.id, model);
  }

  static Future<double> getMovieRating(int id) async {
    if (_box == null) {
      await openBox();
    }
    MovieDataModel _model = _box.get(id);
    return (_model != null) ? _model.rating : -1;
  }

  static Future<List<MovieDataModel>> getAllRatedMovies() async {
    if (_box == null) {
      await openBox();
    }
    return _box.values.toList();
  }

  static Future deleteAllRatedMovies() async {
    if (_box == null) {
      await openBox();
    }
    int _deletedCount = await _box.clear();
    print('All entries deleted from Rated Movies box, count : $_deletedCount');
  }
}
