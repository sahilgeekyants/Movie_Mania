import 'package:flutter/material.dart';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/utils/scale_config.dart';

class Search extends StatefulWidget {
  static const String routeName = '/search';
  @override
  _SearchState createState() => _SearchState();
}

class SearchArguments {
  //
  SearchArguments();
}

class _SearchState extends State<Search> {
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  @override
  Widget build(BuildContext context) {
    double screenWidth = SizeScaleConfig.screenWidth;
    double imageheight = SizeScaleConfig.screenWidth * 0.41;
    double imageWidth = SizeScaleConfig.screenWidth * 0.27;
    double imageHorizontalPadding = SizeScaleConfig.screenWidth * 0.05;
    double cardHorizontalMargin = scaleConfig.scaleWidth(40);
    double cardTopMargin = scaleConfig.scaleWidth(25);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, id) {
              //path - /xGuOF1T3WmPsAcQEQJfnG7Ud9f8.jpg
              String _posterPath =
                  Config.baseImageUrl + "/xGuOF1T3WmPsAcQEQJfnG7Ud9f8.jpg";
              return Container(
                // color: Colors.blue,
                margin: EdgeInsets.only(
                  right: cardHorizontalMargin / 2,
                  left: cardHorizontalMargin / 2,
                  top: cardTopMargin,
                ),
                height: screenWidth * 0.45,
                width: screenWidth - cardHorizontalMargin,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        // color: Colors.red,
                        height: screenWidth * 0.4,
                        width: screenWidth - cardHorizontalMargin,
                        child: Stack(
                          children: [
                            //Lower Card
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                height: screenWidth * 0.33,
                                width: screenWidth - cardHorizontalMargin,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: scaleConfig.scaleWidth(20),
                                    bottom: scaleConfig.scaleWidth(20),
                                    right: scaleConfig.scaleWidth(20),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: imageWidth +
                                            (2 * imageHorizontalPadding),
                                      ),
                                      //Detail Body
                                      Expanded(
                                        child: Container(
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //icon bookmark
                            Positioned(
                              right: imageHorizontalPadding - 5,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  // state.isBookmarked ?
                                  // Icons.bookmark_outlined,
                                  Icons.bookmark_outline_rounded,
                                  // : Icons.bookmark_outline_rounded,
                                  color: Colors.lightBlue,
                                  size: scaleConfig.scaleWidth(45),
                                ),
                                onPressed: () {
                                  print("Pressed bookmark on search screen");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Image
                    Positioned(
                      left: imageHorizontalPadding,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          image: DecorationImage(
                            image: NetworkImage(_posterPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: imageheight,
                        width: imageWidth,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
