import 'package:chat_app/utils/app_constants.dart';
import 'package:chat_app/utils/extensions/padding_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/extensions/time_formatter.dart';
import '../../blocs/user/user_state.dart';
import '../../blocs/user/users_list/all_users_bloc.dart';
import '../../blocs/user/users_list/all_users_event.dart';
import '../../blocs/user/users_list/all_users_state.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    context.read<UserListBloc>().add(FetchAllUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
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
        body: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is UserListFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserListFetched) {
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 1.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      hint: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
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
                          leading: CircleAvatar(
                            radius: 15.r,
                            backgroundColor: Colors.grey[100],
                            child: Icon(Icons.person, color: Colors.blue),
                          ),
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
            } else if (state is UserListFetchFailed) {
              return Center(child: Text(state.failure.message));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
