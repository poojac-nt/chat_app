import 'dart:ui';

import 'package:chat_app/core/routes/app_router.dart';
import 'package:chat_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app/presentation/blocs/auth/auth_event.dart';
import 'package:chat_app/presentation/blocs/conversations/conversation_bloc.dart';
import 'package:chat_app/presentation/blocs/message/message_bloc.dart';
import 'package:chat_app/presentation/blocs/user/user_bloc.dart';
import 'package:chat_app/presentation/blocs/user/users_list/all_users_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'core/di/di.dart';
import 'flavors/flavor_config.dart';

void initializeAndRunApp(Flavor flavor) async {
  FlavorConfig.initialize(flavor);
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp().then(
    (value) => debugPrint('Firebase Initialized'),
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
