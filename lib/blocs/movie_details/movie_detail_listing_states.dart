import 'package:flutter/material.dart';

abstract class MovieDetailListingState {
  final bool isBookmarked;
  MovieDetailListingState(this.isBookmarked);
}

class MovieDetailLoadingState extends MovieDetailListingState {
  MovieDetailLoadingState({@required bool isBookmarked}) : super(isBookmarked);
}

class MovieDetailFetchedState extends MovieDetailListingState {
  MovieDetailFetchedState({@required bool isBookmarked}) : super(isBookmarked);
}

class MovieDetailErrorState extends MovieDetailListingState {
  final String errMsg;
  MovieDetailErrorState({@required this.errMsg, @required bool isBookmarked})
      : super(isBookmarked);
}
