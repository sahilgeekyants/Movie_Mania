import 'package:hive/hive.dart';

class GenreBox {
  //
  static final String boxName = "movie_genres";
  static Box<String> _genreBox;
  //
  static Future openBox() async {
    _genreBox = await Hive.openBox<String>(boxName);
  }

  static bool hasData() {
    if (_genreBox == null) {
      openBox();
    }
    return _genreBox.isNotEmpty;
  }

  static Future addGenre(int id, String name) async {
    if (_genreBox == null) {
      openBox();
    }
    await _genreBox.put(id, name);
  }

  static String getGenre(int id) {
    if (_genreBox == null) {
      openBox();
    }
    String _genre = _genreBox.get(id);
    return _genre;
  }

  static String getGenreListString(List<int> ids) {
    if (_genreBox == null) {
      openBox();
    }
    String _genreList = "";
    String _genre;
    if (ids != null) {
      ids.forEach((element) {
        // _genreList.add(_genreBox.get(element));
        _genre = _genreBox.get(element, defaultValue: "");
        if (_genre.isNotEmpty) {
          _genreList = _genre + " " + _genreList;
        }
      });
    }
    return _genreList;
  }

  static List<String> getAllGenreList() {
    if (_genreBox == null) {
      openBox();
    }
    return _genreBox.values.toList();
  }
}
