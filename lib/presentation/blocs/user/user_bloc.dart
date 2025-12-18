import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/repository/user_repository.dart';
import 'package:chat_app/presentation/blocs/user/user_event.dart';
import 'package:chat_app/presentation/blocs/user/user_state.dart';
import 'package:either_dart/either.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserFetching()) {
    on<FetchUser>(_onFetchUser);
  }
  Future<void> _onFetchUser(UserEvent event, Emitter<UserState> emit) async {
    emit(UserFetching());
    final result = await userRepository.getAllUsers();
    result.fold(
      (failure) => emit(UserFetchFailed(failure)),
      (users) => emit(UserFetched(users)),
    );
  }
}
