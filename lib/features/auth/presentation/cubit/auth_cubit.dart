import 'package:bloc/bloc.dart';

import '../../domain/entities/auth_user_entity.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required CheckAuthStatusUseCase checkAuthStatusUseCase,
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
  }) : _checkAuthStatusUseCase = checkAuthStatusUseCase,
       _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _signOutUseCase = signOutUseCase,
       super(AuthInitial());

  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final authenticated = await _checkAuthStatusUseCase();
    emit(
      authenticated
          ? AuthAuthenticated(
              user: AuthUserEntity(uid: 'local-user', email: ''),
            )
          : AuthUnauthenticated(),
    );
  }

  Future<void> submitSignIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final user = await _signInUseCase(email: email, password: password);

    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthError('Incorrect email or password. Sign up first if needed.'));
    }
  }

  Future<void> submitSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    if (name.trim().isEmpty) {
      emit(AuthError('Please enter your name.'));
      return;
    }

    if (email.trim().isEmpty || password.trim().length < 6) {
      emit(
        AuthError(
          'Please enter a valid email and a password with at least 6 characters.',
        ),
      );
      return;
    }

    final user = await _signUpUseCase(
      name: name,
      email: email,
      password: password,
    );

    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthError('We could not create your account right now.'));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    await _signOutUseCase();
    emit(AuthUnauthenticated());
  }
}
