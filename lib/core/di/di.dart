import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repository/auth_repository.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../utils/helper/snackbar_helper.dart';
import '../routes/app_router.dart';

final getIt = GetIt.instance;
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
void setUpLocator() {
  getIt.registerLazySingleton<SnackBarHelper>(
    () => SnackBarHelper(scaffoldMessengerKey),
  );
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(getIt<AuthRepository>()),
  );
}
