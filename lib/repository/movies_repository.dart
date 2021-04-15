import 'dart:async';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/services/http_service/index.dart';
import 'package:movie_mania/services/http_service/response.dart';
import 'package:movie_mania/utils/constants/api_request_types.dart';
import 'package:movie_mania/utils/constants/messages.dart';
import '../models/movies_model.dart';

class MoviesRepository {
  //
  final String _apiKey = Config.apiKey;
  final String _baseUrl = Config.baseUrl;
  //

  Future<Response> fetchAllMovies() async {
    String _url = "$_baseUrl/movie/popular?api_key=$_apiKey";
    Response _response;
    try {
      _response = await HttpService.httpRequests(_url, ApiRequestType.GET);
      print('popular movies responseStatus : ${_response.responseStatus}');
      if (_response.status) {
        // If the call to the server was successful
        Map<String, dynamic> parsedJson = _response.body;
        if (parsedJson.isNotEmpty) {
          //
          MoviesModel _moviesModel = MoviesModel.fromJson(parsedJson);
          return Response(
            status: true,
            body: _moviesModel,
            message: ToastMessages.succesMessage["success"],
          );
        } else {
          //Empty response
          return Response(
            status: false,
            body: null,
            message: ToastMessages.errorMessage["emptyData"],
          );
        }
      } else {
        // If that call was not successful, then return the error response
        return _response;
      }
    } on Exception catch (e) {
      String _errMsg = e.toString();
      if (_errMsg.contains(ToastMessages.errorMessage[""])) {
        //
      }
      return Response(status: false, body: null, message: e.toString());
    }
  }

  // Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId);
}
