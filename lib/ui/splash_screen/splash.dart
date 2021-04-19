import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_mania/app.dart';
import 'package:movie_mania/repository/movies_repository.dart';
import 'package:movie_mania/services/local_db_services/local_db_service_provider.dart';
import 'package:movie_mania/ui/home_screen/home.dart';
import 'package:movie_mania/utils/widgets/circularIndicator.dart';

class Splash extends StatefulWidget {
  static const String routeName = '/';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final MoviesRepository _repository = MoviesRepository();
  void navigationPage() {
    navigatorKey.currentState.pushReplacementNamed(Home.routeName);
  }

  appSetUp() async {
    // initialize local DB
    await LocalDBServiceProvider.initializeLocalDb();
    //Add Genre Data
    await _repository.fetchAndSaveGenreList();
    //Set Up Guest Session
    await _repository.setUpGuestSession();
    //
    //rate an movie here temporarily
    // await _repository.rateMovie(791373, 9.5);
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    await appSetUp();
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    //fix orientation for now
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CircularIndicator(),
      ),
    );
  }
}
