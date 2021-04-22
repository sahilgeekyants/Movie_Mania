import 'package:hive/hive.dart';
part 'movie_data_model.g.dart';

@HiveType(typeId: 1)
class MovieDataModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String posterPath;
  @HiveField(3)
  final List<int> genreIds;
  @HiveField(4)
  final String overview;
  @HiveField(5)
  final bool bookmarked;
  @HiveField(6)
  final DateTime lastOpened;
  @HiveField(7)
  final double rating;

  MovieDataModel({
    this.id,
    this.title,
    this.posterPath,
    this.genreIds,
    this.overview,
    this.bookmarked,
    this.lastOpened,
    this.rating,
  });
}
