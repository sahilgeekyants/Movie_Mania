import 'package:flutter/material.dart';
import 'package:movie_mania/models/movies_model.dart';

abstract class MoviesListingState {}

class MoviesUninitializedState extends MoviesListingState {}

class MoviesFetchingState extends MoviesListingState {}

class MoviesFetchedState extends MoviesListingState {
  final MoviesModel movies;
  MoviesFetchedState({@required this.movies});
}

class MoviesErrorState extends MoviesListingState {}

class MoviesEmptyState extends MoviesListingState {}
