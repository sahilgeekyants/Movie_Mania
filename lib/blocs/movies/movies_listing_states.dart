import 'package:flutter/material.dart';
import 'package:movie_mania/models/ui_data_models/movies_model.dart';

abstract class MoviesListingState {}

// class MoviesUninitializedState extends MoviesListingState {}

class MoviesLoadingState extends MoviesListingState {
  final String msg;
  MoviesLoadingState({@required this.msg});
}

class MoviesFetchedState extends MoviesListingState {
  final MoviesModel movies;
  MoviesFetchedState({@required this.movies});
}

class MoviesErrorState extends MoviesListingState {
  final String errMsg;
  MoviesErrorState({@required this.errMsg});
}

// class MoviesEmptyState extends MoviesListingState {}
