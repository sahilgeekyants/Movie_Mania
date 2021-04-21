import 'package:bloc/bloc.dart';
import 'package:movie_mania/blocs/movie_details/movie_detail_listing_events.dart';
import 'package:movie_mania/blocs/movie_details/movie_detail_listing_states.dart';
import 'package:movie_mania/services/local_db_services/boxes/bookmarked_movies_box.dart';

class MovieDetailBloc
    extends Bloc<MovieDetailListingEvent, MovieDetailListingState> {
  //
  @override
  MovieDetailListingState get initialState {
    //restrict bookmark button press in UI during loading state
    return MovieDetailLoadingState(isBookmarked: false);
  }

  @override
  Stream<MovieDetailListingState> mapEventToState(
      MovieDetailListingEvent event) async* {
    //restrict bookmark button press in UI during loading state
    yield MovieDetailLoadingState(isBookmarked: event.isBookmarked);
    if (event is StartEvent) {
      //return Fetched state with current bookmark status
      bool _isMovieBookmarked =
          await BookmarkedMoviesBox.isMovieBookmarked(event.movieId);
      yield MovieDetailFetchedState(isBookmarked: _isMovieBookmarked);
    } else if (event is BookmarkEvent) {
      //Bookmark the movie and return Fetched state with isbookmark true
      await BookmarkedMoviesBox.addMovie(event.movieId);
      yield MovieDetailFetchedState(isBookmarked: true);
    } else if (event is UnBookmarkEvent) {
      //Bookmark the movie and return Fetched state with isbookmark false
      await BookmarkedMoviesBox.deleteMovie(event.movieId);
      yield MovieDetailFetchedState(isBookmarked: false);
    }
  }
}
