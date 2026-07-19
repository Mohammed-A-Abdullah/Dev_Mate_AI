import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/features/auth/presentation/pages/auth_screen.dart';
import 'package:dev_mate_ai/features/auth/presentation/widgets/check_email_screen.dart';
import 'package:dev_mate_ai/features/auth/presentation/widgets/send_email_for_password.dart';
import 'package:dev_mate_ai/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:dev_mate_ai/features/code_review/presentation/pages/code_review_screen.dart';
import 'package:dev_mate_ai/features/debug_code/presentation/pages/debug_code_screen.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/pages/explain_code_screen.dart';
import 'package:dev_mate_ai/core/widgets/custom_ai_model_answer_screen.dart';
import 'package:dev_mate_ai/features/generate_readme/presentation/pages/generate_readme_screen.dart';
import 'package:dev_mate_ai/features/generate_readme/presentation/pages/readme_result_screen.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/pages/navigation_bar.dart';
import 'package:dev_mate_ai/features/profile/presentation/pages/notifications_screen.dart';
import 'package:dev_mate_ai/features/profile/presentation/pages/settings_screen.dart';
import 'package:dev_mate_ai/features/project_planner/presentation/pages/project_planner_screen.dart';
import 'package:dev_mate_ai/features/splash/presentation/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/presentation/pages/onboarding_screen.dart';

class RouteBuilder {
  static GoRouter goRouter = GoRouter(
    initialLocation: RouteName.splashScreen,
    routes: [
      GoRoute(
        name: RouteName.splashScreen,
        path: RouteName.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteName.chatScreen,
        path: RouteName.chatScreen,
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        name: RouteName.onboardingScreen,
        path: RouteName.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: RouteName.authScreen,
        path: RouteName.authScreen,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        name: RouteName.navigationBar,
        path: RouteName.navigationBar,
        builder: (context, state) => const CustomNavigationBar(),
      ),
      GoRoute(
        name: RouteName.explainCodeScreen,
        path: RouteName.explainCodeScreen,
        builder: (context, state) => const ExplainCodeScreen(),
      ),
      GoRoute(
        name: RouteName.ansewerEplainCode,
        path: RouteName.ansewerEplainCode,

        builder: (context, state) {
          final String responsData = state.extra as String;
          return CustomAiModelAnswerScreen(data: responsData);
        },
      ),
      GoRoute(
        name: RouteName.readmeResultScreen,
        path: RouteName.readmeResultScreen,

        builder: (context, state) {
          final String responsData = state.extra as String;
          return ReadmeResultScreen(readme: responsData);
        },
      ),
      GoRoute(
        name: RouteName.debugCodeScreen,
        path: RouteName.debugCodeScreen,
        builder: (context, state) => const DebugCodeScreen(),
      ),
      GoRoute(
        name: RouteName.generateReadmeScreen,
        path: RouteName.generateReadmeScreen,
        builder: (context, state) => const GenerateReadmeScreen(),
      ),
      GoRoute(
        name: RouteName.projectPlannerScreen,
        path: RouteName.projectPlannerScreen,
        builder: (context, state) => const ProjectPlannerScreen(),
      ),
      GoRoute(
        name: RouteName.codeReviewScreen,
        path: RouteName.codeReviewScreen,
        builder: (context, state) => const CodeReviewScreen(),
      ),
      GoRoute(
        name: RouteName.settingsScreen,
        path: RouteName.settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: RouteName.notificationsScreen,
        path: RouteName.notificationsScreen,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        name: RouteName.sendEmailForPassword,
        path: RouteName.sendEmailForPassword,
        builder: (context, state) =>  SendEmailForPassword(),
      ),
      GoRoute(
        name: RouteName.checkEmailScreen,
        path: RouteName.checkEmailScreen,
        
        builder: (context, state) {
          final String email =state.extra as String;
          return  CheckEmailScreen(email:email ,);
        } ,
      ),
    ],
  );
}
