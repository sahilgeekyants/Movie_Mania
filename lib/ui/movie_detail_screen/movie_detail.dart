import 'package:flutter/material.dart';
import 'package:movie_mania/utils/image_data.dart';
import 'package:movie_mania/utils/scale_config.dart';

class MovieDetail extends StatefulWidget {
  static const String routeName = '/movie_detail';
  final int movieId;
  MovieDetail({
    @required this.movieId,
  });
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class MovieDetailArguments {
  final int movieId;
  MovieDetailArguments({
    @required this.movieId,
  });
}

class _MovieDetailState extends State<MovieDetail> {
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  //image data temporary
  static final List<String> imageData = ImageData.getDestinationsData;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageData[widget.movieId]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        //Screen
        Scaffold(
          backgroundColor: Colors.transparent, //for BG image
          appBar: AppBar(
            backgroundColor: Colors.transparent, //for BG image
            elevation: 0, //for BG image
            // title: Text('NEW USER'),
            leading: IconButton(
              padding: EdgeInsets.only(
                top: scaleConfig.scaleHeight(20),
                left: scaleConfig.scaleWidth(30),
              ),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: scaleConfig.scaleWidth(40),
              ),
              onPressed: () {
                print('Going back from Detail page- id:${widget.movieId}');
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.only(
                  top: scaleConfig.scaleHeight(20),
                  right: scaleConfig.scaleWidth(40),
                ),
                icon: Icon(
                  Icons.bookmark_outline_rounded,
                  color: Colors.white,
                  size: scaleConfig.scaleWidth(40),
                ),
                onPressed: () {
                  print('Bookmark pressed on page id:${widget.movieId}');
                },
              ),
            ],
          ),
          body: Container(),
        ),
      ],
    );
  }
}
