import 'package:bloc/bloc.dart';
import 'package:chat_app/core/di/di.dart';
import 'package:chat_app/domain/repository/user_repository.dart';
import 'package:logger/logger.dart';

import 'all_users_event.dart';
import 'all_users_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository userRepository;
  UserListBloc(this.userRepository) : super(UserListFetching()) {
    on<FetchAllUsers>(_onFetchAllUser);
  }
  Future<void> _onFetchAllUser(
    UserListEvent event,
    Emitter<UserListState> emit,
  ) async {
    emit(UserListFetching());
    final result = await userRepository.getAllUsers();
    result.fold(
      (failure) {
        getIt<Logger>().i(failure.message);
        emit(UserListFetchFailed(failure));
      },
      (users) {
        emit(UserListFetched(users));
      },
    );
  }
}
