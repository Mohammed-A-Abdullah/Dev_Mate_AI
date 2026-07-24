import '../../domain/entities/auth_user_entity.dart';

enum AuthAction {
  signIn,
  signUp,
  google,
  github,
  guest,
  resetPassword,
  checkStatus,
  signOut,
  updatePassword,
}

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  final AuthAction action;

  const AuthLoading(this.action);
}

class AuthAuthenticated extends AuthState {
  final AuthUserEntity user;

  const AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}
