import 'post.dart';

abstract class PostRepository {
  Stream<List<Post>> watchPosts();
  Future<List<Post>> fetchPostsFromApi();
  Future<void> addPost(Post post);
}

