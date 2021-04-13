import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_listing_states.dart';
import 'package:movie_mania/models/movies_model.dart';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/ui/movie_detail_screen/movie_detail.dart';
import 'package:movie_mania/utils/scale_config.dart';
import 'package:movie_mania/utils/widgets/circularIndicator.dart';
import 'package:movie_mania/utils/widgets/message.dart';
import '../../app.dart';

class PopularImageSlider extends StatefulWidget {
  @override
  _PopularImageSliderState createState() => _PopularImageSliderState();
}

class _PopularImageSliderState extends State<PopularImageSlider> {
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  CarouselController sliderController;
  int pageIndex;
  @override
  void initState() {
    super.initState();
    sliderController = CarouselController();
    pageIndex = 0;
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
            print("Slider ErrorState msg: ${fetchedState.errMsg}");
            return Message(message: fetchedState.errMsg);
          } else if (state is MoviesLoadingState) {
            final MoviesLoadingState fetchedState = state;
            print("Slider- Progess State msg: ${fetchedState.msg}");
            return CircularIndicator(height: 500);
          } else {
            // print("Slider- Displaying State");
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
            height: scaleConfig.scaleHeight(250),
            enableInfiniteScroll: true,
            autoPlay: true,
            aspectRatio: 2,
            viewportFraction: 0.45,
            enlargeCenterPage: false,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            onPageChanged: (index, reson) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
          items: movies.results.map((item) {
            int _imageIndex = movies.results.indexOf(item);
            String _posterPath = Config.baseImageUrl + item.posterPath;
            String _title = item.title;
            return Container(
              child: Image.network(
                _posterPath,
                fit: BoxFit.cover,
                width: scaleConfig.scaleWidth(120),
                height: scaleConfig.scaleHeight(160),
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return Container(
                    padding: EdgeInsets.only(right: scaleConfig.scaleWidth(30)),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        //image
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            child: GestureDetector(
                              onTap: () {
                                print('Image clicked index : $_imageIndex');
                                navigatorKey.currentState.pushNamed(
                                  MovieDetail.routeName,
                                  arguments: MovieDetailArguments(
                                    moviePosterUrl: _posterPath,
                                  ),
                                );
                              },
                              child: child,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[600].withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                        //Movie Title
                        Container(
                          padding: EdgeInsets.only(
                              top: scaleConfig.scaleHeight(10),
                              bottom: scaleConfig.scaleHeight(5)),
                          margin: EdgeInsets.only(
                              right: scaleConfig.scaleWidth(20)),
                          child: Text(
                            _title,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: scaleConfig.scaleWidth(22),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Movie Tags
                        Container(
                          margin: EdgeInsets.only(
                              right: scaleConfig.scaleWidth(50)),
                          child: Text(
                            'Crime Drama Thril Sci-Fi',
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: scaleConfig.scaleWidth(17),
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
