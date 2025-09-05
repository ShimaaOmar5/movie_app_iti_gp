import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../domain/auth/auth_repository.dart';
import '../../domain/auth/auth_user.dart';
import '../../core/errors/app_exception.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({fb.FirebaseAuth? auth}) : _auth = auth ?? fb.FirebaseAuth.instance;

  final fb.FirebaseAuth _auth;

  AuthUser? _mapUser(fb.User? user) =>
      user == null ? null : AuthUser(uid: user.uid, email: user.email, displayName: user.displayName, photoUrl: user.photoURL);

  @override
  Stream<AuthUser?> get authStateChanges => _auth.authStateChanges().map(_mapUser);

  @override
  Future<AuthUser> signInWithEmail(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _mapUser(cred.user)!;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Authentication failed', cause: e);
    }
  }

  @override
  Future<AuthUser> signUpWithEmail(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _mapUser(cred.user)!;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Sign up failed', cause: e);
    }
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Reset password failed', cause: e);
    }
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw const AuthException('Google sign-in aborted');
      }
      final googleAuth = await googleUser.authentication;
      final credential = fb.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final cred = await _auth.signInWithCredential(credential);
      return _mapUser(cred.user)!;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Google sign-in failed', cause: e);
    }
  }

  @override
  Future<AuthUser> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      final oauth = fb.OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      final cred = await _auth.signInWithCredential(oauth);
      return _mapUser(cred.user)!;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Apple sign-in failed', cause: e);
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();
}

