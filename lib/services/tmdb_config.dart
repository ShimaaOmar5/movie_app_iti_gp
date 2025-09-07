import 'package:dio/dio.dart';

/// Centralized TMDB configuration and Dio factory.
///
/// Supports either v3 API key (query param) or v4 bearer token (Authorization header).
const String tmdbBaseUrl = 'https://api.themoviedb.org/3';

/// These are populated via --dart-define at build/run time.
/// Example:
/// flutter run --dart-define=TMDB_API_KEY=YOUR_KEY
/// flutter run --dart-define=TMDB_BEARER_TOKEN=YOUR_TOKEN
const String tmdbApiKey = String.fromEnvironment('TMDB_API_KEY', defaultValue: '');
const String tmdbBearerToken = String.fromEnvironment('TMDB_BEARER_TOKEN', defaultValue: '');

/// Creates a Dio client pre-configured for TMDB API access.
/// - If [bearerToken] (or env) is provided, it will be used via Authorization header.
/// - Else if [apiKey] (or env) is provided, it will be appended as `api_key` query param.
/// Throws if neither credential is provided when a request is made.
Dio createTmdbDio({String? apiKey, String? bearerToken}) {
  final String resolvedBearer = (bearerToken ?? tmdbBearerToken).trim();
  final String resolvedApiKey = (apiKey ?? tmdbApiKey).trim();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: tmdbBaseUrl,
      headers: <String, dynamic>{
        'Accept': 'application/json',
      },
    ),
  );

  // Attach credentials via interceptor for every request.
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        if (resolvedBearer.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $resolvedBearer';
        } else if (resolvedApiKey.isNotEmpty) {
          options.queryParameters = <String, dynamic>{
            'api_key': resolvedApiKey,
            ...options.queryParameters,
          };
        } else {
          // Neither credential present – fail fast with a helpful message.
          return handler.reject(
            DioException(
              requestOptions: options,
              error: 'TMDB credentials are missing. Provide TMDB_API_KEY or TMDB_BEARER_TOKEN via --dart-define.',
              type: DioExceptionType.badResponse,
            ),
          );
        }
        handler.next(options);
      },
    ),
  );

  return dio;
}

