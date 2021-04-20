import 'package:flutter/material.dart';
import 'package:movie_mania/models/db_data_models/movie_data_model.dart';
import 'package:movie_mania/repository/movies_repository.dart';
import 'package:movie_mania/services/local_db_services/boxes/rated_movies_box.dart';
import 'package:movie_mania/ui/movie_detail_screen/rating_dialog.dart';
import 'package:movie_mania/utils/scale_config.dart';

class MovieDetailBottom extends StatefulWidget {
  // final int movieId;
  // final double rating;
  final MovieDataModel movieModel;
  MovieDetailBottom({
    // @required this.movieId,
    // @required this.rating,
    @required this.movieModel,
  });
  @override
  _MovieDetailBottomState createState() => _MovieDetailBottomState();
}

class _MovieDetailBottomState extends State<MovieDetailBottom> {
  bool _isRated;
  double _userRating;
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  TextEditingController controller;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    focusNode = FocusNode();
    _userRating = widget.movieModel.rating ?? 0.0;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isRated == null) {
      await RatedMoviesBox.openBox();
      double _newRating =
          await RatedMoviesBox.getMovieRating(widget.movieModel.id);
      print('in didChangeDependencies _newRating : $_newRating');
      setState(() {
        _userRating = (_newRating > -1 ? _newRating : _userRating) ?? 0.0;
        _isRated = _userRating > -1;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: scaleConfig.scaleWidth(120),
      color: Colors.white,
      child: Material(
        child: Container(
          margin: EdgeInsets.only(
            left: scaleConfig.scaleWidth(40),
            right: scaleConfig.scaleWidth(30),
            top: scaleConfig.scaleWidth(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: scaleConfig.scaleWidth(65),
                width: scaleConfig.scaleWidth(240),
                margin: EdgeInsets.only(
                  left: scaleConfig.scaleWidth(10),
                  right: scaleConfig.scaleWidth(10),
                ),
                child: GestureDetector(
                  onTap: () async {
                    print('Pressed onTap of movie bottom button');
                    controller.text = '';
                    focusNode.unfocus();
                    await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext _context) {
                        return RatingDialog(
                          controller: controller,
                          focus: focusNode,
                          onTap: (double value) async {
                            bool result = await MoviesRepository().rateMovie(
                              MovieDataModel(
                                id: widget.movieModel.id,
                                title: widget.movieModel.title,
                                posterPath: widget.movieModel.posterPath,
                                genreIds: widget.movieModel.genreIds,
                                overview: widget.movieModel.overview,
                                bookmarked: widget.movieModel.bookmarked,
                                lastOpened: widget.movieModel.lastOpened,
                                rating: value,
                              ),
                            );
                            if (result == true) {
                              double _newRating =
                                  await RatedMoviesBox.getMovieRating(
                                      widget.movieModel.id);
                              print(
                                  'after rating, _newRating : $_newRating, value: $value');
                              setState(() {
                                _userRating = _newRating;
                                _isRated = _userRating > -1;
                              });
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 0,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _isRated == true ? "RATED" : "RATE MOVIE",
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: scaleConfig.scaleWidth(20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: scaleConfig.scaleWidth(20),
                    right: scaleConfig.scaleWidth(15)),
                child: Stack(
                  children: [
                    SizedBox(
                      height: scaleConfig.scaleWidth(60),
                      width: scaleConfig.scaleWidth(60),
                      child: CircularProgressIndicator(
                        value: _userRating / 10,
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Text(
                          // "9.1",
                          _userRating.toStringAsFixed(1),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: scaleConfig.scaleWidth(20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
