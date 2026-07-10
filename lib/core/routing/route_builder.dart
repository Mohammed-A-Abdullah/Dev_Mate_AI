import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/features/auth/presentation/pages/auth_screen.dart';
import 'package:dev_mate_ai/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:dev_mate_ai/features/debug_code/presentation/pages/debug_code_screen.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/pages/explain_code_screen.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/pages/result_model_screen.dart';
import 'package:dev_mate_ai/features/generate_readme/presentation/pages/generate_readme_screen.dart';
import 'package:dev_mate_ai/features/generate_readme/presentation/pages/readme_result_screen.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/pages/navigation_bar.dart';
import 'package:dev_mate_ai/features/splash/presentation/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/presentation/pages/onboarding_screen.dart';

class RouteBuilder {
  static GoRouter goRouter = GoRouter(
    initialLocation: RouteName.navigationBar,
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

        builder: (context, state){
          final String responsData=state.extra as String;
          return  ResultModelScreen(data: responsData);
        }
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
      
    ],
  );
}
