import 'package:flutter/material.dart';

abstract class MovieDetailListingEvent {
  final bool isBookmarked;
  final int movieId;
  MovieDetailListingEvent(this.movieId, this.isBookmarked);
}

class StartEvent extends MovieDetailListingEvent {
  StartEvent({@required int movieId, @required bool isBookmarked})
      : super(movieId, isBookmarked);
}

class BookmarkEvent extends MovieDetailListingEvent {
  BookmarkEvent({@required int movieId, @required bool isBookmarked})
      : super(movieId, isBookmarked);
}

class UnBookmarkEvent extends MovieDetailListingEvent {
  UnBookmarkEvent({@required int movieId, @required bool isBookmarked})
      : super(movieId, isBookmarked);
}
