import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 20,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          backgroundColor: backgroundColor,
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: AppTexts.subTitleTextStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}
