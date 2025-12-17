import 'package:chat_app/presentation/screens/auth/sign_in_screen.dart';
import 'package:chat_app/presentation/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/paint/custom_painter.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions/padding_extenstion.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_title.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: SimpleCirclePainter(
              circles: [
                Circle(
                  radius: 2,
                  xPos: 0.3,
                  yPos: 0.75,
                  fillColor: Colors.blue.shade300,
                ),
                Circle(radius: 1, xPos: 0.8, yPos: 1, fillColor: Colors.blue),
                Circle(
                  radius: 1.6,
                  xPos: 1,
                  yPos: 0.9,
                  fillColor: Colors.blue.shade300,
                ),
              ],
            ),
          ),
          TitleSubtitle(
            title: AppConstants.onBoardingTitle,
            subTitle: AppConstants.onBoardingSubTitle,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  text: AppConstants.signUp.toUpperCase(),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  text: AppConstants.signIn.toUpperCase(),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                ),
              ],
            ).withPadding(EdgeInsets.only(bottom: 100.h)),
          ),
        ],
      ),
    );
  }
}
