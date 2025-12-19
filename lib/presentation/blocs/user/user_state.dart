import 'package:chat_app/core/errors/failure.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserFetching extends UserState {}

class UserFetchFailed extends UserState {
  final Failure failure;
  const UserFetchFailed(this.failure);

  @override
  List<Object> get props => [failure];
}

class UserFetched extends UserState {
  final UserModel user;
  const UserFetched(this.user);
  @override
  List<Object> get props => [user];
}
