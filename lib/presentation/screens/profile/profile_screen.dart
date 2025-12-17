import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/paint/wave_painter.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(size: Size.infinite, painter: WavePainter()),
          Padding(
            padding: EdgeInsets.only(top: 70.h),
            child: Align(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.yellowAccent[50],
                    radius: 50.r,
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
    );
  }
}
