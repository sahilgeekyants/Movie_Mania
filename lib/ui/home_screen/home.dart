import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_listing_events.dart';
import 'package:movie_mania/utils/scale_config.dart';
import 'home_app_bar.dart';
import 'home_bottom_navigation_bar.dart';
import 'popular_image_slider.dart';
import 'recent_image_slider.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MoviesBloc _moviesBloc;
  @override
  void initState() {
    super.initState();
    _moviesBloc = MoviesBloc();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //save values of scale config
    SizeScaleConfig().calculateScaleRatios(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final SizeScaleConfig scaleConfig = SizeScaleConfig();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => _moviesBloc,
      child: Stack(
        children: [
          Scaffold(
            appBar: HomeAppBar.getAppBar(),
            body: SafeArea(
              top: false,
              bottom: false,
              child: RefreshIndicator(
                displacement: scaleConfig.scaleHeight(80),
                strokeWidth: scaleConfig.scaleWidth(3),
                color: Colors.green,
                backgroundColor: Colors.black54,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2), () async {
                    _moviesBloc.dispatch(MoviesListingEvent.display);
                  });
                },
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: scaleConfig.scaleWidth(55),
                        top: scaleConfig.scaleHeight(20),
                        bottom: scaleConfig.scaleHeight(15),
                      ),
                      child: Text(
                        'Popular',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: scaleConfig.scaleWidth(23),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //Poplar Movies images
                    RecentImageSlider(),
                    //Popular section
                    SizedBox(height: scaleConfig.scaleHeight(40)),
                    PopularImageSlider(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeBottomNavigationBar(),
          )
        ],
      ),
    );
  }
}
