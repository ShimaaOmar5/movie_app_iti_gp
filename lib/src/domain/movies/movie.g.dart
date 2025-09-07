// GENERATED CODE - MANUAL STUB FOR RUNTIME. Use build_runner to regenerate.

part of 'movie.dart';

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    id: (json['id'] as num).toInt(),
    title: json['title'] as String?,
    originalTitle: json['original_title'] as String?,
    overview: json['overview'] as String?,
    posterPath: json['poster_path'] as String?,
    backdropPath: json['backdrop_path'] as String?,
    releaseDate: json['release_date'] as String?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: (json['vote_count'] as num?)?.toInt(),
    popularity: (json['popularity'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'release_date': instance.releaseDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'popularity': instance.popularity,
    };

