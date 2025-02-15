import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/theme.dart';
import 'package:movies_app/views/login.dart';
import 'package:movies_app/views/onboarding.dart';

void main() {
  runApp(MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            theme: ThemeLight.lightTheme,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            initialRoute: OnBoarding.routeName,
            routes: {
              OnBoarding.routeName: (context) => OnBoarding(),
              LoginView.routeName: (context) => LoginView()
            },
          );
        });
  }
}
