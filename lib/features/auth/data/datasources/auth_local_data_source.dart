import 'package:dev_mate_ai/core/services/app_preferences.dart';

import '../../domain/entities/auth_user_entity.dart';
import 'auth_remote_data_source.dart';

class AuthLocalDataSource implements AuthRemoteDataSource {
  @override
  Future<bool> isAuthenticated() async {
    return AppPreferences.isAuthenticated();
  }

  @override
  Future<AuthUserEntity?> signIn({
    required String email,
    required String password,
  }) async {
    final storedEmail = await AppPreferences.getStoredEmail();
    final storedPassword = await AppPreferences.getStoredPassword();

    final isValid =
        storedEmail != null &&
        storedPassword != null &&
        email.trim().toLowerCase() == storedEmail.trim().toLowerCase() &&
        password == storedPassword;

    if (!isValid) {
      return null;
    }

    return AuthUserEntity(
      uid: 'local-user',
      email: storedEmail,
      displayName: 'DevMate User',
    );
  }

  @override
  Future<AuthUserEntity?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.trim().length < 6) {
      return null;
    }

    final saved = await AppPreferences.saveCredentials(
      email.trim().toLowerCase(),
      password,
    );

    if (!saved) {
      return null;
    }

    return AuthUserEntity(
      uid: 'local-user',
      email: email.trim().toLowerCase(),
      displayName: name.trim().isNotEmpty ? name.trim() : null,
    );
  }

  @override
  Future<void> signOut() async {
    await AppPreferences.clearAuth();
  }
}
