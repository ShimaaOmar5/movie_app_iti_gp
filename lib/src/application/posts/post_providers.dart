import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/posts/post.dart';
import '../../domain/posts/post_repository.dart';
import '../../infrastructure/posts/api_post_repository.dart';
import '../../infrastructure/posts/firestore_post_repository.dart';

final firestorePostRepoProvider = Provider<PostRepository>((ref) => FirestorePostRepository());
final apiPostRepoProvider = Provider<PostRepository>((ref) => ApiPostRepository());

final postsStreamProvider = StreamProvider<List<Post>>((ref) {
  final repo = ref.watch(firestorePostRepoProvider);
  return repo.watchPosts();
});

final postsApiFutureProvider = FutureProvider<List<Post>>((ref) {
  final repo = ref.watch(apiPostRepoProvider);
  return repo.fetchPostsFromApi();
});

