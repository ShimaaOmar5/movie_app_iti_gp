// Helpers to build full TMDB image URLs from path segments.
// See https://developer.themoviedb.org/reference/configuration-details for sizes.

const String tmdbImageBase = 'https://image.tmdb.org/t/p/';

String posterUrl(String? path, {String size = 'w342'}) {
  if (path == null || path.isEmpty) return '';
  return '$tmdbImageBase$size$path';
}

String backdropUrl(String? path, {String size = 'w780'}) {
  if (path == null || path.isEmpty) return '';
  return '$tmdbImageBase$size$path';
}

