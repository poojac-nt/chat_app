import 'package:chat_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app/presentation/blocs/auth/auth_event.dart';
import 'package:chat_app/presentation/blocs/auth/auth_state.dart';
import 'package:chat_app/presentation/screens/widgets/custom_button.dart';
import 'package:chat_app/presentation/screens/widgets/custom_textfield.dart';
import 'package:chat_app/utils/app_constants.dart';
import 'package:chat_app/utils/helper/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/di.dart';
import '../../../utils/validator.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _snackBarHelper = getIt<SnackBarHelper>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: AppColors.scaffoldColor,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetEmailSent) {
            _snackBarHelper.showSuccess(
              'Password reset link has been sent to your email.',
            );
            Navigator.of(context).pop();
          } else if (state is AuthError) {
            _snackBarHelper.showError(state.message.toString());
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter the email address associated with your account and we will send you a link to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  validator: Validator.validateEmail,
                  prefixIcon: const Icon(Icons.email),
                  borderRadius: 15,
                ),
                SizedBox(height: 30.h),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CustomButton(
                      text: 'Send Reset Link',
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            ForgotPasswordRequested(
                              _emailController.text.trim(),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
