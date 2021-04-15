import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_mania/app.dart';
import 'package:movie_mania/services/config/shared_preference.dart';
import 'package:movie_mania/ui/home_screen/home.dart';
import 'package:movie_mania/utils/widgets/circularIndicator.dart';

class Splash extends StatefulWidget {
  static const String routeName = '/';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void navigationPage() {
    navigatorKey.currentState.pushReplacementNamed(Home.routeName);
  }

  void appSetUp() {
    //initialize shared Prefrence
    localStorage.setLocalStorage();
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    //fix orientation for now
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    appSetUp();
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
