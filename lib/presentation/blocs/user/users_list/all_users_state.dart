import 'package:chat_app/core/errors/failure.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/user_model.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListFetching extends UserListState {}

class UserListFetched extends UserListState {
  final List<UserModel> users;
  const UserListFetched(this.users);

  @override
  List<Object> get props => [users];
}

class UserListFetchFailed extends UserListState {
  final Failure failure;
  const UserListFetchFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
