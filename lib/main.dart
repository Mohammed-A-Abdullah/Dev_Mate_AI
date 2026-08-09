import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/routing/route_builder.dart';
import 'package:dev_mate_ai/core/services/app_preferences.dart';
import 'package:dev_mate_ai/core/theme/dark_theme.dart';
import 'package:dev_mate_ai/core/theme/light_theme.dart';
import 'package:dev_mate_ai/core/theme/theme_cubit.dart';
import 'package:dev_mate_ai/firebase_options.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:dev_mate_ai/l10n/local_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await AppPreferences.initializeDefaults();
  await setupServiceLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 884),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeCubit()),
            BlocProvider(create: (_) => LocaleCubit()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return BlocBuilder<LocaleCubit, Locale>(
                builder: (context, locale) {
                  return MaterialApp.router(
                    locale: locale,
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    title: 'Dev Mate AI',
                    theme: LightTheme.theme,
                    darkTheme: DarkTheme.theme,
                    themeMode: themeMode,
                    debugShowCheckedModeBanner: false,
                    routerConfig: RouteBuilder.goRouter,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
