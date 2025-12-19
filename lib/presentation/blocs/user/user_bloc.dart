import 'package:bloc/bloc.dart';
import 'package:chat_app/core/di/di.dart';
import 'package:chat_app/domain/repository/user_repository.dart';
import 'package:chat_app/presentation/blocs/user/user_event.dart';
import 'package:chat_app/presentation/blocs/user/user_state.dart';

import 'package:logger/logger.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserFetching()) {
    on<FetchUser>(_onFetchUser);
  }

  Future<void> _onFetchUser(FetchUser event, Emitter<UserState> emit) async {
    emit(UserFetching());
    final result = await userRepository.getUserById(event.id);
    result.fold(
      (failure) {
        getIt<Logger>().i(failure.message);
        emit(UserFetchFailed(failure));
      },
      (user) {
        emit(UserFetched(user));
      },
    );
  }
}
