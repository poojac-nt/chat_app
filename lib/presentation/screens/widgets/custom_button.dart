import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 20,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          backgroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: Text(text, style: AppTexts.subTitleTextStyle),
      ),
    );
  }
}
