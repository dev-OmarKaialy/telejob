import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telejob/core/extensions/context_extensions.dart';
import 'package:telejob/core/extensions/widget_extensions.dart';
import 'package:telejob/core/services/shared_preferences_service.dart';
import 'package:telejob/core/utils/drop_down_widget.dart';
import 'package:telejob/core/utils/main_button.dart';
import 'package:telejob/core/utils/main_text_field.dart';
import 'package:telejob/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:telejob/features/home/presentation/bloc/home_bloc.dart';
import 'package:telejob/features/intro/presentation/pages/splash_screen.dart';
import 'package:telejob/features/profile/presentation/pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(IndexJobCategoriesEvent());
    context.read<HomeBloc>().add(const IndexWorkeresEvent());
    context.read<HomeBloc>().add(IndexRequestsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Create Request'),
        onPressed: () {
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return const CreateRequestDialog();
              });
        },
      ),
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Job Categories',
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            10.verticalSpace,
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return SizedBox(
                  height: .1.sh,
                  child: switch (state.indexJobs) {
                    CubitStatus.failed => Center(
                        child: MainButton(
                            text: 'Try Again',
                            onPressed: () {
                              context
                                  .read<HomeBloc>()
                                  .add(IndexJobCategoriesEvent());
                            }),
                      ),
                    CubitStatus.loading => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: context.primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 150.w,
                            height: 50.h,
                          )
                              .animate(
                                onComplete: (controller) => controller.repeat(),
                              )
                              .shimmer(
                                  color: Colors.cyan[50],
                                  duration: Durations.extralong4);
                        },
                      ),
                    CubitStatus.success => switch (state.categories.length) {
                        > 0 => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: context.primaryColor
                                    .withOpacity(index.isEven ? .6 : .4),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      state.categories[index].name!,
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: context
                                                  .scaffoldBackgroundColor),
                                    ),
                                  ),
                                ),
                              ).onTap(() {
                                showGeneralDialog(
                                    context: context,
                                    pageBuilder: (context, animation, _) {
                                      context.read<HomeBloc>().add(
                                          IndexWorkeresEvent(
                                              cateId:
                                                  state.categories[index].id!));
                                      return Scaffold(
                                        body: BlocBuilder<HomeBloc, HomeState>(
                                          builder: (context, state) {
                                            return switch (state.indexWorkers) {
                                              CubitStatus.failed => Center(
                                                  child: MainButton(
                                                      text: 'Try Again',
                                                      onPressed: () {
                                                        context
                                                            .read<HomeBloc>()
                                                            .add(
                                                                const IndexWorkeresEvent());
                                                      }),
                                                ),
                                              CubitStatus.loading =>
                                                ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: 5,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          color: context
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      width: 80.w,
                                                      height: 40.h,
                                                    )
                                                        .animate(
                                                          onComplete:
                                                              (controller) =>
                                                                  controller
                                                                      .repeat(),
                                                        )
                                                        .shimmer(
                                                            color:
                                                                Colors.cyan[50],
                                                            duration: Durations
                                                                .extralong4);
                                                  },
                                                ),
                                              CubitStatus.success => switch (
                                                    state.workers.length) {
                                                  > 0 => GridView.builder(
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              childAspectRatio:
                                                                  2.3),
                                                      itemCount:
                                                          state.workers.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                          color: context
                                                              .primaryColor
                                                              .withOpacity(
                                                                  index.isEven
                                                                      ? .6
                                                                      : .4),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child: Text(
                                                                state
                                                                    .workers[
                                                                        index]
                                                                    .name!,
                                                                style: context
                                                                    .textTheme
                                                                    .titleMedium
                                                                    ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: context
                                                                            .scaffoldBackgroundColor),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  _ => const Center(
                                                      child: Text(
                                                          'There Is No Workers Available'),
                                                    )
                                                },
                                              _ => const SizedBox(),
                                            };
                                          },
                                        ),
                                      );
                                    }).then((v) {
                                  context
                                      .read<HomeBloc>()
                                      .add(const IndexWorkeresEvent());
                                });
                              });
                            },
                          ),
                        _ => const SizedBox()
                      },
                    _ => const SizedBox(),
                  },
                );
              },
            ),
            20.verticalSpace,
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Popular Workers',
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            10.verticalSpace,
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return SizedBox(
                  height: .1.sh,
                  child: switch (state.indexWorkers) {
                    CubitStatus.failed => Center(
                        child: MainButton(
                            text: 'Try Again',
                            onPressed: () {
                              context
                                  .read<HomeBloc>()
                                  .add(const IndexWorkeresEvent());
                            }),
                      ),
                    CubitStatus.loading => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: context.primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 80.w,
                            height: 40.h,
                          )
                              .animate(
                                onComplete: (controller) => controller.repeat(),
                              )
                              .shimmer(
                                  color: Colors.cyan[50],
                                  duration: Durations.extralong4);
                        },
                      ),
                    CubitStatus.success => switch (state.workers.length) {
                        > 0 => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.workers.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: context.primaryColor
                                    .withOpacity(index.isEven ? .6 : .4),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      state.workers[index].name!,
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: context
                                                  .scaffoldBackgroundColor),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        _ => const Center(
                            child: Text('There Is No Workers Available'),
                          )
                      },
                    _ => const SizedBox(),
                  },
                );
              },
            ),
            20.verticalSpace,
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Recent Jobs',
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            10.verticalSpace,
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return switch (state.indexRequests) {
                    CubitStatus.success => switch (state.request.length) {
                        > 0 => ListView.builder(
                            primary: false,
                            itemCount: state.request.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    width: 1.sw,
                                    height: .2.sh,
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                        color: state.request[index].status ==
                                                'Accepted'
                                            ? Colors.green[800]
                                            : state.request[index].status ==
                                                    'Rejected'
                                                ? Colors.red[800]
                                                : context.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Request Id: ',
                                              style: context
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                      color: context
                                                          .scaffoldBackgroundColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Text(
                                              state.request[index].id!
                                                  .substring(0, 5),
                                              style: context
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: context
                                                          .scaffoldBackgroundColor),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Worker Name: ',
                                              style: context
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: context
                                                          .scaffoldBackgroundColor),
                                            ),
                                            Text(
                                              '${state.request[index].worker!.name}',
                                              style: context
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: context
                                                          .scaffoldBackgroundColor),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Job Categories: ',
                                              style: context
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                      color: context
                                                          .scaffoldBackgroundColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Text(
                                              '${state.request[index].jobCategories!.map((e) => e.name)}',
                                              overflow: TextOverflow.ellipsis,
                                              style: context
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: context
                                                          .scaffoldBackgroundColor),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        _ => const Center(
                            child: Text('There Is No Data Yet'),
                          )
                      },
                    CubitStatus.failed => Center(
                        child: MainButton(
                            text: 'Try Again',
                            onPressed: () {
                              context
                                  .read<HomeBloc>()
                                  .add(IndexRequestsEvent());
                            })),
                    CubitStatus.loading => ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 1.sw,
                            height: .2.sh,
                            decoration: BoxDecoration(
                                color: context.primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                          )
                              .animate(
                                onComplete: (controller) => controller.repeat(),
                              )
                              .shimmer(
                                  duration: Durations.extralong4,
                                  color: Colors.cyan[50]);
                        },
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: 1.sw,
              alignment: Alignment.center,
              height: .3.sh,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.primaryColor),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/app_icon.jpeg',
                  width: 100.w,
                  height: 100.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            5.verticalSpace,
            const Divider(),
            ListTile(
              leading: SvgPicture.asset('assets/icons/person.svg'),
              title: const Text(
                'Profile',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
              },
            ),
            const ListTile(
              leading: Icon(Icons.edit_note),
              title: Text(
                'Reports',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              onTap: () async {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog.adaptive(
                    title: const Text('Are You Sure?'),
                    content: const Text(''),
                    actions: [
                      MainButton(
                          text: 'no',
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      MainButton(
                          text: 'Yes',
                          onPressed: () async {
                            SharedPreferencesService.logOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SplashScreen(),
                                ), (r) {
                              return false;
                            });
                          })
                    ],
                  ),
                );
              },
              title: const Text(
                'LogOut',
              ),
            ),
            const Spacer(),
            Text(
              'TeleJob App',
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Version 1.0.0',
              style: context.textTheme.bodySmall,
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class CreateRequestDialog extends StatefulWidget {
  const CreateRequestDialog({
    super.key,
  });

  @override
  State<CreateRequestDialog> createState() => _CreateRequestDialogState();
}

class _CreateRequestDialogState extends State<CreateRequestDialog> {
  final descriptionController = TextEditingController();
  final imagesController = TextEditingController();
  String? workerId;
  String? categoryId;
  List<String> images = [];
  @override
  Widget build(BuildContext context) {
    return Dialog(child: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.sendRequest == CubitStatus.success) {
          Navigator.pop(context);
        }
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              MainTextField(
                text: 'Description:',
                maxLines: 2,
                controller: descriptionController,
              ),
              15.verticalSpace,
              DropDownWidget(
                onChanged: (s) {
                  categoryId = s;
                },
                listenableValue: ValueNotifier<String?>(null),
                label: 'Job Category',
                items: state.categories
                    .map((e) => DropdownMenuItem(
                          value: e.id!,
                          child: Text(
                            e.name!,
                          ),
                        ))
                    .toList(),
              ),
              15.verticalSpace,
              DropDownWidget(
                listenableValue: ValueNotifier<String?>(null),
                label: 'Select Worker',
                onChanged: (s) {
                  workerId = s;
                },
                items: state.workers
                    .map((e) => DropdownMenuItem(
                          value: e.id!,
                          child: Text(
                            e.name!,
                          ),
                        ))
                    .toList(),
              ),
              15.verticalSpace,
              MainTextField(
                controller: imagesController,
                enabled: false,
                text: 'Choose Images(Optional):',
                prefixIcon: const Icon(
                  Icons.clear_rounded,
                ).onTap(() {
                  imagesController.clear();
                  images.clear();
                }),
              ).onTap(() async {
                ImagePicker().pickMultiImage(limit: 5).then((v) {
                  if (v.isNotEmpty) {
                    imagesController.text = '${v.length} Photos Selected';
                    images.addAll(v.map((e) {
                      return (e.path);
                    }));
                  }
                });
              }),
              Row(
                children: [
                  MainButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  MainButton(
                      text: 'Send',
                      onPressed: () {
                        print(images);
                        context.read<HomeBloc>().add(SendRequestEvent(params: {
                              'images': <String, String>{}..addEntries(
                                  images.map((e) =>
                                      MapEntry<String, String>('images', e))),
                              "body": {
                                "workerId": workerId!,
                                "JobCategories": categoryId!,
                                'jobDescription': descriptionController.text
                              }
                            }));
                      }),
                ],
              )
            ],
          ),
        );
      },
    ));
  }
}
