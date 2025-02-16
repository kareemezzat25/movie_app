import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/cache.dart';
import 'package:movies_app/models/theme.dart';
import 'package:movies_app/views/forgetpassword.dart';
import 'package:movies_app/views/login.dart';
import 'package:movies_app/views/onboarding.dart';
import 'package:movies_app/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Cache.init();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: MoviesApp()));
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeLight.lightTheme,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            initialRoute: Cache.getEligibilty() == true
                ? LoginView.routeName
                : OnBoarding.routeName,
            routes: {
              OnBoarding.routeName: (context) => OnBoarding(),
              LoginView.routeName: (context) => LoginView(),
              SignUpView.routeName: (context) => SignUpView(),
              ForgetPasswordView.routeName: (context) => ForgetPasswordView()
            },
          );
        });
  }
}
