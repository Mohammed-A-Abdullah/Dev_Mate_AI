abstract class AuthRepository {
  Future<bool> isAuthenticated();
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String email, String password);
  Future<void> signOut();
}
