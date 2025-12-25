import 'package:chat_app/core/routes/app_router.dart';
import 'package:chat_app/domain/repository/auth_repository.dart';
import 'package:chat_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app/presentation/blocs/auth/auth_event.dart';
import 'package:chat_app/presentation/blocs/conversations/conversation_bloc.dart';
import 'package:chat_app/presentation/blocs/message/message_bloc.dart';
import 'package:chat_app/presentation/blocs/user/user_bloc.dart';
import 'package:chat_app/presentation/blocs/user/users_list/all_users_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp().then(
    (value) => debugPrint('Firebase Initialized'),
  );

  setUpLocator(); // Initialize DI
  final authBloc = getIt<AuthBloc>()..add(AuthStarted());
  AppRouter.init(authBloc);
  runApp(
    ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authBloc),
          BlocProvider(create: (context) => getIt<UserBloc>()),
          BlocProvider(create: (context) => getIt<UserListBloc>()),
          BlocProvider(create: (context) => getIt<MessageBloc>()),
          BlocProvider(create: (context) => getIt<ConversationBloc>()),
        ],
        child: MyApp(authBloc: authBloc),
      ),
    ),
  );
}
