import 'package:chat_app/core/firebase/firebase_auth_service.dart';
import 'package:chat_app/domain/entity/user_model.dart';
import 'package:chat_app/presentation/blocs/conversations/conversation_bloc.dart';
import 'package:chat_app/presentation/blocs/conversations/conversation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/extensions/padding_extenstion.dart';
import '../../../utils/extensions/time_formatter.dart';
import '../../blocs/conversations/conversation_state.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    context.read<ConversationBloc>().add(GetConversationsEvent());
    super.initState();
  }

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
          BlocBuilder<ConversationBloc, ConversationState>(
            builder: (context, state) {
              if (state is ConversationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ConversationFetched) {
                final conversations = state.conversations;

                if (conversations.isEmpty) {
                  return const Center(
                    child: Text('Welcome !! Start a conversation.'),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final currentUserId = FirebaseAuthService.currentUserId;
                      final recieverId = conversations[index].participants
                          .firstWhere((uid) => uid != currentUserId);
                      final recieverName = conversations[index]
                          .participantsData[recieverId]['name'];

                      return ListTile(
                        onTap: () {
                          context.push(
                            AppRoutes.chatScreen,
                            extra: UserModel(
                              uid: recieverId,
                              name: recieverName,
                              email: 'email',
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          radius: 15.r,
                          backgroundColor: Colors.grey[100],
                          child: Icon(Icons.person, color: Colors.blue),
                        ),
                        title: Text(
                          recieverName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          conversations[index].lastMessage ?? '',
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          conversations[index].lastMessageAt?.toTime() ?? '',
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is ConversationFetchFailed) {
                return Center(child: Text(state.failure.message));
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          context.push(AppRoutes.allChatScreen);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
