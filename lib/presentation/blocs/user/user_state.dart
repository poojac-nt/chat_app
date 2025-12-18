import 'package:chat_app/core/errors/failure.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserFetching extends UserState {}

class UserFetched extends UserState {
  final List<UserModel> users;
  const UserFetched(this.users);

  @override
  List<Object> get props => [users];
}

class UserFetchFailed extends UserState {
  final Failure failure;
  const UserFetchFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
