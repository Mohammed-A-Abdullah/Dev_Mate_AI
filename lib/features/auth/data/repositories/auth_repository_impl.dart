import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({AuthLocalDataSource? localDataSource})
    : _localDataSource = localDataSource ?? AuthLocalDataSource();

  final AuthLocalDataSource _localDataSource;

  @override
  Future<bool> isAuthenticated() async {
    return _localDataSource.isAuthenticated();
  }

  @override
  Future<AuthUserEntity?> signIn({
    required String email,
    required String password,
  }) async {
    return _localDataSource.signIn(email: email, password: password);
  }

  @override
  Future<AuthUserEntity?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return _localDataSource.signUp(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _localDataSource.signOut();
  }
}
