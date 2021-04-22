import 'package:bloc/bloc.dart';
import 'package:movie_mania/blocs/movie_details/movie_detail_listing_events.dart';
import 'package:movie_mania/blocs/movie_details/movie_detail_listing_states.dart';
import 'package:movie_mania/repository/movies_repository.dart';

class MovieDetailBloc
    extends Bloc<MovieDetailListingEvent, MovieDetailListingState> {
  final MoviesRepository _repository = MoviesRepository();
  //
  @override
  MovieDetailListingState get initialState {
    //restrict bookmark button press in UI during loading state
    return MovieDetailLoadingState(isBookmarked: false);
  }

  @override
  Stream<MovieDetailListingState> mapEventToState(
      MovieDetailListingEvent event) async* {
    if (event is StartEvent) {
      //return Fetched state with current bookmark status
      bool _isMovieBookmarked =
          await _repository.isMovieBookmarked(event.movieId);
      yield MovieDetailFetchedState(isBookmarked: _isMovieBookmarked);
    } else if (event is BookmarkEvent) {
      //restrict bookmark button press in UI during loading state
      yield MovieDetailLoadingState(isBookmarked: event.isBookmarked);
      //Bookmark the movie and return Fetched state with isbookmark true
      await _repository.bookmarkMovie(event.movieId);
      yield MovieDetailFetchedState(isBookmarked: true);
    } else if (event is UnBookmarkEvent) {
      //restrict bookmark button press in UI during loading state
      yield MovieDetailLoadingState(isBookmarked: event.isBookmarked);
      //Bookmark the movie and return Fetched state with isbookmark false
      await _repository.unbookmarkMovie(event.movieId);
      yield MovieDetailFetchedState(isBookmarked: false);
    }
  }
}
