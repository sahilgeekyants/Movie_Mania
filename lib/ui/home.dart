import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:movie_mania/utils/scale_config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // orfixientation for now
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          padding: EdgeInsets.only(left: scaleConfig.scaleWidth(35)),
          iconSize: scaleConfig.scaleWidth(45),
          icon: Icon(
            // Icons.movie_creation_rounded,
            // Icons.theaters_outlined,
            Icons.movie_filter_outlined,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: scaleConfig.scaleWidth(15)),
          child: Text(
            'Movie Mania',
            style: TextStyle(
              color: Colors.black87,
              fontSize: scaleConfig.scaleWidth(24),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: scaleConfig.scaleWidth(35)),
            iconSize: scaleConfig.scaleWidth(35),
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onPressed: () {
              print('Search button pressed');
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(),
      ),
    );
  }
}
