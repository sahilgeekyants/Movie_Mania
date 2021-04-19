import 'package:hive/hive.dart';
import 'package:movie_mania/models/db_data_models/movie_data_model.dart';

class RecentlyOpenedMoviesBox {
  //
  static final String boxName = "recently_opened_movie";
  static Box<MovieDataModel> _recentOpenedMovieBox;
  //
  static Future openBox() async {
    _recentOpenedMovieBox = await Hive.openBox<MovieDataModel>(boxName);
  }

  static bool hasData() {
    if (_recentOpenedMovieBox == null) {
      openBox();
    }
    return _recentOpenedMovieBox.isNotEmpty;
  }

  static Future addMovie(MovieDataModel model) async {
    if (_recentOpenedMovieBox == null) {
      await openBox();
    }
    // await _recentOpenedMovieBox.delete(model.id);
    // if (!_recentOpenedMovieBox.containsKey(model.id)) {
    await _recentOpenedMovieBox.put(model.id, model);
    // }
  }

  static MovieDataModel getMovie(int id) {
    if (_recentOpenedMovieBox == null) {
      openBox();
    }
    MovieDataModel _model = _recentOpenedMovieBox.get(id);
    return _model;
  }

  static Map<int, MovieDataModel> getAllMoviesSortedByTime() {
    if (_recentOpenedMovieBox == null) {
      openBox();
    }
    // _recentOpenedMovieBox.values.toList();
    Map<int, MovieDataModel> _movies =
        _recentOpenedMovieBox.toMap().map((key, value) {
      int date = value.lastOpened.microsecondsSinceEpoch;
      return MapEntry(date, value);
    });
    return _movies;
  }
}
