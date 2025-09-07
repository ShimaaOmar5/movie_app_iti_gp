import 'movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopular({int page = 1});

  /// mediaType: 'movie' | 'tv' | 'all'
  /// timeWindow: 'day' | 'week'
  Future<List<Movie>> getTrending({String mediaType = 'movie', String timeWindow = 'day', int page = 1});

  Future<List<Movie>> search(String query, {int page = 1, bool includeAdult = false});

  Future<Movie> getDetails(int id);
}

