import 'package:dio/dio.dart';

import '../../core/errors/app_exception.dart';
import '../../domain/posts/post.dart';
import '../../domain/posts/post_repository.dart';

class ApiPostRepository implements PostRepository {
  ApiPostRepository({Dio? dio, String? baseUrl}) : _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl ?? 'https://jsonplaceholder.typicode.com'));

  final Dio _dio;

  @override
  Future<List<Post>> fetchPostsFromApi() async {
    try {
      final res = await _dio.get('/posts');
      final data = res.data as List<dynamic>;
      return data.take(20).map((e) => Post(
            id: e['id'].toString(),
            title: e['title'] as String,
            body: e['body'] as String,
            authorId: (e['userId']?.toString()) ?? '0',
          )).toList();
    } on DioException catch (e) {
      throw NetworkException(e.message ?? 'Network error', cause: e);
    }
  }

  @override
  Stream<List<Post>> watchPosts() async* {
    yield const [];
  }

  @override
  Future<void> addPost(Post post) async {
    // POST to API if needed. Omitted in sample.
  }
}

