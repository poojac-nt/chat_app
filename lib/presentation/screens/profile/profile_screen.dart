import 'package:chat_app/core/firebase/firebase_auth_service.dart';
import 'package:chat_app/presentation/blocs/user/user_event.dart';
import 'package:chat_app/presentation/blocs/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/paint/wave_painter.dart';
import '../../../utils/app_constants.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/user/user_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<UserBloc>().add(
      FetchUser(id: FirebaseAuthService.currentUserId!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserFetched) {
            return PopScope(
              onPopInvokedWithResult: (didPop, result) {
                context.go(AppRoutes.chatListScreen);
              },
              child: SafeArea(
                bottom: true,
                top: false,
                child: Stack(
                  children: [
                    CustomPaint(size: Size.infinite, painter: WavePainter()),
                    Padding(
                      padding: EdgeInsets.only(top: 70.h),
                      child: Align(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black54,
                                        spreadRadius: -6,
                                        blurRadius: 50,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 60.r,
                                    backgroundColor: AppColors.scaffoldColor,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                      size: 70,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 82.h,
                                  left: 79.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                      size: 18.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 290.h,
                        right: 20.w,
                      ),
                      child: Column(
                        children: [
                          ProfileTile(
                            title: "Name",
                            subtitle: state.user.name,
                            prefixIcon: Icon(Icons.person),
                          ),
                          ProfileTile(
                            title: "Email",
                            subtitle: state.user.email,
                            prefixIcon: Icon(Icons.email),
                          ),
                          ProfileTile(
                            title: "Sign out",
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 16.w,
                            ),
                            prefixIcon: Icon(Icons.logout_rounded),
                            onTap: () {
                              context.read<AuthBloc>().add(SignOutEvent());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is UserFetchFailed) {
            return Center(child: Text(state.failure.message));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Icon prefixIcon;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;
  const ProfileTile({
    super.key,
    this.contentPadding,
    required this.title,
    this.subtitle,
    required this.prefixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                spreadRadius: 4,
                color: Colors.grey,
              ),
            ],
          ),
          padding: EdgeInsets.all(15.w),
          child: ListTile(
            onTap: onTap,
            contentPadding: contentPadding,
            leading: prefixIcon,
            title: Text(title),
            subtitle: subtitle != null ? Text(subtitle ?? '') : null,
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
