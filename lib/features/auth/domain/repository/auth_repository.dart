import '../entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<bool> isAuthenticated();

  Future<AuthUserEntity?> signIn({
    required String email,
    required String password,
  });

  Future<AuthUserEntity?> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthUserEntity?> signInWithGoogle();

  Future<AuthUserEntity?> signInWithGithub();

  Future<AuthUserEntity?> signInAnonymously();

  Future<void> sendEmailVerification();
  Future<void> resetPassword(String email);

  Future<void> signOut();
}
