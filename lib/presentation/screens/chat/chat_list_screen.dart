import 'package:chat_app/utils/app_constants.dart';
import 'package:chat_app/utils/extensions/padding_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('All Chats'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            cursorColor: Colors.grey[500],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              hint: Text('Search', style: TextStyle(color: Colors.grey[500])),
            ),
          ).withPadding(EdgeInsets.symmetric(horizontal: 15.w)),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    context.pushNamed(AppRoutes.chatScreen);
                  },
                  leading: CircleAvatar(),
                  title: Text('User 1', overflow: TextOverflow.ellipsis),
                  subtitle: Text(
                    'Message Message Message Message Message',
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text('12:05'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
