import 'package:dev_mate_ai/features/auth/data/datasources/auth_remote_data_source.dart';

import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({AuthRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? AuthLocalDataSource();

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<bool> isAuthenticated() async {
    return _remoteDataSource.isAuthenticated();
  }

  @override
  Future<AuthUserEntity?> signIn({
    required String email,
    required String password,
  }) async {
    return _remoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<AuthUserEntity?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return _remoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
  }
}
