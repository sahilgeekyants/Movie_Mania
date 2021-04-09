import 'dart:async';
import 'package:movie_mania/services/api_services/movie_api_provider.dart';
import '../models/movies_model.dart';

class MoviesRepository {
  final moviesApiProvider = MovieApiProvider();

  Future<MoviesModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  // Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId);
}
