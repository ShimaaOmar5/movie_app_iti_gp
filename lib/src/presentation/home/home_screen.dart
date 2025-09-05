import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth/auth_providers.dart';
import '../../application/posts/post_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authStateChangesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authRepositoryProvider).signOut();
              if (context.mounted) context.go('/signin');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: userAsync.when(
              data: (user) => Center(
                child: Text('Hello ${user?.displayName ?? user?.email ?? 'User'}'),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
          const Divider(),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final apiPosts = ref.watch(postsApiFutureProvider);
                return apiPosts.when(
                  data: (posts) => ListView.separated(
                    itemCount: posts.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) => ListTile(
                      title: Text(posts[i].title),
                      subtitle: Text(posts[i].body, maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('API Error: $e')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

