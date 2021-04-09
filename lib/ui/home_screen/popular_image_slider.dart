import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_listing_states.dart';
import 'package:movie_mania/models/movies_model.dart';
import 'package:movie_mania/ui/movie_detail_screen/movie_detail.dart';
// import 'package:movie_mania/utils/image_data.dart';
import 'package:movie_mania/utils/scale_config.dart';

import '../../app.dart';

class PopularImageSlider extends StatefulWidget {
  @override
  _PopularImageSliderState createState() => _PopularImageSliderState();
}

class _PopularImageSliderState extends State<PopularImageSlider> {
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  //image data temporary
  // static final List<String> imageData = ImageData.getDestinationsData;
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
          if (state is MoviesUninitializedState) {
            print("Unintialised State");
            return Message(message: "Unintialised State");
          } else if (state is MoviesEmptyState) {
            print("No Players found");
            return Message(message: "No Players found");
          } else if (state is MoviesEmptyState) {
            print("Something went wrong");
            return Message(message: "Something went wrong");
          } else if (state is MoviesFetchingState) {
            print("Progess State");
            return Expanded(child: Center(child: CircularProgressIndicator()));
          } else {
            print("Displaying State");
            final stateAsPlayerFetchedState = state as MoviesFetchedState;
            final movies = stateAsPlayerFetchedState.movies;
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
            autoPlay: false,
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
          // items: imageData.map((item) {
          items: movies.results.map((item) {
            int _imageIndex = movies.results.indexOf(item);
            String posterPath =
                'https://image.tmdb.org/t/p/w185${item.poster_path}';
            return Container(
              child: Image.network(
                posterPath,
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
                                    moviePosterUrl: posterPath,
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
                          child: Text(
                            'Joker',
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
                          child: Text(
                            'Crime, Drama',
                            maxLines: 1,
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

class Message extends StatelessWidget {
  final String message;

  Message({this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          message,
          style: TextStyle(fontSize: 22.0, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
