import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telejob/core/utils/main_button.dart';
import 'package:telejob/core/utils/main_text_field.dart';
import 'package:telejob/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:telejob/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var textEditingController =
              TextEditingController(text: state.profile?.customer?.phone ?? '');
          var textEditingController2 = TextEditingController(
              text: state.profile?.customer?.address ?? '');
          var textEditingController3 =
              TextEditingController(text: state.profile?.customer?.name ?? '');
          return state.profileStatus == CubitStatus.failed
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainButton(
                          text: 'Try Again',
                          onPressed: () {
                            context.read<ProfileCubit>().getProfile();
                          })
                    ],
                  ),
                )
              : state.profileStatus == CubitStatus.success
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          MainTextField(
                            text: 'Name',
                            controller: textEditingController3,
                          ),
                          15.verticalSpace,
                          MainTextField(
                            text: 'Address',
                            controller: textEditingController2,
                          ),
                          15.verticalSpace,
                          MainTextField(
                            text: 'Phone',
                            controller: textEditingController,
                          ),
                          25.verticalSpace,
                          MainButton(
                              width: 1.sw,
                              fontSize: 16,
                              text: 'Edit Profile',
                              onPressed: () {
                                context.read<ProfileCubit>().updateProfile(
                                    textEditingController2.text,
                                    textEditingController.text,
                                    textEditingController3.text);
                              })
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
        },
      ),
    );
  }
}
