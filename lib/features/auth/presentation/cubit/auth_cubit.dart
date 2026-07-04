import 'package:bloc/bloc.dart';

import '../../domain/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());

  final AuthRepository authRepository;

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final authenticated = await authRepository.isAuthenticated();
    emit(authenticated ? AuthAuthenticated() : AuthUnauthenticated());
  }

  Future<void> submitSignIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final authenticated = await authRepository.signIn(email, password);

    if (authenticated) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthError('Incorrect email or password. Sign up first if needed.'));
    }
  }

  Future<void> submitSignUp({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    if (email.trim().isEmpty || password.trim().length < 6) {
      emit(
        AuthError(
          'Please enter a valid email and a password with at least 6 characters.',
        ),
      );
      return;
    }

    final created = await authRepository.signUp(email, password);

    if (created) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthError('We could not create your account right now.'));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    await authRepository.signOut();
    emit(AuthUnauthenticated());
  }
}
