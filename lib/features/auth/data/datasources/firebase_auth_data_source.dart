import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/auth_user_entity.dart';
import 'auth_remote_data_source.dart';

class FirebaseAuthDataSource implements AuthRemoteDataSource {
  FirebaseAuthDataSource();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthUserEntity _mapUser(User user) {
    return AuthUserEntity(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      isAnonymous: user.isAnonymous,
    );
  }

  @override
  Future<bool> isAuthenticated() async {
    return _auth.currentUser != null;
  }

  @override
  Future<AuthUserEntity?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) return null;

      await user.updateDisplayName(name);

      await user.reload();

      await user.sendEmailVerification();

      return _mapUser(_auth.currentUser!);
    } on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    }
  }

  @override
  Future<AuthUserEntity?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user!.reload();

      final user = _auth.currentUser!;

      if (!user.emailVerified) {
        throw Exception('Please verify your email before signing in.');
      }

      return _mapUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    }
  }

  @override
  Future<AuthUserEntity?> signInWithGoogle() async {
    try {
      final UserCredential userCredential;

      if (kIsWeb || !_isMobile) {
        userCredential = await _auth.signInWithProvider(GoogleAuthProvider());
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) return null;

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        userCredential = await _auth.signInWithCredential(credential);
      }

      final User? user = userCredential.user;

      if (user == null) return null;

      return _mapUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    } catch (e) {
      throw Exception("Unexpected error during Google Sign-In: $e");
    }
  }

  @override
  Future<AuthUserEntity?> signInWithGithub() async {
    try {
      final provider = GithubAuthProvider();
      final credential = await _auth.signInWithProvider(provider);

      final user = credential.user;
      return user == null ? null : _mapUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    } catch (e) {
      throw Exception("Unexpected error during GitHub Sign-In: $e");
    }
  }

  bool get _isMobile {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  Future<AuthUserEntity?> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();
      final user = credential.user;

      return user == null ? null : _mapUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    } catch (e) {
      throw Exception('Unable to continue as guest: $e');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<void> signOut() async {
    if (_isMobile) {
      await GoogleSignIn().signOut();
    }
    await _auth.signOut();
  }

  String _firebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email already exists.';

      case 'invalid-email':
        return 'Invalid email address.';

      case 'weak-password':
        return 'Password is too weak.';

      case 'user-not-found':
        return 'User not found.';

      case 'wrong-password':
        return 'Wrong password.';

      case 'invalid-credential':
        return 'Invalid credentials.';

      case 'network-request-failed':
        return 'No internet connection.';

      case 'operation-not-allowed':
        return 'Guest access is not enabled for this app.';

      case 'too-many-requests':
        return 'Too many attempts. Try again later.';

      default:
        return e.message ?? 'Authentication failed.';
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<AuthUserEntity?> getCurrentUser() async {
    final user = _auth.currentUser;
    return user == null ? null : _mapUser(user);
  }

  @override
  Future<void> updatePassword(String password) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not found");
    }
    return await _auth.currentUser!.updatePassword(password);
  }
}
