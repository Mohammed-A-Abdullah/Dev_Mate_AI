import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl({required this.remote});

  @override
  Future<bool> isAuthenticated() {
    return remote.isAuthenticated();
  }

  @override
  Future<AuthUserEntity?> signIn({
    required String email,
    required String password,
  }) {
    return remote.signIn(email: email, password: password);
  }

  @override
  Future<AuthUserEntity?> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return remote.signUp(name: name, email: email, password: password);
  }

  @override
  Future<AuthUserEntity?> signInWithGoogle() {
    return remote.signInWithGoogle();
  }

  @override
  Future<AuthUserEntity?> signInWithGithub() {
    return remote.signInWithGithub();
  }

  @override
  Future<AuthUserEntity?> signInAnonymously() {
    return remote.signInAnonymously();
  }

  @override
  Future<void> sendEmailVerification() {
    return remote.sendEmailVerification();
  }

  @override
  Future<void> signOut() {
    return remote.signOut();
  }
}
