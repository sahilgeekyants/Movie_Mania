import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/app.dart';
import 'package:movie_mania/blocs/movies/movies_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_listing_events.dart';
import 'package:movie_mania/blocs/movies/movies_listing_states.dart';
import 'package:movie_mania/models/ui_data_models/movies_model.dart';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/services/local_db_services/boxes/genre_box.dart';
import 'package:movie_mania/ui/movie_detail_screen/movie_detail.dart';
import 'package:movie_mania/utils/scale_config.dart';
import 'package:movie_mania/utils/widgets/circularIndicator.dart';
import 'package:movie_mania/utils/widgets/message.dart';

class RecentImageSlider extends StatefulWidget {
  @override
  _RecentImageSliderState createState() => _RecentImageSliderState();
}

class _RecentImageSliderState extends State<RecentImageSlider> {
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  CarouselController sliderController;
  int pageIndex;
  @override
  void initState() {
    super.initState();
    sliderController = CarouselController();
    pageIndex = 0;
    BlocProvider.of<MoviesBloc>(context).dispatch(MoviesListingEvent.display);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // sliderController.nextPage()
    return Container(
      child: BlocBuilder(
        bloc: BlocProvider.of<MoviesBloc>(context),
        builder: (context, state) {
          if (state is MoviesErrorState) {
            final MoviesErrorState fetchedState = state;
            print("Popular ErrorState msg: ${fetchedState.errMsg}");
            return Message(message: fetchedState.errMsg, height: 400);
          } else if (state is MoviesLoadingState) {
            final MoviesLoadingState fetchedState = state;
            print("Popular- Progess State msg: ${fetchedState.msg}");
            return CircularIndicator(height: 500);
          } else {
            print("Popular- Displaying State");
            //
            List<String> _genreList = GenreBox.getAllGenreList();
            print('_genreList : ${_genreList.toString()}');
            //
            final fetchedState = state as MoviesFetchedState;
            final movies = fetchedState.movies;
            return buildSlider(movies);
          }
        },
      ),
    );
  }

  Widget buildSlider(MoviesModel movies) {
    return Column(
      children: <Widget>[
        CarouselSlider(
          carouselController: sliderController,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            autoPlay: false,
            aspectRatio: 0.8,
            viewportFraction: 0.75,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            onPageChanged: (index, reason) {
              print('old index: $pageIndex');
              print('new index: $index');
              setState(() {
                pageIndex = index;
              });
            },
          ),
          items: movies.results.map((item) {
            int _imageIndex = movies.results.indexOf(item);
            bool _isCenterPage = pageIndex == _imageIndex;
            String _posterPath = Config.baseImageUrl + item.posterPath;
            String _title = item.title;
            String _genres = GenreBox.getGenreListString(item.genreIds) ?? "";
            return Container(
              child: Image.network(
                _posterPath,
                fit: BoxFit.cover,
                width: scaleConfig.scaleWidth(320),
                height: scaleConfig.scaleHeight(_isCenterPage ? 450 : 380),
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return Container(
                    // color: Colors.yellowAccent,
                    padding: EdgeInsets.only(right: scaleConfig.scaleWidth(20)),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        //image
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(28)),
                            child: GestureDetector(
                              onTap: () {
                                //allow to click only center page in recent section
                                if (_isCenterPage) {
                                  print('Image clicked index : $_imageIndex');
                                  navigatorKey.currentState.pushNamed(
                                    MovieDetail.routeName,
                                    arguments: MovieDetailArguments(
                                      moviePosterUrl: _posterPath,
                                    ),
                                  );
                                }
                              },
                              child: child,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(28)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[600].withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: Offset(0, _isCenterPage ? 10 : 0),
                              ),
                            ],
                          ),
                        ),
                        //Movie Title
                        Container(
                          padding: EdgeInsets.only(
                              top: scaleConfig.scaleHeight(15),
                              bottom: scaleConfig.scaleHeight(10)),
                          margin: EdgeInsets.only(
                              right: scaleConfig.scaleWidth(75)),
                          child: Text(
                            _title,
                            maxLines: 1,
                            style: TextStyle(
                              color: _isCenterPage
                                  ? Colors.black
                                  : Colors.grey[700],
                              fontSize: scaleConfig.scaleWidth(28),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Movie Tags
                        Container(
                          margin: EdgeInsets.only(
                              right: scaleConfig.scaleWidth(140)),
                          child: Text(
                            _genres,
                            maxLines: 2,
                            style: TextStyle(
                              color:
                                  _isCenterPage ? Colors.black45 : Colors.grey,
                              fontSize: scaleConfig.scaleWidth(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
