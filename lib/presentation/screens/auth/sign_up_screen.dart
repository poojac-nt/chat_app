import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/di.dart';
import '../../../core/paint/custom_painter.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/extensions/padding_extenstion.dart';
import '../../../utils/helper/snackbar_helper.dart';
import '../../../utils/validator.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_title.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final tapRecognizer = TapGestureRecognizer();
  final _snackBarHelper = getIt<SnackBarHelper>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.scaffoldColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            _snackBarHelper.showError(state.message.toString());
          } else if (state is Authenticated) {
            context.go(AppRoutes.chatListScreen);
            _snackBarHelper.showSuccess(state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            bottom: true,
            child: Stack(
              children: [
                // 1. Background Layer (Top Circles)
                Positioned(
                  height: 1.sh,
                  right: 0,
                  left: 0,
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: SimpleCirclePainter(
                      circles: [
                        Circle(
                          radius: 1.1,
                          xPos: 0.1,
                          yPos: 0,
                          fillColor: Colors.white,
                        ),
                        Circle(
                          radius: 2,
                          xPos: 1,
                          yPos: 0.01,
                          fillColor: Colors.blue.shade300,
                        ),
                        Circle(
                          radius: 5,
                          xPos: 1.01,
                          yPos: 0.20,
                          fillColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
                // 2. Background Layer (Bottom Circles) - Moved here so it doesn't block inputs
                Positioned(
                  height: 1.sh,
                  left: 0,
                  right: 0,
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: SimpleCirclePainter(
                      circles: [
                        Circle(
                          radius: 1,
                          fillColor: Colors.blue,
                          xPos: 0.5,
                          yPos: 1.18,
                        ),
                        Circle(
                          radius: 3,
                          fillColor: Colors.blue.shade300,
                          xPos: 1,
                          yPos: 1.01,
                        ),
                      ],
                    ),
                  ),
                ),

                // 4. Main Content (Form & Button) - Consolidated with ConstrainedBox
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          right: 15.w,
                          left: 15.w,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 150.h),
                              TitleSubtitle(
                                title: AppConstants.signUp,
                                subTitle: AppConstants.signUpSubTitle,
                              ),
                              SizedBox(height: 80.h),
                              CustomTextField(
                                hintText: AppConstants.name,
                                borderRadius: 20.r,
                                prefixIcon: const Icon(Icons.person),
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                validator: Validator.validateEmail,
                                hintText: AppConstants.email,
                                controller: emailController,
                                borderRadius: 20.r,
                                prefixIcon: const Icon(Icons.email),
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                controller: passwordController,
                                validator: Validator.validatePassword,
                                hintText: AppConstants.password,
                                borderRadius: 20.r,
                                prefixIcon: const Icon(Icons.lock),
                                isPassword: true,
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                controller: confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                hintText: AppConstants.confirmPassword,
                                borderRadius: 20.r,
                                prefixIcon: const Icon(Icons.lock),
                                isPassword: true, // ✅ Enable password mode
                              ),
                              SizedBox(height: 80.h),
                              CustomButton(
                                text: AppConstants.signUp.toUpperCase(),
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  final isValid = formKey.currentState!
                                      .validate();
                                  if (isValid) {
                                    context.read<AuthBloc>().add(
                                      SignUpEvent(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 15.h),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppConstants.alreadyHaveAnAccount,
                                    ),
                                    TextSpan(
                                      text: " sign in",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: tapRecognizer
                                        ..onTap = () {
                                          context.go(AppRoutes.signInScreen);
                                        },
                                    ),
                                  ],
                                ),
                              ).withPadding(EdgeInsets.only(left: 60.w)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
