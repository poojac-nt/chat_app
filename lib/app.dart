import 'package:flutter/material.dart';

import 'core/di/di.dart';
import 'core/routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey, // Connect Key
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Segeo Ui'),
      routerConfig: getIt<AppRouter>().router,
    );
  }
}
