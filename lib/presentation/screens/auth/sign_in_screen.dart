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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final tapRecognizer = TapGestureRecognizer();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _snackBarHelper = getIt<SnackBarHelper>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            _snackBarHelper.showSuccess("Logged In");
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
                Positioned(
                  left: 0,
                  right: 0,
                  height: 1.sh,
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: SimpleCirclePainter(
                      circles: [
                        Circle(
                          radius: 3,
                          xPos: 1,
                          yPos: 0.07,
                          fillColor: Colors.blue,
                        ),
                        Circle(
                          radius: 3,
                          xPos: 1,
                          yPos: 0.18,
                          fillColor: Colors.blue.shade300,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  height: 1.sh,
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: SimpleCirclePainter(
                      circles: [
                        Circle(
                          radius: 1,
                          xPos: 0.1,
                          yPos: 0.95,
                          fillColor: Colors.blue.shade300,
                        ),
                        Circle(
                          radius: 1,
                          xPos: 0.1,
                          yPos: 1.2,
                          fillColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 15.w,
                          right: 15.w,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 110.h),
                              TitleSubtitle(
                                title: AppConstants.welcomeBack,
                                subTitle: AppConstants.seeYouAgain,
                              ),
                              SizedBox(height: 80.h),
                              CustomTextField(
                                controller: emailController,
                                validator: Validator.validateEmail,
                                hintText: AppConstants.email,
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
                                isPassword: true, // ✅ Enable password mode
                              ),
                              //TODO:Implement Forgot Password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    AppConstants.forgotPassword,
                                    style: TextStyle(
                                      color: const Color(0xff535E5B),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              // Button
                              CustomButton(
                                text: AppConstants.signIn.toUpperCase(),
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      SignInEvent(
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
                                      text: AppConstants.dontHaveAnAccount,
                                    ),
                                    TextSpan(
                                      text: " create one",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: tapRecognizer
                                        ..onTap = () {
                                          context.go(AppRoutes.signUpScreen);
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
