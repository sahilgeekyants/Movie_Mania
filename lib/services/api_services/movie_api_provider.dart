import 'dart:async';
import 'package:movie_mania/models/movies_model.dart';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/services/http_service/index.dart';
import 'package:movie_mania/services/http_service/response.dart';
import 'package:movie_mania/utils/constants/api_request_types.dart';

class MovieApiProvider {
  final String _apiKey = Config.apiKey;
  final String _baseUrl = Config.baseUrl;

  Future<MoviesModel> fetchMovieList() async {
    String _url = "$_baseUrl/movie/popular?api_key=$_apiKey";

    Response response;
    if (_apiKey != 'api-key') {
      response = await HttpService.httpRequests(_url, ApiRequestType.GET);
      print('popular movies responseStatus : ${response.responseStatus}');
    } else {
      throw Exception('Please add your API key');
    }
    if (response.responseStatus == 200) {
      // If the call to the server was successful
      Map<String, dynamic> parsedJson = response.body;
      return MoviesModel.fromJson(parsedJson);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  // Future<TrailerModel> fetchTrailer(int movieId) async {
  //   final response =
  //       await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");

  //   if (response.statusCode == 200) {
  //     return TrailerModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load trailers');
  //   }
  // }
}
