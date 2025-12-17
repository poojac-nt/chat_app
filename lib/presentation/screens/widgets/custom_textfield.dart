import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_constants.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final double borderRadius;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // ✅ State variable for obscuring text (mutable)
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // Initialize with the isPassword value
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.2, 5),
            blurRadius: 15,
            spreadRadius: 1,
            color: Colors.black12,
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _obscureText, // ✅ Use state variable
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTexts.hintTextStyle,
          filled: true,
          // ✅ Conditionally show visibility toggle OR custom suffixIcon
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // ✅ Toggle state variable
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.hintColor,
                  ),
                )
              : widget.suffixIcon, // ✅ Use custom suffixIcon if not password
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: widget.prefixIcon,
          ),
          prefixIconColor: AppColors.hintColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        ),
      ),
    );
  }
}
