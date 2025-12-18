import 'package:chat_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';

import 'core/di/di.dart';
import 'core/routes/app_router.dart';

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  const MyApp({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey, // Connect Key
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Segeo Ui'),
      routerConfig: AppRouter.router,
    );
  }
}
