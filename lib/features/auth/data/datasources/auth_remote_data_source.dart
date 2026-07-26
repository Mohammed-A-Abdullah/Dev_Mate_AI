import '../../domain/entities/auth_user_entity.dart';

abstract class AuthRemoteDataSource {
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
  Future<AuthUserEntity?>getCurrentUser();

  Future<void> sendEmailVerification();
  Future<void> resetPassword({required String email});
  Future<void> updatePassword(String password);

  Future<void> signOut();
}
