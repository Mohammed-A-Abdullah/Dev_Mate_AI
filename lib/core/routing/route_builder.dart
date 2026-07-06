import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/features/auth/presentation/pages/auth_screen.dart';
import 'package:dev_mate_ai/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/pages/navigation_bar.dart';
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
      
    ],
  );
}
