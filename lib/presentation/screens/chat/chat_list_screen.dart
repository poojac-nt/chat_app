import 'package:chat_app/domain/entity/user_model.dart';
import 'package:chat_app/domain/repository/user_repository.dart';
import 'package:chat_app/presentation/blocs/user/user_bloc.dart';
import 'package:chat_app/presentation/blocs/user/user_event.dart';
import 'package:chat_app/utils/app_constants.dart';
import 'package:chat_app/utils/extensions/padding_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/extensions/time_formatter.dart';
import '../../blocs/user/user_state.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(FetchUser());
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
            child: CircleAvatar(radius: 15.r),
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserFetched) {
            final users = state.users;
            debugPrint("Users :${users[0].lastseen}");
            return Column(
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
                    hint: Text(
                      'Search',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ).withPadding(EdgeInsets.symmetric(horizontal: 15.w)),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          context.push(
                            AppRoutes.chatScreen,
                            extra: users[index],
                          );
                        },
                        leading: CircleAvatar(),
                        title: Text(
                          users[index].name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          'Message Message Message Message Message',
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(users[index].lastseen!.toTime()),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is UserFetchFailed) {
            return Center(child: Text(state.failure.message));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
