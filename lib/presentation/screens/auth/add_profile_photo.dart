import 'dart:io';

import 'package:chat_app/presentation/screens/widgets/custom_button.dart';
import 'package:chat_app/utils/extensions/padding_extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_constants.dart';

class AddProfilePhoto extends StatefulWidget {
  const AddProfilePhoto({super.key});

  @override
  State<AddProfilePhoto> createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  File? selectedImage;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Column(
          children: [
            SizedBox(height: 40.h),
            ContinuousAnimatedGradientText(
              text: "Add your profile photo",
              fontSize: 28.sp,
            ),
            SizedBox(height: 120.h),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 0,
                    blurRadius: 20,
                  ),
                ],
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 60.r,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : null,
                child: selectedImage == null
                    ? Icon(Icons.person, size: 60, color: Colors.blue)
                    : null,
              ),
            ),
            SizedBox(height: 200.h),
            CustomButton(
              text: "Add Photo",
              onTap: () async {
                await _pickImage();
              },
              backgroundColor: Colors.blue,
            ),
            SizedBox(height: 15.h),
            CustomButton(
              text: "Next ",
              onTap: () {
                context.go(AppRoutes.signUpScreen);
              },
            ),
          ],
        ).withPadding(EdgeInsets.symmetric(horizontal: 20.w)),
      ),
    );
  }
}

class ContinuousAnimatedGradientText extends StatefulWidget {
  final String text;
  final double fontSize;

  const ContinuousAnimatedGradientText({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  State<ContinuousAnimatedGradientText> createState() =>
      _ContinuousAnimatedGradientTextState();
}

class _ContinuousAnimatedGradientTextState
    extends State<ContinuousAnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // continuous loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1 + _controller.value * 2, 0),
              end: Alignment(1 + _controller.value * 2, 0),
              tileMode: TileMode.repeated, // 🔑 THIS IS THE KEY
              colors: const [
                Colors.white,
                Color(0xFF2196F3),
                Colors.white,
                Color(0xFF2196F3),
              ],
              stops: const [0.0, 0.25, 0.5, 0.75],
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600,
              color: Colors.white, // required
            ),
          ),
        );
      },
    );
  }
}
