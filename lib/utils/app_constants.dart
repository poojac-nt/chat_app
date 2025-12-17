import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppConstants {
  static const String onBoardingTitle = 'Get Started';
  static const String onBoardingSubTitle = 'Start with sign up or sign in';
  static const String signUp = 'Sign up';
  static const String signUpSubTitle = 'Hello! let\'s join with us';
  static const String signIn = 'Sign in';
  static const String welcomeBack = 'Welcome\nback';
  static const String seeYouAgain = 'Hey! Good to see you again';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String alreadyHaveAnAccount = 'Already have an account?';
  static const String dontHaveAnAccount = 'Don\'t have an account?';
  static const String forgotPassword = 'Forgot Password?';
}

abstract class AppColors {
  static const Color textColor = Color(0xff2D3244);
  static const Color hintColor = Color(0xffB9B9B9);
  static const Color scaffoldColor = Color(0xffF2F2F2);
}

abstract class AppRoutes {
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String profileScreen = '/profileScreen';
  static const String splashScreen = '/splashScreen';
}

abstract class AppTexts {
  static final TextStyle titleTextStyle = TextStyle(
    fontSize: 40.sp,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold, // Use the weight if specified in pubspec.yaml
  );
  static final TextStyle subTitleTextStyle = TextStyle(
    fontSize: 18.sp,
    color: AppColors.textColor,
    fontWeight: FontWeight.w600, // Use the weight if specified in pubspec.yaml
  );
  static final TextStyle hintTextStyle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.hintColor,
    fontWeight: FontWeight.w600, // Use the weight if specified in pubspec.yaml
  );
}
