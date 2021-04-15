import 'package:flutter/material.dart';
import 'package:movie_mania/router.dart';
import 'ui/home_screen/home.dart';
import 'ui/splash_screen/splash.dart';

//Navigation key
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "MovieMania",
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: white,
      ),
      onGenerateRoute: MyRouter.generateRoute,
      // initialRoute: Home.routeName,
      initialRoute: Splash.routeName,
    );
  }
}
