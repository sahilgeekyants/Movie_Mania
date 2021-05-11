import 'package:flutter/material.dart';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/utils/scale_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    double imageheight = SizeScaleConfig.screenWidth * 0.45;
    double imageWidth = SizeScaleConfig.screenWidth * 0.3;
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
              String _posterPath =
                  Config.baseImageUrl + "/xGuOF1T3WmPsAcQEQJfnG7Ud9f8.jpg";
              return Container(
                // color: Colors.blue,
                margin: EdgeInsets.only(
                  right: cardHorizontalMargin / 2,
                  left: cardHorizontalMargin / 2,
                  top: cardTopMargin,
                ),
                height: screenWidth * 0.5,
                width: screenWidth - cardHorizontalMargin,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        // color: Colors.red,
                        height: screenWidth * 0.45,
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
                                height: screenWidth * 0.4,
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
                                          // color: Colors.orange,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: scaleConfig
                                                      .scaleWidth(5)),
                                              Text(
                                                "Berserker",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: scaleConfig
                                                      .scaleWidth(22),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: scaleConfig
                                                      .scaleWidth(4)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  RatingBarIndicator(
                                                    rating: 8.7 / 2,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: scaleConfig
                                                        .scaleWidth(22),
                                                    unratedColor: Colors.white,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: scaleConfig
                                                          .scaleWidth(8),
                                                      top: scaleConfig
                                                          .scaleWidth(4),
                                                    ),
                                                    child: Text(
                                                      "8.7",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .amberAccent[700],
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: scaleConfig
                                                            .scaleWidth(18),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(child: Container()),
                                              Text(
                                                "Action Thrill Sci-fi",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: scaleConfig
                                                      .scaleWidth(18),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: scaleConfig
                                                      .scaleWidth(4)),
                                              Text(
                                                "Director: John Walts",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: scaleConfig
                                                      .scaleWidth(18),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: scaleConfig
                                                      .scaleWidth(10)),
                                            ],
                                          ),
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
                                  color: Colors.black87,
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
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
