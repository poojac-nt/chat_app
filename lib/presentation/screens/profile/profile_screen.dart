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
  Widget build(BuildContext context) {
    return Scaffold(
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
                                CircleAvatar(radius: 50.r),
                                Positioned(
                                  top: 66.h,
                                  left: 68.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 3.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                      size: 15.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "User name user name user name",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 140.w, top: 450.h),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SignOutEvent());
                        },
                        child: Text("Sign Out"),
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
