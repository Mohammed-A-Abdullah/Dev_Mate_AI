import 'package:dev_mate_ai/core/services/app_preferences.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> isAuthenticated() async {
    return AppPreferences.isAuthenticated();
  }

  @override
  Future<bool> signIn(String email, String password) async {
    final storedEmail = await AppPreferences.getStoredEmail();
    final storedPassword = await AppPreferences.getStoredPassword();

    if (storedEmail == null || storedPassword == null) {
      return false;
    }

    return email.trim().toLowerCase() == storedEmail.trim().toLowerCase() &&
        password == storedPassword;
  }

  @override
  Future<bool> signUp(String email, String password) async {
    if (email.trim().isEmpty || password.trim().length < 6) {
      return false;
    }

    return AppPreferences.saveCredentials(email.trim().toLowerCase(), password);
  }

  @override
  Future<void> signOut() async {
    await AppPreferences.clearAuth();
  }
}
