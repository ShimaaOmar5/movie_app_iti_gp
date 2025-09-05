import 'auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;

  Future<AuthUser> signInWithEmail(String email, String password);
  Future<AuthUser> signUpWithEmail(String email, String password);
  Future<void> sendPasswordReset(String email);

  Future<AuthUser> signInWithGoogle();
  Future<AuthUser> signInWithApple();

  Future<void> signOut();
}

