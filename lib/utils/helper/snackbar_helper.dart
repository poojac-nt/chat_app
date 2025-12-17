import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarHelper {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  SnackBarHelper(this.scaffoldMessengerKey);

  void showError(String message) {
    _hideAndShowSnackBar(
      message,
      backgroundColor: Colors.red.shade300,
      duration: const Duration(seconds: 3),
    );
  }

  void showSuccess(String message) {
    _hideAndShowSnackBar(
      message,
      backgroundColor: Colors.blueAccent,
      duration: const Duration(seconds: 2),
    );
  }

  void _hideAndShowSnackBar(
    String message, {
    required Color backgroundColor,
    required Duration duration,
  }) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) {
      return;
    }

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 14.sp)),
        backgroundColor: backgroundColor,
        duration: duration,
        elevation: 12,
        dismissDirection: DismissDirection.horizontal,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }
}
