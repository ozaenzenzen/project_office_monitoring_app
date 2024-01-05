import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_office_monitoring_app/presentation/page/main_page.dart';
import 'package:project_office_monitoring_app/presentation/page/signin_page/signin_page.dart';
import 'package:project_office_monitoring_app/support/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool? isSignIn = false;
  bool? isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(360, 690),
      designSize: const Size(411, 869),
      // designSize: const Size(412, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        AppTheme.appThemeInit();
        return MaterialApp(
          title: 'Vehicle Management Log',
          theme: AppTheme.theme,
          // home: const MainPage()
          home: (isSignIn == true) ? const SignInPage() : const MainPage(),
        );
      },
    );
  }
}
