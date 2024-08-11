import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:telejob/core/extensions/context_extensions.dart';
import 'package:telejob/core/services/shared_preferences_service.dart';
import 'package:telejob/features/auth/presentation/pages/login_screen.dart';
import 'package:telejob/features/home/presentation/pages/home_screen.dart';
import 'package:telejob/features/intro/presentation/pages/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      final isFirst = SharedPreferencesService.getFirstTime();
      if (isFirst ?? true) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const TeleJobStartPage();
        }));
      } else {
        final isAuth = SharedPreferencesService.getToken();
        if (isAuth != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const LoginScreen();
          }));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset('assets/images/app_icon.jpeg')
              .animate()
              .fade(duration: Durations.long1)
              .shimmer(
                  color: Colors.grey.shade100,
                  delay: Durations.long1,
                  duration: Durations.extralong4),
        ),
      ),
    );
  }
}
