import 'package:flutter/material.dart';
import 'package:movie_mania/models/db_data_models/movie_data_model.dart';
import 'package:movie_mania/models/ui_data_models/movie_result_model.dart';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/services/local_db_services/boxes/genre_box.dart';
import 'package:movie_mania/ui/movie_detail_screen/movie_detail.dart';
import 'package:movie_mania/utils/scale_config.dart';
import '../../app.dart';

class SmallSliderChild extends StatelessWidget {
  final int index;
  final MovieResultModel movie;
  SmallSliderChild({@required this.index, @required this.movie});
  //
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  @override
  Widget build(BuildContext context) {
    String _posterPath = Config.baseImageUrl + movie.posterPath;
    String _title = movie.title;
    String _genres = GenreBox.getGenreListString(movie.genreIds) ?? "";
    return Container(
      child: Image.network(
        _posterPath,
        fit: BoxFit.cover,
        width: scaleConfig.scaleWidth(120),
        height: scaleConfig.scaleHeight(160),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          return Container(
            padding: EdgeInsets.only(right: scaleConfig.scaleWidth(30)),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                //image
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    child: GestureDetector(
                      onTap: () async {
                        print('Image clicked index : $index');
                        //
                        navigatorKey.currentState.pushNamed(
                          MovieDetail.routeName,
                          arguments: MovieDetailArguments(
                            movieModel: MovieDataModel(
                              id: movie.id,
                              title: movie.title,
                              posterPath: movie.posterPath,
                              genreIds: movie.genreIds,
                              overview: movie.overview,
                              bookmarked: false,
                              lastOpened: DateTime.now(),
                              rating: movie.voteAverage,
                            ),
                          ),
                        );
                      },
                      child: child,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[600].withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                //Movie Title
                Container(
                  padding: EdgeInsets.only(
                      top: scaleConfig.scaleHeight(10),
                      bottom: scaleConfig.scaleHeight(5)),
                  margin: EdgeInsets.only(right: scaleConfig.scaleWidth(20)),
                  child: Text(
                    _title,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: scaleConfig.scaleWidth(22),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Movie Tags
                Container(
                  margin: EdgeInsets.only(right: scaleConfig.scaleWidth(50)),
                  child: Text(
                    _genres,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: scaleConfig.scaleWidth(17),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
