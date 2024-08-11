import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telejob/core/services/shared_preferences_service.dart';
import 'package:telejob/features/home/presentation/bloc/home_bloc.dart';
import 'package:telejob/features/intro/presentation/pages/splash_screen.dart';
import 'package:telejob/features/profile/presentation/cubit/profile_cubit.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await SharedPreferencesService.init();
  runApp(EasyLocalization(
    path: 'assets/tranlsations',
    supportedLocales: const [
      Locale('en'),
      Locale('ar'),
    ],
    startLocale: const Locale('en'),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        theme: ThemeData.light().copyWith(primaryColor: Colors.cyan),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: const SplashScreen(),
      ),
    );
  }
}
