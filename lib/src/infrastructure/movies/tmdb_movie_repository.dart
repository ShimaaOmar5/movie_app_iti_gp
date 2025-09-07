import 'package:dio/dio.dart';

import '../../../services/tmdb_config.dart';
import '../../domain/movies/movie.dart';
import '../../domain/movies/movie_repository.dart';

class TmdbMovieRepository implements MovieRepository {
  TmdbMovieRepository({Dio? dio}) : _dio = dio ?? createTmdbDio();

  final Dio _dio;

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final Response<dynamic> response = await _dio.get('/movie/popular', queryParameters: <String, dynamic>{'page': page});
    final List<dynamic> results = (response.data as Map<String, dynamic>)['results'] as List<dynamic>;
    return results.map((dynamic json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<Movie> getDetails(int id) async {
    final Response<dynamic> response = await _dio.get('/movie/$id');
    return Movie.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<Movie>> search(String query, {int page = 1, bool includeAdult = false}) async {
    final Response<dynamic> response = await _dio.get('/search/movie', queryParameters: <String, dynamic>{
      'query': query,
      'page': page,
      'include_adult': includeAdult,
    });
    final List<dynamic> results = (response.data as Map<String, dynamic>)['results'] as List<dynamic>;
    return results.map((dynamic json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Movie>> getTrending({String mediaType = 'movie', String timeWindow = 'day', int page = 1}) async {
    final Response<dynamic> response = await _dio.get('/trending/$mediaType/$timeWindow', queryParameters: <String, dynamic>{'page': page});
    final List<dynamic> results = (response.data as Map<String, dynamic>)['results'] as List<dynamic>;
    return results.map((dynamic json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
  }
}

