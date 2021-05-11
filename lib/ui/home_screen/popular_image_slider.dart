import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_listing_states.dart';
import 'package:movie_mania/models/ui_data_models/movies_model.dart';
import 'package:movie_mania/ui/home_screen/small_slider_child.dart';
import 'package:movie_mania/utils/scale_config.dart';
import 'package:movie_mania/utils/widgets/circularIndicator.dart';
import 'package:movie_mania/utils/widgets/message.dart';

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
            return Message(message: fetchedState.errMsg, height: 200);
          } else if (state is MoviesLoadingState) {
            final MoviesLoadingState fetchedState = state;
            print("Slider- Progess State msg: ${fetchedState.msg}");
            return CircularIndicator(height: 100);
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
            height: scaleConfig.scaleHeight(350),
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
            return SmallSliderChild(index: _imageIndex, movie: item);
          }).toList(),
        ),
      ],
    );
  }
}
