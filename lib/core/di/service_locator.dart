import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:dev_mate_ai/core/services/url_launcher_service.dart';
import 'package:dev_mate_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dev_mate_ai/features/auth/data/datasources/firebase_auth_data_source.dart';
import 'package:dev_mate_ai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_in_github_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_in_google_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_in_guest_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/update_password_use_case.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/chat_screen/data/datasource/firebase_chat_data_source.dart';
import 'package:dev_mate_ai/features/chat_screen/data/repositories/chat_repository_impl.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/repositories/chat_repository.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/usecases/create_conversation_usecase.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/usecases/load_messages_usecase.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/usecases/save_message_usecase.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/usecases/send_message_usecase.dart';
import 'package:dev_mate_ai/features/chat_screen/presentation/cubit/chat_cubit.dart';
import 'package:dev_mate_ai/features/code_review/data/repositories/code_review_repository_impl.dart';
import 'package:dev_mate_ai/features/code_review/domain/repositories/code_review_repository.dart';
import 'package:dev_mate_ai/features/code_review/domain/usecases/code_review_use_case.dart';
import 'package:dev_mate_ai/features/code_review/presentation/cubit/code_review_cubit.dart';
import 'package:dev_mate_ai/features/debug_code/data/repositories/debug_code_repository_impl.dart';
import 'package:dev_mate_ai/features/debug_code/domain/repositories/debug_code_repository.dart';
import 'package:dev_mate_ai/features/debug_code/domain/usecase/debug_code_use_case.dart';
import 'package:dev_mate_ai/features/debug_code/presentation/cubit/debug_code_cubit.dart';
import 'package:dev_mate_ai/features/explain_code/data/repositories/explain_code_repository_impl.dart';
import 'package:dev_mate_ai/features/explain_code/domain/repositories/explain_code_repository.dart';
import 'package:dev_mate_ai/features/explain_code/domain/usecase/explain_code_use_case.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/cubit/explain_code_cubit.dart';
import 'package:dev_mate_ai/features/generate_readme/data/repositories/generate_readme_repository_impl.dart';
import 'package:dev_mate_ai/features/generate_readme/domain/repositories/generate_readme_repository.dart';
import 'package:dev_mate_ai/features/generate_readme/domain/usecases/generate_readme_use_case.dart';
import 'package:dev_mate_ai/features/generate_readme/presentation/cubit/readme_cubit.dart';
import 'package:dev_mate_ai/features/history/data/datasource/history_remote_data_source.dart';
import 'package:dev_mate_ai/features/history/data/datasource/history_remote_data_source_impl.dart';
import 'package:dev_mate_ai/features/history/data/repositories/history_repository_impl.dart';
import 'package:dev_mate_ai/features/history/domain/repository/history_repository.dart';
import 'package:dev_mate_ai/features/history/domain/usecases/get_history_use_case.dart';
import 'package:dev_mate_ai/features/history/presentation/cubit/history_cubit.dart';
import 'package:dev_mate_ai/features/home/data/repository/home_repository_impl.dart';
import 'package:dev_mate_ai/features/home/domain/repository/home_quick_tools_repository.dart';
import 'package:dev_mate_ai/features/home/presentation/cubit/home_cubit.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/cubit/navigation_bar_cubit.dart';
import 'package:dev_mate_ai/features/onboarding/presentation/constant/onboarding_const_data.dart';
import 'package:dev_mate_ai/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:dev_mate_ai/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:dev_mate_ai/features/profile/data/datasource/profile_remote_data_source_impl.dart';
import 'package:dev_mate_ai/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:dev_mate_ai/features/profile/domain/useccases/change_password_use_case.dart';
import 'package:dev_mate_ai/features/profile/domain/useccases/delete_account_use_case.dart';
import 'package:dev_mate_ai/features/profile/domain/useccases/update_photo_use_case.dart';
import 'package:dev_mate_ai/features/profile/domain/useccases/update_profile_details_use_case.dart';
import 'package:dev_mate_ai/features/project_planner/data/repositories/project_plan_repository_impl.dart';
import 'package:dev_mate_ai/features/project_planner/domain/repositories/i_project_plan_repository.dart';
import 'package:dev_mate_ai/features/project_planner/domain/usecases/generate_plan_usecase.dart';
import 'package:dev_mate_ai/features/project_planner/presentation/cubit/project_plan_cubit.dart';
import 'package:dev_mate_ai/features/splash/data/datasources/splash_local_data_source.dart';
import 'package:dev_mate_ai/features/splash/data/datasources/splash_local_data_source_impl.dart';
import 'package:dev_mate_ai/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:dev_mate_ai/features/splash/domain/repositories/splash_repository.dart';
import 'package:dev_mate_ai/features/splash/domain/usecases/check_onboarding.dart';
import 'package:dev_mate_ai/features/splash/domain/usecases/is_authentecated_use_case.dart';
import 'package:dev_mate_ai/features/splash/domain/usecases/save_onboarding_completed.dart';
import 'package:dev_mate_ai/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/useccases/get_profile_use_case.dart';
import '../../features/profile/domain/useccases/logout_use_case.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //gemini service
  sl.registerLazySingleton<GeminiService>(() => GeminiService());
  //firestore
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  //fire_auth
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //home page sl
  sl.registerLazySingleton<HomeRepositoryImpl>(() => HomeRepositoryImpl());
  sl.registerLazySingleton<HomeQuickToolsRepository>(() => HomeRepositoryImpl());
  sl.registerFactory(() => HomeCubit(repository: sl()));  

  //auth sl
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => FirebaseAuthDataSource(),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl()),
  );
  sl.registerLazySingleton<CheckAuthStatusUseCase>(
    () => CheckAuthStatusUseCase(sl()),
  );
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl()));
  sl.registerLazySingleton<SignInGoogleUseCase>(
    () => SignInGoogleUseCase(sl()),
  );
  sl.registerLazySingleton<SignInGithubUseCase>(
    () => SignInGithubUseCase(sl()),
  );
  sl.registerLazySingleton<SignInGuestUseCase>(() => SignInGuestUseCase(sl()));
  sl.registerLazySingleton<SendEmailVerificationUseCase>(
    () => SendEmailVerificationUseCase(sl()),
  );
  sl.registerLazySingleton<ResetPasswordUsecase>(
    () => ResetPasswordUsecase(repository: sl()),
  );
  sl.registerLazySingleton<GetCurrentUserUseCase>(()=>GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton<UpdatePasswordUseCase>(()=>UpdatePasswordUseCase(repository: sl()));

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      checkAuthStatusUseCase: sl(),
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
      googleUseCase: sl(),
      githubUseCase: sl(),
      guestUseCase: sl(),
      sendEmailVerificationUseCase: sl(),
      resetPasswordUsecase: sl(),
      getCurrentUserUseCase: sl(),
      updatePasswordUseCase: sl(),
    ),
  );

  //chat page sl

  sl.registerLazySingleton<FirebaseChatDataSource>(
    () => FirebaseChatDataSource(firestore: sl()),
  );

  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(gemnini: sl(), firebase: sl()),
  );
  sl.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SaveMessageUsecase>(
    () => SaveMessageUsecase(repository: sl()),
  );
  sl.registerLazySingleton<CreateConversationUseCase>(
    () => CreateConversationUseCase(repository: sl()),
  );
  sl.registerLazySingleton<LoadMessagesUsecase>(
    () => LoadMessagesUsecase(repository: sl()),
  );
  sl.registerFactory<ChatCubit>(
    () => ChatCubit(
      sendMessageUsecase: sl(),
      saveMessageUsecase: sl(),
      createConversationUseCase: sl(),
      loadMessagesUsecase: sl(),
    ),
  );

  // code review
  sl.registerLazySingleton<CodeReviewRepository>(
    () => CodeReviewRepositoryImpl(geminiService: sl()),
  );
  sl.registerLazySingleton<CodeReviewUseCase>(
    () => CodeReviewUseCase(repository: sl()),
  );
  sl.registerFactory<CodeReviewCubit>(
    () => CodeReviewCubit(reviewCodeUseCase: sl()),
  );

  // debug code
  sl.registerLazySingleton<DebugCodeRepository>(
    () => DebugCodeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<DebugCodeUseCase>(
    () => DebugCodeUseCase(repository: sl()),
  );
  sl.registerFactory<DebugCubit>(() => DebugCubit(debugCodeUseCase: sl()));

  // explain code
  sl.registerLazySingleton<ExplainCodeRepository>(
    () => ExplainRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ExplainCodeUseCase>(
    () => ExplainCodeUseCase(repository: sl()),
  );
  sl.registerFactory<ExplainCubit>(
    () => ExplainCubit(explainCodeUseCase: sl()),
  );

  // generate README
  sl.registerLazySingleton<GenerateReadmeRepository>(
    () => ReadmeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GenerateReadmeUseCase>(
    () => GenerateReadmeUseCase(sl()),
  );
  sl.registerFactory<ReadmeCubit>(
    () => ReadmeCubit(generateReadmeUseCase: sl()),
  );

  //project planner
  sl.registerLazySingleton<IProjectPlanRepository>(
    () => ProjectPlanRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GeneratePlanUseCase>(
    () => GeneratePlanUseCase(sl()),
  );
  sl.registerFactory<ProjectPlanCubit>(
    () => ProjectPlanCubit(generatePlanUseCase: sl()),
  );

  // history page
  sl.registerLazySingleton<HistoryRemoteDataSource>(
    () => HistoryRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  );
  sl.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GetHistoryUseCase>(() => GetHistoryUseCase(sl()));
  sl.registerFactory<HistoryCubit>(() => HistoryCubit(sl()));

  //navigation bar
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());

  // onboarding
  sl.registerLazySingleton<SaveOnboardingCompleted>(()=>SaveOnboardingCompleted(sl()));
  sl.registerLazySingleton<OnboardingConstData>(()=>OnboardingConstData());
  sl.registerFactory<OnboardingCubit>(() => OnboardingCubit(sl(),sl()));

  //splash page
  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(sl()));
  sl.registerLazySingleton<CheckOnboarding>(() => CheckOnboarding(sl()));
  sl.registerLazySingleton<IsAuthentecatedUseCase>(()=>IsAuthentecatedUseCase(repository: sl()));
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl(), sl(),isAuthentecatedUseCase:sl() ));

  //profile page
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(auth: sl(), firestore: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(repository: sl()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(repository: sl()),
  );
  sl.registerLazySingleton<UpdatePhotoUseCase>(() => UpdatePhotoUseCase(sl()));
  sl.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(sl()),
  );
  sl.registerLazySingleton<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateProfileDetailsUseCase>(()=>UpdateProfileDetailsUseCase(sl()));
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      sl(),
      sl(),
      updatePhotoUseCase: sl(),
      deleteAccountUseCase: sl(),
      changePasswordUseCase: sl(),
      updateProfileDetailsUseCase: sl(),
    ),
  );

  //url launcher
  sl.registerLazySingleton<UrlLauncherService>(() => UrlLauncherService());
}
