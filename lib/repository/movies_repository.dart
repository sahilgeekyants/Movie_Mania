import 'dart:async';
import 'dart:convert';
import 'package:movie_mania/models/db_data_models/movie_data_model.dart';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/services/http_service/index.dart';
import 'package:movie_mania/services/http_service/response.dart';
import 'package:movie_mania/services/local_db_services/boxes/genre_box.dart';
import 'package:movie_mania/services/local_db_services/boxes/local_details_box.dart';
import 'package:movie_mania/services/local_db_services/boxes/rated_movies_box.dart';
import 'package:movie_mania/utils/constants/api_request_types.dart';
import 'package:movie_mania/utils/constants/messages.dart';
import '../models/ui_data_models/movies_model.dart';

class MoviesRepository {
  //
  final String _apiKey = Config.apiKey;
  final String _baseUrl = Config.baseUrl;
  final String _language = Config.baseUrl;
  final String _sortBy = Config.baseUrl;
  //

  Future<Response> fetchAllMovies() async {
    String _url =
        "$_baseUrl/movie/popular?api_key=$_apiKey&language=$_language&sort_by=$_sortBy";
    print("url : $_url");
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
      print('exception inside fetchAllMovies : $_errMsg}');
      if (_errMsg.contains(ToastMessages.errorMessage[""])) {
        //
      }
      return Response(status: false, body: null, message: e.toString());
    }
  }

  // Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId);

  Future fetchAndSaveGenreList() async {
    await GenreBox.openBox();
    if (!GenreBox.hasData()) {
      String _url =
          "$_baseUrl/genre/movie/list?api_key=$_apiKey&language=$_language&sort_by=$_sortBy";
      print("url : $_url");
      Response _response;
      try {
        _response = await HttpService.httpRequests(_url, ApiRequestType.GET);
        print('genres responseStatus : ${_response.responseStatus}');
        if (_response.status) {
          // If the call to the server was successful
          Map<String, dynamic> parsedJson = _response.body;
          if (parsedJson.isNotEmpty) {
            //
            List<dynamic> _genreList = parsedJson["genres"];
            if (_genreList.isNotEmpty) {
              _genreList.forEach((element) async {
                await GenreBox.addGenre(element["id"], element["name"]);
              });
            }
          } else {
            //Empty response
            print(
                'Genre Api empty response, code:${_response.responseStatus},body:${_response.body}');
          }
        } else {
          print(
              'Genre Api failed, status:${_response.status}, code:${_response.responseStatus},body:${_response.body}');
          // If that call was not successful, then return the error response
          // return _response;
        }
      } on Exception catch (e) {
        String _errMsg = e.toString();
        print('exception inside fetchAllMovies : $_errMsg}');
        if (_errMsg.contains(ToastMessages.errorMessage[""])) {
          //
        }
        // return Response(status: false, body: null, message: e.toString());
      }
    }
  }

  Future setUpGuestSession() async {
    await LocalDetailsBox.openBox();
    String _currentId = await LocalDetailsBox.getGuestSessionId();
    if (_currentId == null) {
      String _url =
          "$_baseUrl/authentication/guest_session/new?api_key=$_apiKey";
      print("url : $_url");
      Response _response;
      try {
        _response = await HttpService.httpRequests(_url, ApiRequestType.GET);
        print('responseStatus : ${_response.responseStatus}');
        if (_response.status) {
          // If the call to the server was successful
          Map<String, dynamic> parsedJson = _response.body;
          if (parsedJson["success"] == true) {
            //
            String _id = parsedJson["guest_session_id"];
            await LocalDetailsBox.setGuestSessionId(_id);
            //Fetch the rated movies
            await fetchRatedMovies();
            //
          } else {
            //false response
            print(
                'Api false response, code:${_response.responseStatus},body:${_response.body}');
          }
        } else {
          print(
              'Api failed, status:${_response.status}, code:${_response.responseStatus},body:${_response.body}');
          // If that call was not successful, then return the error response
          // return _response;
        }
      } on Exception catch (e) {
        String _errMsg = e.toString();
        print('exception inside fetchAllMovies : $_errMsg}');
        if (_errMsg.contains(ToastMessages.errorMessage[""])) {
          //
        }
        // return Response(status: false, body: null, message: e.toString());
      }
    }
  }

  Future fetchRatedMovies() async {
    await RatedMoviesBox.openBox();
    String _sessionId = await LocalDetailsBox.getGuestSessionId();
    if (_sessionId != null) {
      String _url =
          "$_baseUrl/guest_session/$_sessionId/rated/movies?api_key=$_apiKey&language=$_language&sort_by=$_sortBy";
      print("url : $_url");
      Response _response;
      try {
        _response = await HttpService.httpRequests(_url, ApiRequestType.GET);
        print('responseStatus : ${_response.responseStatus}');
        if (_response.status) {
          // If the call to the server was successful
          Map<String, dynamic> parsedJson = _response.body;
          if (parsedJson.isNotEmpty) {
            //
            List<dynamic> _movieList = parsedJson["results"];
            if (_movieList.isNotEmpty) {
              //Delete Previous data from DB
              await RatedMoviesBox.deleteAllRatedMovies();
              List<int> _genres;
              //Fill new data coming from
              _movieList.forEach((element) async {
                _genres = [];
                element["genre_ids"].forEach((element) {
                  _genres.add(element);
                });
                print('fetched rated Movie data: ${element.toString()}');
                await RatedMoviesBox.addMovie(
                  MovieDataModel(
                    id: element["id"],
                    title: element["title"],
                    posterPath: element["poster_path"],
                    genreIds: _genres,
                    overview: element["overview"],
                    bookmarked: null,
                    lastOpened: null,
                    rating: element["rating"],
                  ),
                );
              });
            }
          } else {
            //Empty response
            print(
                'Api empty response, code:${_response.responseStatus},body:${_response.body.toString()}');
          }
        } else {
          print(
              'Api failed, status:${_response.status}, code:${_response.responseStatus},body:${_response.body}');
          // If that call was not successful, then return the error response
          // return _response;
        }
      } on Exception catch (e) {
        String _errMsg = e.toString();
        print('exception inside fetchAllMovies : $_errMsg}');
        if (_errMsg.contains(ToastMessages.errorMessage[""])) {
          //
        }
        // return Response(status: false, body: null, message: e.toString());
      }
    }
  }

  Future rateMovie(int id, double rating) async {
    if (id != null && rating >= 0 && rating <= 10) {
      String _sessionId = await LocalDetailsBox.getGuestSessionId();
      String _url =
          "$_baseUrl/movie/$id/rating?api_key=$_apiKey&guest_session_id=$_sessionId";
      print("url : $_url");
      Response _response;
      try {
        _response = await HttpService.httpRequests(
          _url,
          ApiRequestType.POST,
          headers: {"Content-Type": "application/json;charset=utf-8"},
          body: json.encode({"value": rating}),
        );
        print('responseStatus : ${_response.responseStatus}');
        if (_response.status) {
          // If the call to the server was successful
          Map<String, dynamic> parsedJson = _response.body;
          if (parsedJson["success"] == true) {
            print("rated movie successfully");
            //Fetch the rated movies
            await fetchRatedMovies();
            //
          } else {
            //false response
            print(
                'Api false response, code:${_response.responseStatus},body:${_response.body}');
          }
        } else {
          print(
              'Api failed, message:${_response.message}, code:${_response.responseStatus},body:${_response.body}');
          // If that call was not successful, then return the error response
          // return _response;
        }
      } on Exception catch (e) {
        String _errMsg = e.toString();
        print('exception inside fetchAllMovies : $_errMsg}');
        if (_errMsg.contains(ToastMessages.errorMessage[""])) {
          //
        }
        // return Response(status: false, body: null, message: e.toString());
      }
    }
  }
}
