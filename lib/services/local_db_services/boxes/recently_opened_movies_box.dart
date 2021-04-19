import 'package:hive/hive.dart';
import 'package:movie_mania/models/db_data_models/movie_data_model.dart';

class RecentlyOpenedMoviesBox {
  //
  static final String boxName = "recently_opened_movie";
  static Box<MovieDataModel> _box;
  //
  static Future openBox() async {
    _box = await Hive.openBox<MovieDataModel>(boxName);
  }

  static bool hasData() {
    if (_box == null) {
      openBox();
    }
    return _box.isNotEmpty;
  }

  static Future addMovie(MovieDataModel model) async {
    if (_box == null) {
      await openBox();
    }
    // await _box.delete(model.id);
    // if (!_box.containsKey(model.id)) {
    await _box.put(model.id, model);
    // }
  }

  static MovieDataModel getMovie(int id) {
    if (_box == null) {
      openBox();
    }
    MovieDataModel _model = _box.get(id);
    return _model;
  }

  static Map<int, MovieDataModel> getAllMoviesSortedByTime() {
    if (_box == null) {
      openBox();
    }
    // _box.values.toList();
    Map<int, MovieDataModel> _movies = _box.toMap().map((key, value) {
      int date = value.lastOpened.microsecondsSinceEpoch;
      return MapEntry(date, value);
    });
    return _movies;
  }
}
