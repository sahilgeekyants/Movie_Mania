import 'package:flutter/material.dart';
import 'package:movie_mania/models/db_data_models/movie_data_model.dart';
import 'package:movie_mania/models/ui_data_models/movie_result_model.dart';
import 'package:movie_mania/services/config/config.dart';
import 'package:movie_mania/services/local_db_services/boxes/genre_box.dart';
import 'package:movie_mania/ui/movie_detail_screen/movie_detail.dart';
import 'package:movie_mania/utils/scale_config.dart';
import '../../app.dart';

class LargeSliderChild extends StatelessWidget {
  final int index;
  final MovieResultModel movie;
  final bool isCenterPage;
  LargeSliderChild({
    @required this.index,
    @required this.movie,
    @required this.isCenterPage,
  });
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
        width: scaleConfig.scaleWidth(320),
        height: scaleConfig.scaleHeight(isCenterPage ? 450 : 380),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          return Container(
            // color: Colors.yellowAccent,
            padding: EdgeInsets.only(right: scaleConfig.scaleWidth(20)),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                //image
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                    child: GestureDetector(
                      onTap: () async {
                        //allow to click only center page in recent section
                        if (isCenterPage) {
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
                        }
                      },
                      child: child,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[600].withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, isCenterPage ? 10 : 0),
                      ),
                    ],
                  ),
                ),
                //Movie Title
                Container(
                  padding: EdgeInsets.only(
                      top: scaleConfig.scaleHeight(15),
                      bottom: scaleConfig.scaleHeight(10)),
                  margin: EdgeInsets.only(right: scaleConfig.scaleWidth(75)),
                  child: Text(
                    _title,
                    maxLines: 1,
                    style: TextStyle(
                      color: isCenterPage ? Colors.black : Colors.grey[700],
                      fontSize: scaleConfig.scaleWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Movie Tags
                Container(
                  margin: EdgeInsets.only(right: scaleConfig.scaleWidth(140)),
                  child: Text(
                    _genres,
                    maxLines: 2,
                    style: TextStyle(
                      color: isCenterPage ? Colors.black45 : Colors.grey,
                      fontSize: scaleConfig.scaleWidth(18),
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
