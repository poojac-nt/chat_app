import 'package:chat_app/core/routes/app_router.dart';
import 'package:chat_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app/presentation/blocs/auth/auth_event.dart';
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

  FirebaseMessaging.instance.getToken().then((token) {
    if (token != null) {
      debugPrint("FCM Token: $token");
    }
  });
  setUpLocator(); // Initialize DI
  final authBloc = getIt<AuthBloc>()..add(AuthStarted());
  AppRouter.init(authBloc);
  runApp(
    ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [BlocProvider.value(value: authBloc)],
        child: MyApp(authBloc: authBloc),
      ),
    ),
  );
}
