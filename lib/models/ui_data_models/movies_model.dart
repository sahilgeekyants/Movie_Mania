import 'movie_result_model.dart';

class MoviesModel {
  int _page;
  int _totalResults;
  int _totalPages;
  List<MovieResultModel> _results = [];

  MoviesModel.fromJson(Map<String, dynamic> parsedJson) {
    print("total results : ${parsedJson['results'].length}");
    _page = parsedJson['page'];
    _totalResults = parsedJson['total_results'];
    _totalPages = parsedJson['total_pages'];
    List<MovieResultModel> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      MovieResultModel result = MovieResultModel(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<MovieResultModel> get results => _results;

  int get totalPages => _totalPages;

  int get totalResults => _totalResults;

  int get page => _page;
}
