import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../domain/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  StreamSubscription? _authSubscription;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpEvent>(_signUpEvent);
    on<SignInEvent>(_signInEvent);
    on<SignOutEvent>(_signOutEvent);
    on<AuthStarted>(_authStarted);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<AuthLoggedIn>((event, emit) {
      emit(Authenticated(message: "Logged In"));
    });

    on<AuthLoggedOut>((event, emit) {
      emit(UnAuthenticated());
    });
  }
  Future<void> _authStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    _authSubscription?.cancel();
    _authSubscription = authRepository.isAuthenticated().listen((
      isAuthenticated,
    ) {
      if (isAuthenticated) {
        add(AuthLoggedIn());
      } else {
        add(AuthLoggedOut());
      }
    });
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.resetPassword(event.email);
    result.fold(
      (failure) => emit(AuthError(message: failure)),
      (_) => emit(PasswordResetEmailSent()),
    );
  }

  Future<void> _signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await authRepository.signUp(
      event.name,
      event.email,
      event.password,
      event.profileImgUrl,
      event.fcmToken,
    );
    response.fold(
      (failure) => emit(AuthError(message: failure)),
      (message) => emit(Authenticated(message: message)),
    );
  }

  Future<void> _signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await authRepository.signIn(event.email, event.password);
    response.fold(
      (failure) => emit(AuthError(message: failure)),
      (message) => emit(Authenticated(message: message)),
    );
  }

  Future<void> _signOutEvent(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await authRepository.signOut();
    response.fold(
      (failure) => emit(SignOutError(message: failure)),
      (message) => emit(UnAuthenticated()),
    );
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
