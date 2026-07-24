import 'package:dev_mate_ai/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/update_password_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/send_email_verification_usecase.dart';
import '../../domain/usecases/sign_in_google_usecase.dart';
import '../../domain/usecases/sign_in_guest_usecase.dart';
import '../../domain/usecases/sign_in_github_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.checkAuthStatusUseCase,
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.googleUseCase,
    required this.githubUseCase,
    required this.guestUseCase, required this.sendEmailVerificationUseCase, required this.resetPasswordUsecase, required this.getCurrentUserUseCase, required this.updatePasswordUseCase,
  }) : super(const AuthInitial());

  final CheckAuthStatusUseCase checkAuthStatusUseCase;

  final SignInUseCase signInUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;

  final SignUpUseCase signUpUseCase;

  final SignOutUseCase signOutUseCase;

  final SignInGoogleUseCase googleUseCase;

  final SignInGithubUseCase githubUseCase;

  final SignInGuestUseCase guestUseCase;

  final SendEmailVerificationUseCase sendEmailVerificationUseCase;
  final ResetPasswordUsecase resetPasswordUsecase;

  Future<void> checkAuthStatus() async {
    emit(const AuthLoading(AuthAction.checkStatus));

    try {
      final user = await getCurrentUserUseCase();

      if (user != null) {
        
          emit(AuthAuthenticated(user));
        
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(const AuthLoading(AuthAction.signIn));

    try {
      final user = await signInUseCase(email: email, password: password);

      if (user == null) {
        emit(const AuthError("Unable to login."));
        return;
      }

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading(AuthAction.signUp));

    try {
      final user = await signUpUseCase(
        name: name,
        email: email,
        password: password,
      );

      if (user == null) {
        emit(const AuthError("Unable to create account."));
        return;
      }

      emit(
        const AuthSuccess(
          "Verification email has been sent. Please verify your email before signing in.",
        ),
      );

      await signOutUseCase();

      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> googleSignIn() async {
    emit(const AuthLoading(AuthAction.google));

    try {
      final user = await googleUseCase();

      if (user == null) {
        emit(const AuthError("Google Sign-In cancelled."));
        return;
      }

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> githubSignIn() async {
    emit(const AuthLoading(AuthAction.github));

    try {
      final user = await githubUseCase();

      if (user == null) {
        emit(const AuthError("GitHub Sign-In cancelled."));
        return;
      }

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> guestSignIn() async {
    emit(const AuthLoading(AuthAction.guest));

    try {
      final user = await guestUseCase();

      if (user == null) {
        emit(const AuthError("Unable to continue as guest."));
        return;
      }

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  // Future<void> resendVerificationEmail() async {
  //   try {
  //     await sendEmailVerificationUseCase();

  //     emit(const AuthSuccess("Verification email sent."));
  //   } catch (e) {
  //     emit(AuthError(e.toString()));
  //   }
  // }

  Future<void> signOut() async {
    emit(const AuthLoading(AuthAction.signOut));

    try {
      await signOutUseCase();

      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(const AuthLoading(AuthAction.resetPassword));
    try {
      await resetPasswordUsecase.call(email);
      emit(const AuthSuccess("PASSWORD_RESET_EMAIL_SENT"));
    } catch (e) {
      emit(AuthError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> changePassword(String password) async {
    emit(const AuthLoading(AuthAction.updatePassword));

    try {
      await updatePasswordUseCase(password);

      emit(const AuthSuccess("Password updated successfully."));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
