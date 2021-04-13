import 'dart:async';
// import 'package:movie_mania/services/api_services/movie_api_provider.dart';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/services/http_service/index.dart';
import 'package:movie_mania/services/http_service/response.dart';
import 'package:movie_mania/utils/constants/api_request_types.dart';
import '../models/movies_model.dart';

class MoviesRepository {
  //
  final String _apiKey = Config.apiKey;
  final String _baseUrl = Config.baseUrl;
  //
  // final moviesApiProvider = MovieApiProvider();

  // Future<MoviesModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();
  Future<MoviesModel> fetchAllMovies() async {
    String _url = "$_baseUrl/movie/popular?api_key=$_apiKey";

    Response response;
    if (_apiKey != 'api-key') {
      response = await HttpService.httpRequests(_url, ApiRequestType.GET);
      print('popular movies responseStatus : ${response.responseStatus}');
    } else {
      throw Exception('Please add your API key');
    }
    if (response.status) {
      // If the call to the server was successful
      Map<String, dynamic> parsedJson = response.body;
      return MoviesModel.fromJson(parsedJson);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  // Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId);
}
