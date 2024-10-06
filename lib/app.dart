import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/local/platform_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/remote/account_repository.dart';
import 'package:project_office_monitoring_app/data/repository/remote/platform_repository.dart';
import 'package:project_office_monitoring_app/presentation/page/home_page/bloc/home_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/main_page.dart';
import 'package:project_office_monitoring_app/presentation/page/profile_page/bloc/profile_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/signin_page/bloc/sign_in_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/signin_page/login_checker_bloc/login_checker_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/signin_page/platform_activation_bloc/platform_activation_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/signin_page/platform_bloc/platform_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInBloc(
            AppAccountRepository(),
            AccountLocalRepository(),
            PlatformLocalRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => PlatformBloc(
            PlatformRepository(),
            AccountLocalRepository(),
            PlatformLocalRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            AccountLocalRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            AppAccountRepository(),
            AccountLocalRepository(),
            PlatformLocalRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => PlatformActivationBloc(
            AccountLocalRepository(),
          )..add(CheckIsActivationCodeActiveAction()),
        ),
        BlocProvider(
          create: (context) => LoginCheckerBloc(
            AccountLocalRepository(),
          )..add(CheckIsLoginAction()),
        ),
      ],
      child: ScreenUtilInit(
        // designSize: const Size(360, 690),
        designSize: const Size(411, 869),
        // designSize: const Size(412, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          AppTheme.appThemeInit();
          return BlocBuilder<LoginCheckerBloc, LoginCheckerState>(
            builder: (context, state) {
              if (state is LoginCheckerTrue) {
                // isSignIn = true;
                return MaterialApp(
                  title: 'Office Monitor App',
                  theme: AppTheme.theme,
                  home: const MainPage(),
                );
              } else {
                // isSignIn = false;
                return MaterialApp(
                  title: 'Office Monitor App',
                  theme: AppTheme.theme,
                  home: const SignInPage(),
                );
              }
              // return MaterialApp(
              //   title: 'Vehicle Management Log',
              //   theme: AppTheme.theme,
              //   // home: const MainPage()
              //   home: (isSignIn == true) ? const SignInPage() : const MainPage(),
              // );
            },
          );
        },
      ),
    );
  }
}
