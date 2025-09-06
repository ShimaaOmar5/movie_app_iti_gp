import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../presentation/auth/sign_in_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/onboarding/onboarding_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../application/auth/auth_providers.dart';

// Obtain the actual auth state stream
final appRouterProvider = Provider<GoRouter>((ref) {
  // Directly watch the StreamProvider's stream, not the AsyncValue
  final authStream = ref.read(authStateChangesProvider.stream);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    // Pass the authStream to refreshListenable wrapped by GoRouterRefreshStream
    refreshListenable: GoRouterRefreshStream(authStream),
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/signin',
        name: 'signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (context, state) {
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isAuthRoute = state.matchedLocation == '/signin';
      final isSplash = state.matchedLocation == '/';
      final userAsyncValue = ref.read(authStateChangesProvider);

      // Only proceed if userAsyncValue has data
      final user = userAsyncValue.value;

      if (isSplash) return null; // Splash will handle first redirect

      if (user == null) {
        if (isAuthRoute || isOnboarding) return null;
        return '/signin';
      }

      if (isAuthRoute) return '/home';

      return null;
    },
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListener = () => notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final VoidCallback notifyListener;
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
