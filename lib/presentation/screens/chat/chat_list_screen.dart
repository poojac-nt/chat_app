import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/extensions/padding_extenstion.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('All Chats'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actionsPadding: EdgeInsets.only(right: 15.w),
        actions: [
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.profileScreen);
            },
            child: CircleAvatar(
              radius: 15.r,
              backgroundColor: Colors.grey[100],
              child: Icon(Icons.person, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            cursorColor: Colors.grey[500],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 1.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
            ),
          ).withPadding(EdgeInsets.symmetric(horizontal: 15.w)),
          SizedBox(height: 280.h),
          Text('Welcome !! Start a conversation.'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          context.pushReplacement(AppRoutes.chatListScreen);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
