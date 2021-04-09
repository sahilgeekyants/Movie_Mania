import 'package:flutter/material.dart';
import 'ui/home_screen/home.dart';
import 'ui/movie_detail_screen/movie_detail.dart';

class MyRouter {
  // static const String homeRoute = '/';
  // static const String movieDetailRoute = '/movie_detail';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Home.routeName:
        return MaterialPageRoute(builder: (context) => Home());
      case MovieDetail.routeName:
        final MovieDetailArguments args =
            settings.arguments as MovieDetailArguments;
        return MaterialPageRoute(
            builder: (context) => MovieDetail(movieId: args.movieId));
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
