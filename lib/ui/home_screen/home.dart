import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movies/movies_bloc.dart';
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
      child: Scaffold(
        appBar: HomeAppBar.getAppBar(),
        bottomNavigationBar: HomeBottomNavigationBar(),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              //Recent section
              Padding(
                padding: EdgeInsets.only(
                  left: scaleConfig.scaleWidth(55),
                  top: scaleConfig.scaleHeight(20),
                  bottom: scaleConfig.scaleHeight(15),
                ),
                child: Text(
                  'Recent',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: scaleConfig.scaleWidth(23),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //Recent images
              RecentImageSlider(),
              //Popular section
              SizedBox(height: scaleConfig.scaleHeight(40)),
              PopularImageSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
