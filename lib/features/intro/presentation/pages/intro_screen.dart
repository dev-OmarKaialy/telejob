import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telejob/core/extensions/context_extensions.dart';
import 'package:telejob/core/services/shared_preferences_service.dart';
import 'package:telejob/features/auth/presentation/pages/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/onboard.png',
              width: 1.sw,
              height: .45.sh,
              fit: BoxFit.cover,
            ),
            Text(
              'Find A Perfect Workers',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Finding The HQ Workers is more easire and faster with TeleJob',
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    foregroundColor: Colors.white,
                    textStyle: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    fixedSize: Size(.8.sw, 40.h)),
                icon: const Icon(Icons.arrow_forward_rounded),
                onPressed: () {
                  SharedPreferencesService.setFirstTime();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
                label: const Text('Let\'s Go'))
          ],
        ),
      ),
    );
  }
}
