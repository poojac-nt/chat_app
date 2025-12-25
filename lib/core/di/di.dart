import 'package:chat_app/domain/repository/chat_repository.dart';
import 'package:chat_app/domain/repository/user_repository.dart';
import 'package:chat_app/presentation/blocs/message/message_bloc.dart';
import 'package:chat_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../domain/repository/auth_repository.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/user/users_list/all_users_bloc.dart';
import '../../utils/helper/snackbar_helper.dart';
import '../routes/app_router.dart';

final getIt = GetIt.instance;
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
void setUpLocator() {
  getIt.registerLazySingleton<Logger>(() => Logger());
  getIt.registerLazySingleton<SnackBarHelper>(
    () => SnackBarHelper(scaffoldMessengerKey),
  );
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl());
  getIt.registerLazySingleton<UserBloc>(
    () => UserBloc(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<UserListBloc>(
    () => UserListBloc(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<MessageBloc>(
    () => MessageBloc(getIt<ChatRepository>()),
  );
}
