import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telejob/core/extensions/context_extensions.dart';
import 'package:telejob/core/extensions/validation.dart';
import 'package:telejob/core/utils/main_button.dart';
import 'package:telejob/core/utils/main_text_field.dart';
import 'package:telejob/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:telejob/features/auth/presentation/pages/register_screen.dart';
import 'package:telejob/features/home/presentation/pages/home_screen.dart';

import '../../../../core/utils/toaster.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == CubitStatus.loading) {
            Toaster.showLoading();
          } else {
            if (state.status == CubitStatus.success) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            }
            Toaster.closeLoading();
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    80.verticalSpace,
                    Text(
                      'Welcome Back!',
                      style: context.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    10.verticalSpace,
                    Text(
                      'Enter your email & password',
                      style: context.textTheme.bodyMedium,
                    ),
                    10.verticalSpace,
                    MainTextField(
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/email.svg',
                        width: 16.sp,
                        height: 16.sp,
                        fit: BoxFit.scaleDown,
                      ),
                      text: 'E-mail',
                      validator: (text) {
                        if (text != null && text.isValidEmail()) {
                          return null;
                        } else {
                          return 'Email Incorrect';
                        }
                      },
                      controller: emailController,
                      hint: 'example@mail.com',
                    ),
                    25.verticalSpace,
                    MainTextField(
                      validator: (text) {
                        if (text != null && text.isValidPassword()) {
                          return null;
                        } else {
                          return 'Password Should Be At Least 5 Characters';
                        }
                      },
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/password.svg',
                        width: 16.sp,
                        height: 16.sp,
                        fit: BoxFit.scaleDown,
                      ),
                      text: 'Password',
                      controller: passwordController,
                      hint: '********',
                      isPassword: true,
                    ),
                    10.verticalSpace,
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        child: Text(
                          'Forgot Password?',
                          style: context.textTheme.titleSmall
                              ?.copyWith(color: context.primaryColor),
                        ),
                      ),
                    ),
                    25.verticalSpace,
                    MainButton(
                        height: 60.h,
                        text: 'Login',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(LoginEvent(
                                email: emailController.text,
                                password: passwordController.text));
                          }
                        }),
                    25.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New User?', style: context.textTheme.bodyLarge),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ));
                            },
                            child: Text(
                              'Sign Up',
                              style: context.textTheme.bodyLarge
                                  ?.copyWith(color: context.primaryColor),
                            ))
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
