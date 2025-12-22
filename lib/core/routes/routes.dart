import 'package:chat_app/domain/entity/user_model.dart';
import 'package:chat_app/presentation/screens/auth/add_profile_photo.dart';
import 'package:chat_app/presentation/screens/chat/all_chat_list_screen.dart';
import 'package:chat_app/presentation/screens/chat/chat_list_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/auth/sign_in_screen.dart';
import '../../presentation/screens/auth/sign_up_screen.dart';
import '../../presentation/screens/chat/chat_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../splash_screen.dart';
import '../../utils/app_constants.dart';

List<GoRoute> routes = [
  GoRoute(
    path: AppRoutes.profileScreen,
    builder: (context, state) => const ProfileScreen(),
  ),
  GoRoute(
    path: AppRoutes.signUpScreen,
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    path: AppRoutes.signInScreen,
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    path: AppRoutes.splashScreen,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: AppRoutes.chatListScreen,
    builder: (context, state) {
      return ChatListScreen();
    },
  ),
  GoRoute(
    path: AppRoutes.chatScreen,
    name: AppRoutes.chatScreen,
    builder: (context, state) {
      final user = state.extra as UserModel;
      return ChatScreen(user: user);
    },
  ),
  GoRoute(
    path: AppRoutes.addProfilePhotoScreen,
    builder: (context, state) {
      return AddProfilePhoto();
    },
  ),
  GoRoute(
    path: AppRoutes.allChatScreen,
    builder: (context, state) => const AllChatListScreen(),
  ),
];
