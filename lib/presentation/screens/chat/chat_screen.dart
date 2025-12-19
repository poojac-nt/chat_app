import 'package:chat_app/core/firebase/firebase_auth_service.dart';
import 'package:chat_app/domain/entity/message_model.dart';
import 'package:chat_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entity/user_model.dart';
import '../../../utils/extensions/padding_extenstion.dart';

class ChatScreen extends StatelessWidget {
  final UserModel user;
  ChatScreen({super.key, required this.user});

  final List<MessageModel> messages = [
    MessageModel(id: "", senderId: "", text: "Hi", createdAt: DateTime.now()),
    MessageModel(id: "", senderId: "", text: "Hi", createdAt: DateTime.now()),
    MessageModel(id: "", senderId: "", text: "Hi", createdAt: DateTime.now()),
    MessageModel(id: "", senderId: "", text: "Hi", createdAt: DateTime.now()),
    MessageModel(id: "", senderId: "", text: "Hi", createdAt: DateTime.now()),
    MessageModel(id: "", senderId: "", text: "Hi", createdAt: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          titleSpacing: 0,
          toolbarHeight: 50.h,
          title: Row(
            children: [
              CircleAvatar(backgroundColor: Colors.grey),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(fontSize: 17.sp),
                    ),
                    Text('online', style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment:
                        FirebaseAuthService.currentUserId ==
                            messages[index].senderId
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 0.8.sw,
                      margin: EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
                      padding: EdgeInsets.symmetric(
                        vertical: 7.w,
                        horizontal: 13.w,
                      ),
                      decoration: BoxDecoration(
                        color:
                            FirebaseAuthService.currentUserId ==
                                messages[index].senderId
                            ? Colors.blue[300]
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: index % 2 == 0
                              ? Radius.zero
                              : Radius.circular(9.r),
                          topRight: Radius.circular(9.r),
                          bottomLeft: Radius.circular(9.r),
                          topLeft: index % 2 == 0
                              ? Radius.circular(9.r)
                              : Radius.zero,
                        ),
                      ),
                      child: Text(
                        "User message User message User message User message ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child:
                      TextField(
                        cursorColor: Colors.grey[500],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                          ),
                          hintText: "Start Typing....",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ).withPadding(
                        EdgeInsets.only(bottom: 15.w, left: 15.w, top: 7.h),
                      ),
                ),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Icon(Icons.send_rounded, color: Colors.white),
                ).withPadding(
                  EdgeInsets.only(
                    bottom: 15.w,
                    left: 15.w,
                    right: 15.w,
                    top: 8.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
