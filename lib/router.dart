import 'package:flutter/material.dart';
import 'package:movie_mania/ui/splash_screen/splash.dart';
import 'ui/home_screen/home.dart';
import 'ui/movie_detail_screen/movie_detail.dart';

class MyRouter {
  // static const String homeRoute = '/';
  // static const String movieDetailRoute = '/movie_detail';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Splash.routeName:
        return MaterialPageRoute(builder: (context) => Splash());
      case Home.routeName:
        return MaterialPageRoute(builder: (context) => Home());
      case MovieDetail.routeName:
        final MovieDetailArguments args =
            settings.arguments as MovieDetailArguments;
        return MaterialPageRoute(
          builder: (context) => MovieDetail(
            id: args.id,
            rating: args.rating,
            title: args.title,
            genres: args.genres,
            moviePosterUrl: args.moviePosterUrl,
            movieOverview: args.movieOverview,
          ),
        );
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
