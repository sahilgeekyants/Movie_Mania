import 'package:flutter/material.dart';
// import 'package:movie_mania/services/local_db_services/boxes/recently_opened_movies_box.dart';
import 'package:movie_mania/utils/scale_config.dart';
import 'package:movie_mania/utils/widgets/custom_sliver_delegate.dart';
import 'movie_detail_bottom.dart';

class MovieDetail extends StatefulWidget {
  static const String routeName = '/movie_detail';
  final int id;
  final double rating;
  final String title;
  final String genres;
  final String moviePosterUrl;
  final String movieOverview;
  MovieDetail({
    @required this.id,
    @required this.rating,
    @required this.title,
    @required this.genres,
    @required this.moviePosterUrl,
    @required this.movieOverview,
  });
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class MovieDetailArguments {
  final int id;
  final double rating;
  final String title;
  final String genres;
  final String moviePosterUrl;
  final String movieOverview;
  MovieDetailArguments({
    @required this.id,
    @required this.rating,
    @required this.title,
    @required this.genres,
    @required this.moviePosterUrl,
    @required this.movieOverview,
  });
}

class _MovieDetailState extends State<MovieDetail> {
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    print('Recent Opened movies :');
    // RecentlyOpenedMoviesBox.openBox();
    // if (RecentlyOpenedMoviesBox.hasData()) {
    //   RecentlyOpenedMoviesBox.getAllMoviesSortedByTime().forEach((key, value) {
    //     print('$key : ${value.title}');
    //   });
    // }
  }

  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeScaleConfig.screenHeight,
          width: SizeScaleConfig.screenWidth,
          color: Colors.white,
        ),
        //Background Image
        Container(
          height: SizeScaleConfig.screenHeight * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.moviePosterUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        //Screen
        Scaffold(
          backgroundColor: Colors.transparent, //for BG image
          body: CustomScrollView(
            physics: ClampingScrollPhysics(),
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent, //for BG image
                elevation: 0, //for BG image
                pinned: true,
                expandedHeight: SizeScaleConfig.screenHeight * 0.45,
                collapsedHeight: SizeScaleConfig.screenHeight * 0.225, // half
                leading: IconButton(
                  padding: EdgeInsets.only(
                    top: scaleConfig.scaleHeight(10),
                    left: scaleConfig.scaleWidth(30),
                  ),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: scaleConfig.scaleWidth(40),
                  ),
                  onPressed: () {
                    print(
                        'Going back from Detail page- id:${widget.moviePosterUrl}');
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    padding: EdgeInsets.only(
                      top: scaleConfig.scaleHeight(10),
                      right: scaleConfig.scaleWidth(40),
                    ),
                    icon: Icon(
                      Icons.bookmark_outline_rounded,
                      color: Colors.white,
                      size: scaleConfig.scaleWidth(40),
                    ),
                    onPressed: () {
                      print(
                          'Bookmark pressed on page id:${widget.moviePosterUrl}');
                    },
                  ),
                ],
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: scaleConfig.scaleWidth(90)),
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          SizedBox(height: scaleConfig.scaleWidth(70)),
                          //Title in Fading Area
                          Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: scaleConfig.scaleWidth(30),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: scaleConfig.scaleWidth(10)),
                          Text(
                            'Runtime: 122 minutes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: scaleConfig.scaleWidth(18),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              //Scrollable body
              SliverPersistentHeader(
                delegate: CustomSliverDelegate(
                  maxHeight: SizeScaleConfig.screenHeight * 0.8,
                  minHeight: SizeScaleConfig.screenHeight * 0.4,
                  child: Stack(
                    children: [
                      //RoundedCornerRectangular body
                      Positioned(
                        right: 0,
                        left: 0,
                        top: (scaleConfig.scaleWidth(83) / 2),
                        child: Container(
                          height: SizeScaleConfig.screenHeight * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 0,
                                  blurRadius: 5),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: (scaleConfig.scaleWidth(83) / 2) + 5,
                              left: scaleConfig.scaleWidth(50),
                              right: scaleConfig.scaleWidth(60),
                            ),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 8,
                                        child: Text(
                                          widget.title,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                scaleConfig.scaleHeight(37),
                                            fontWeight: FontWeight.lerp(
                                              FontWeight.w300,
                                              FontWeight.w500,
                                              9,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(flex: 1, child: Container()),
                                    ],
                                  ),
                                  SizedBox(height: scaleConfig.scaleHeight(12)),
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Text(
                                          widget.genres,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                                scaleConfig.scaleHeight(18),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Flexible(flex: 2, child: Container()),
                                    ],
                                  ),
                                  SizedBox(height: scaleConfig.scaleHeight(12)),
                                  Text(
                                    'Runtime: 2h 2min',
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: scaleConfig.scaleHeight(18),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: scaleConfig.scaleHeight(30)),
                                  Text(
                                    widget.movieOverview,
                                    textScaleFactor: 1,
                                    maxLines: 12,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      height: 1.5,
                                      color: Colors.black54,
                                      fontSize: scaleConfig.scaleHeight(20),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Circular Icon Box
                      Positioned(
                        right: 0,
                        left: 0,
                        top: 0,
                        child: Container(
                          height: scaleConfig.scaleWidth(83),
                          width: scaleConfig.scaleWidth(83),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[600].withOpacity(0.4),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              print("Pressed play icon on details body");
                            },
                            padding:
                                EdgeInsets.all(scaleConfig.scaleHeight(8.0)),
                            iconSize: scaleConfig.scaleWidth(55),
                            icon: Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        //Fixed bottom
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: MovieDetailBottom(rating: widget.rating),
        )
      ],
    );
  }
}
