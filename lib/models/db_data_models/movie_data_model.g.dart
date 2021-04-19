// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDataModelAdapter extends TypeAdapter<MovieDataModel> {
  @override
  final int typeId = 1;

  @override
  MovieDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDataModel(
      id: fields[0] as int,
      title: fields[1] as String,
      posterPath: fields[2] as String,
      genreIds: (fields[3] as List)?.cast<int>(),
      overview: fields[4] as String,
      bookmarked: fields[5] as bool,
      lastOpened: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MovieDataModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.genreIds)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.bookmarked)
      ..writeByte(6)
      ..write(obj.lastOpened);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
