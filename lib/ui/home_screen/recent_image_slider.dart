import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_listing_events.dart';
import 'package:movie_mania/blocs/movies/movies_listing_states.dart';
import 'package:movie_mania/models/ui_data_models/movies_model.dart';
import 'package:movie_mania/ui/home_screen/large_slider_child.dart';
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
            return LargeSliderChild(
              index: _imageIndex,
              movie: item,
              isCenterPage: _isCenterPage,
            );
          }).toList(),
        ),
      ],
    );
  }
}
