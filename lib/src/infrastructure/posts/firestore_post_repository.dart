import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/posts/post.dart';
import '../../domain/posts/post_repository.dart';

class FirestorePostRepository implements PostRepository {
  FirestorePostRepository({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  CollectionReference<Post> get _posts => _db.collection('posts').withConverter<Post>(
        fromFirestore: (snap, _) => Post.fromJson({'id': snap.id, ...snap.data()!}),
        toFirestore: (post, _) => post.toJson(),
      );

  @override
  Stream<List<Post>> watchPosts() => _posts.orderBy('title').snapshots().map(
        (s) => s.docs.map((d) => d.data()).toList(),
      );

  @override
  Future<void> addPost(Post post) => _posts.doc(post.id).set(post);

  @override
  Future<List<Post>> fetchPostsFromApi() async {
    // No-op here; provided by ApiPostRepository. Consumers can compose both.
    return const [];
  }
}

