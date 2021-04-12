import 'package:bloc/bloc.dart';
import 'package:movie_mania/blocs/movies/movies_listing_events.dart';
import 'package:movie_mania/blocs/movies/movies_listing_states.dart';
import 'package:movie_mania/models/movies_model.dart';
import 'package:movie_mania/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc extends Bloc<MoviesListingEvent, MoviesListingState> {
  final MoviesRepository _repository = MoviesRepository();
  @override
  Stream<MoviesListingState> transformEvents(Stream<MoviesListingEvent> events,
      Stream<MoviesListingState> Function(MoviesListingEvent event) next) {
    // TODO: implement transformEvents
    return super.transformEvents(
      (events as Observable<MoviesListingEvent>)
          .debounce((_) => TimerStream(true, const Duration(seconds: 3))),
      next,
    );
  }

  @override
  void onTransition(
      Transition<MoviesListingEvent, MoviesListingState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  MoviesListingState get initialState => MoviesUninitializedState();

  @override
  Stream<MoviesListingState> mapEventToState(MoviesListingEvent event) async* {
    yield MoviesFetchingState();
    MoviesModel _movies;
    if (event == MoviesListingEvent.display) {
      _movies = await _repository.fetchAllMovies();
    }
    if (_movies != null) {
      if (_movies.results.length == 0) {
        yield MoviesEmptyState();
      } else {
        yield MoviesFetchedState(movies: _movies);
      }
    } else {
      yield MoviesErrorState();
    }
  }
}
