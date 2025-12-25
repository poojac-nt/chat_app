import 'package:chat_app/core/firebase/firebase_auth_service.dart';
import 'package:chat_app/domain/entity/message_model.dart';
import 'package:chat_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entity/user_model.dart';
import '../../../utils/extensions/padding_extenstion.dart';
import '../../blocs/message/message_bloc.dart';
import '../../blocs/message/message_event.dart';
import '../../blocs/message/message_state.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final currentUserId = FirebaseAuthService.currentUserId;

  @override
  void initState() {
    context.read<MessageBloc>().add(GetMessagesEvent(widget.user.uid));
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

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
              CircleAvatar(
                radius: 19.r,
                backgroundColor: Colors.grey[100],
                child: Icon(Icons.person, color: Colors.blue),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
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
              child: BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
                  if (state is MessageSendFailed) {
                    return Center(child: Text(state.failure.message));
                  }
                  if (state is MessageReceived) {
                    final messages = state.messages;
                    if (messages.isEmpty) {
                      return const Center(child: Text('No messages yet'));
                    }
                    return ListView.builder(
                      itemCount: messages.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: messages[index].senderId == currentUserId
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: 0.8.sw,
                            margin: EdgeInsets.only(
                              top: 10.h,
                              left: 5.w,
                              right: 5.w,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 7.w,
                              horizontal: 13.w,
                            ),
                            decoration: BoxDecoration(
                              color: messages[index].senderId == currentUserId
                                  ? Colors.blue[300]
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight:
                                    messages[index].senderId == currentUserId
                                    ? Radius.zero
                                    : Radius.circular(9.r),
                                topRight: Radius.circular(9.r),
                                bottomLeft: Radius.circular(9.r),
                                topLeft:
                                    messages[index].senderId == currentUserId
                                    ? Radius.circular(9.r)
                                    : Radius.zero,
                              ),
                            ),
                            child: Text(
                              messages[index].content,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
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
                        controller: messageController,
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
                GestureDetector(
                  onTap: () {
                    if (messageController.text.isNotEmpty) {
                      context.read<MessageBloc>().add(
                        SendMessageEvent(
                          MessageModel(
                            senderId: FirebaseAuthService.currentUserId!,
                            receiverId: widget.user.uid,
                            content: messageController.text,
                            createdAt: DateTime.now(),
                            type: MessageType.text,
                          ),
                        ),
                      );
                      messageController.clear();
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child:
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
